var g_rnd_char_size = 8;
var g_rnd_hex_case = 0;

function FormatUrlEncode(val) {
    if (null != val) {
        var formatstr = escape(val);
        formatstr = formatstr.replace(new RegExp(/(\+)/g), "%2B");
        formatstr = formatstr.replace(new RegExp(/(\/)/g), "%2F");
        return formatstr
    }
    
    return null;
}

function rnd_bit_add(left, right) {
    var low = (left & 0xFFFF) + (right & 0xFFFF);
    var high = (left >> 16) + (right >> 16) + (low >> 16);
    return (high << 16) | (low & 0xFFFF);
}

function rnd_shift(v, cnt) {
    return (v >>> cnt) | (v << (32 - cnt));
}

function rnd_sum1(a, b, c) {
    return ((a & b) ^ ((~a) & c));
}

function rnd_sum2(a, b, c) {
    return ((a & b) ^ (a & c) ^ (b & c));
}

function rnd_round(v, cnt) {
    return (v >>> cnt);
}

function rnd_gamma0256(v) {
    return (rnd_shift(v, 7) ^ rnd_shift(v, 18) ^ rnd_round(v, 3));
}

function rnd_gamma1256(v) {
    return (rnd_shift(v, 17) ^ rnd_shift(v, 19) ^ rnd_round(v, 10));
}

function rnd_sigma0256(v) {
    return (rnd_shift(v, 2) ^ rnd_shift(v, 13) ^ rnd_shift(v, 22));
}

function rnd_sigma1256(v) {
    return (rnd_shift(v, 6) ^ rnd_shift(v, 11) ^ rnd_shift(v, 25));
}

function rnd_security_format(m, l) {
    var magic_table = new Array(0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5, 0x3956C25B,
                                0x59F111F1, 0x923F82A4, 0xAB1C5ED5, 0xD807AA98, 0x12835B01, /* sha256 magic table */
                                0x243185BE, 0x550C7DC3, 0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, /* sha256 magic table */
                                0xC19BF174, 0xE49B69C1, 0xEFBE4786, 0xFC19DC6,  0x240CA1CC, /* sha256 magic table */
                                0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA, 0x983E5152, /* sha256 magic table */
                                0xA831C66D, 0xB00327C8, 0xBF597FC7, 0xC6E00BF3, 0xD5A79147, /* sha256 magic table */
                                0x6CA6351,  0x14292967, 0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, /* sha256 magic table */
                                0x53380D13, 0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85, /* sha256 magic table */
                                0xA2BFE8A1, 0xA81A664B, 0xC24B8B70, 0xC76C51A3, 0xD192E819, /* sha256 magic table */
                                0xD6990624, 0xF40E3585, 0x106AA070, 0x19A4C116, 0x1E376C08, /* sha256 magic table */
                                0x2748774C, 0x34B0BCB5, 0x391C0CB3, 0x4ED8AA4A, 0x5B9CCA4F, /* sha256 magic table */
                                0x682E6FF3, 0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208, /* sha256 magic table */
                                0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2);
    var hash_table = new Array(0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A, 0x510E527F, 0x9B05688C, 0x1F83D9AB, 0x5BE0CD19);
    var wd = new Array(64);
    var t1, t2, t3, t4, t5, t6, t7, t8, t9, t10;
    var sum1, sum2;

    m[l >> 5] |= 0x80 << (24 - l % 32);
    m[((l + 64 >> 9) << 4) + 15] = l;
    
    for (var t9 = 0; t9 < m.length; t9 += 16) {
        t1 = hash_table[0];
        t2 = hash_table[1];
        t3 = hash_table[2];
        t4 = hash_table[3];
        t5 = hash_table[4];
        t6 = hash_table[5];
        t7 = hash_table[6];
        t8 = hash_table[7];

        for (var t10 = 0; t10 < 64; t10++) {
            if (t10 < 16) {
                wd[t10] = m[t10 + t9];
            } else {
                wd[t10] = rnd_bit_add(rnd_bit_add(rnd_bit_add(rnd_gamma1256(wd[t10 - 2]), wd[t10 - 7]), rnd_gamma0256(wd[t10 - 15])), wd[t10 - 16]);
            }
            
            sum1 = rnd_bit_add(rnd_bit_add(rnd_bit_add(rnd_bit_add(t8, rnd_sigma1256(t5)), rnd_sum1(t5, t6, t7)), magic_table[t10]), wd[t10]);
            sum2 = rnd_bit_add(rnd_sigma0256(t1), rnd_sum2(t1, t2, t3));
            t8 = t7;
            t7 = t6;
            t6 = t5;

            t5 = rnd_bit_add(t4, sum1);
            t4 = t3;
            t3 = t2;
            t2 = t1;
            t1 = rnd_bit_add(sum1, sum2);
        }

        hash_table[0] = rnd_bit_add(t1, hash_table[0]);
        hash_table[1] = rnd_bit_add(t2, hash_table[1]);
        hash_table[2] = rnd_bit_add(t3, hash_table[2]);
        hash_table[3] = rnd_bit_add(t4, hash_table[3]);
        hash_table[4] = rnd_bit_add(t5, hash_table[4]);
        hash_table[5] = rnd_bit_add(t6, hash_table[5]);
        hash_table[6] = rnd_bit_add(t7, hash_table[6]);
        hash_table[7] = rnd_bit_add(t8, hash_table[7]);
    }

    return hash_table;
}

function rnd_string_to_bin(input_string) {
    var result_bin = Array();
    var mask = (1 << g_rnd_char_size) - 1;
    for (var i = 0; i < input_string.length * g_rnd_char_size; i += g_rnd_char_size) {
        result_bin[i >> 5] |= (input_string.charCodeAt(i / g_rnd_char_size) & mask) << (24 - i % 32);
    }

    return result_bin;
}

function rnd_encode_utf8(input_string) {
    input_string = input_string.replace(/\r\n/g, "\n");
    var utf_result = "";

    for (var i = 0; i < input_string.length; i++) {
        var c = input_string.charCodeAt(i);
        if (c < 128) {
            utf_result += String.fromCharCode(c);
        } else if ((c > 127) && (c < 2048)) {
            utf_result += String.fromCharCode((c >> 6) | 192);
            utf_result += String.fromCharCode((c & 63) | 128);
        } else {
            utf_result += String.fromCharCode((c >> 12) | 224);
            utf_result += String.fromCharCode(((c >> 6) & 63) | 128);
            utf_result += String.fromCharCode((c & 63) | 128);
        }
    }

    return utf_result;
}

function rnd_bin_to_hex(binarray) {
    var hex_table = g_rnd_hex_case ? "0123456789ABCDEF" : "0123456789abcdef";
    var result_string = "";

    for (var i = 0; i < binarray.length * 4; i++) {
        result_string += hex_table.charAt((binarray[i >> 2] >> ((3 - i % 4) * 8 + 4)) & 0xF) + hex_table.charAt((binarray[i >> 2] >> ((3 - i % 4) * 8)) & 0xF);
    }

    return result_string;
}

function RndSecurityFormat(str) {
    str = rnd_encode_utf8(str);
    return rnd_bin_to_hex(rnd_security_format(rnd_string_to_bin(str), str.length * g_rnd_char_size));
}
