#!/usr/bin/env python3
"""
EG8145V5 Firmware Binary Analyzer
Uses Capstone (ARM disassembler) + pyelftools to analyze Huawei ONT firmware binaries.

Requirements:
    pip install capstone pyelftools

Usage:
    python3 disasm_arm_binary.py <binary_path> [--func <function_name>] [--strings] [--symbols]

Examples:
    python3 disasm_arm_binary.py lib/libhw_swm_dll.so --symbols
    python3 disasm_arm_binary.py lib/libhw_swm_dll.so --func HW_SWM_ChnlDownload
    python3 disasm_arm_binary.py lib/libhw_swm_dll.so --strings --filter upgrade
    python3 disasm_arm_binary.py lib/libhw_swm_dll.so --func-all-upgrade
"""

import argparse
import sys
from capstone import Cs, CS_ARCH_ARM, CS_MODE_ARM, CS_MODE_THUMB
from elftools.elf.elffile import ELFFile
from elftools.elf.sections import SymbolTableSection


def get_elf_info(filepath):
    """Extract ELF metadata, sections, and symbols."""
    info = {"sections": {}, "symbols": {}}
    with open(filepath, 'rb') as f:
        elf = ELFFile(f)
        info["arch"] = elf.header.e_machine
        info["entry"] = elf.header.e_entry
        info["bits"] = elf.elfclass

        for section in elf.iter_sections():
            info["sections"][section.name] = {
                "addr": section['sh_addr'],
                "offset": section['sh_offset'],
                "size": section['sh_size'],
            }

        for section in elf.iter_sections():
            if isinstance(section, SymbolTableSection):
                for sym in section.iter_symbols():
                    if sym['st_value'] != 0:
                        info["symbols"][sym.name] = {
                            "addr": sym['st_value'],
                            "size": sym['st_size'],
                            "type": sym['st_info']['type'],
                            "bind": sym['st_info']['bind'],
                        }
    return info


def disassemble_function(filepath, info, func_name, max_insns=200):
    """Disassemble a named function from an ELF binary."""
    if func_name not in info["symbols"]:
        print(f"[!] Function '{func_name}' not found in symbol table.")
        return

    sym = info["symbols"][func_name]
    text = info["sections"].get(".text", {})
    if not text:
        print("[!] No .text section found.")
        return

    addr = sym["addr"]
    size = sym["size"] if sym["size"] > 0 else 256
    file_offset = addr - text["addr"] + text["offset"]

    with open(filepath, 'rb') as f:
        f.seek(file_offset)
        code = f.read(size)

    # Try both ARM and THUMB, pick whichever decodes more instructions
    md_arm = Cs(CS_ARCH_ARM, CS_MODE_ARM)
    md_arm.detail = True
    arm_insns = list(md_arm.disasm(code, addr))

    md_thumb = Cs(CS_ARCH_ARM, CS_MODE_THUMB)
    md_thumb.detail = True
    thumb_insns = list(md_thumb.disasm(code, addr))

    if len(thumb_insns) > len(arm_insns):
        insns, mode = thumb_insns, "THUMB"
    else:
        insns, mode = arm_insns, "ARM"

    print(f"\n{'='*70}")
    print(f"  {func_name} @ 0x{addr:08x} ({sym['size']} bytes, {mode} mode)")
    print(f"{'='*70}")

    for i, insn in enumerate(insns[:max_insns]):
        print(f"  0x{insn.address:08x}:  {insn.mnemonic:10s} {insn.op_str}")

    if len(insns) > max_insns:
        print(f"  ... ({len(insns) - max_insns} more instructions)")


def list_symbols(info, filter_str=None):
    """List all function symbols, optionally filtered."""
    print(f"\n{'='*70}")
    print(f"  EXPORTED FUNCTIONS" + (f" (filter: {filter_str})" if filter_str else ""))
    print(f"{'='*70}")

    for name, sym in sorted(info["symbols"].items(), key=lambda x: x[1]["addr"]):
        if sym["type"] != "STT_FUNC":
            continue
        if filter_str and filter_str.lower() not in name.lower():
            continue
        print(f"  0x{sym['addr']:08x} [{sym['size']:5d} bytes] {name}")


def extract_strings(filepath, min_len=6, filter_str=None):
    """Extract printable strings from binary."""
    with open(filepath, 'rb') as f:
        data = f.read()

    print(f"\n{'='*70}")
    print(f"  STRINGS" + (f" (filter: {filter_str})" if filter_str else ""))
    print(f"{'='*70}")

    current = b""
    start = 0
    for i, byte in enumerate(data):
        if 32 <= byte < 127:
            if not current:
                start = i
            current += bytes([byte])
        else:
            if len(current) >= min_len:
                s = current.decode('ascii', errors='replace')
                if not filter_str or filter_str.lower() in s.lower():
                    print(f"  0x{start:08x}: {s}")
            current = b""


def main():
    parser = argparse.ArgumentParser(description="ARM ELF Binary Analyzer (Capstone)")
    parser.add_argument("binary", help="Path to ARM ELF binary (.so or executable)")
    parser.add_argument("--func", help="Disassemble a specific function by name")
    parser.add_argument("--func-all-upgrade", action="store_true",
                        help="Disassemble all upgrade/update related functions")
    parser.add_argument("--symbols", action="store_true", help="List all function symbols")
    parser.add_argument("--symbols-filter", help="List symbols matching filter")
    parser.add_argument("--strings", action="store_true", help="Extract strings")
    parser.add_argument("--filter", help="Filter strings by keyword")
    parser.add_argument("--max-insns", type=int, default=200, help="Max instructions to show")

    args = parser.parse_args()

    info = get_elf_info(args.binary)
    print(f"[*] Binary: {args.binary}")
    print(f"[*] Architecture: {'ARM' if 'ARM' in str(info['arch']) else info['arch']}")
    print(f"[*] Entry: 0x{info['entry']:08x}")
    print(f"[*] Symbols: {len(info['symbols'])}")

    if args.symbols or args.symbols_filter:
        list_symbols(info, args.symbols_filter)

    if args.func:
        disassemble_function(args.binary, info, args.func, args.max_insns)

    if args.func_all_upgrade:
        keywords = ["upgrade", "download", "load", "receive", "check", "version",
                     "omci", "cwmp", "http", "ftp", "tftp", "sftp", "chnl",
                     "flash", "partition", "hash", "sig", "cert", "init"]
        for name, sym in sorted(info["symbols"].items(), key=lambda x: x[1]["addr"]):
            if sym["type"] == "STT_FUNC" and any(k in name.lower() for k in keywords):
                disassemble_function(args.binary, info, name, min(args.max_insns, 40))

    if args.strings:
        extract_strings(args.binary, filter_str=args.filter)

    if not any([args.symbols, args.symbols_filter, args.func, args.func_all_upgrade, args.strings]):
        list_symbols(info)


if __name__ == "__main__":
    main()
