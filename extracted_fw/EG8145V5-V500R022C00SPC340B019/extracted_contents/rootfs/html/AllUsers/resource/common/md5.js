var g_hex_case = 0;
var g_base64_padding = ""; 
var g_char_size = 8; 

function hex_md5(str) {
    return binl_to_hex(main_md5_process(str_to_binl(str), str.length * g_char_size));
}

function b64_md5(str) {
    return binl_to_base64(main_md5_process(str_to_binl(str), str.length * g_char_size));
}

function str_md5(str) {
    return binl_to_string(main_md5_process(str_to_binl(str), str.length * g_char_size));
}

function hex_hmac_md5(key, data) {
    return binl_to_hex(core_hmac_md5(key, data));
}

function b64_hmac_md5(key, data) {
    return binl_to_base64(core_hmac_md5(key, data));
}

function str_hmac_md5(key, data) {
    return binl_to_string(core_hmac_md5(key, data));
}

function md5_bit_rol(n, cnt) {
    return (n << cnt) | (n >>> (32 - cnt));
}

function md5_bit_add(left, right) {
    var lsw = (left & 0xFFFF) + (right & 0xFFFF);
    var msw = (left >> 16) + (right >> 16) + (lsw >> 16);
    return (msw << 16) | (lsw & 0xFFFF);
}

function md5_bit_oper(a, b, c, d, e, f) {
    return md5_bit_add(md5_bit_rol(md5_bit_add(md5_bit_add(b, a), md5_bit_add(d, f)), e), c);
}

function md5_round1(a, b, c, d, e, f, g) {
    return md5_bit_oper((b & c) | ((~b) & d), a, b, e, f, g);
}

function md5_round2(a, b, c, d, e, f, g) {
    return md5_bit_oper((b & d) | (c & (~d)), a, b, e, f, g);
}

function md5_round3(a, b, c, d, e, f, g) {
    return md5_bit_oper(b ^ c ^ d, a, b, e, f, g);
}

function md5_round4(a, b, c, d, e, f, g) {
    return md5_bit_oper(c ^ (b | (~d)), a, b, e, f, g);
}

function main_md5_process(data_bit, length) {
    data_bit[length >> 5] |= 0x80 << ((length) % 32);
    data_bit[(((length + 64) >>> 9) << 4) + 14] = length;

    var tmp1 = 1732584193;
    var tmp2 = -271733879;
    var tmp3 = -1732584194;
    var tmp4 = 271733878;

    for (var i = 0; i < data_bit.length; i += 16) {
        var orig_tmp1 = tmp1;
        var orig_tmp2 = tmp2;
        var orig_tmp3 = tmp3;
        var orig_tmp4 = tmp4;

        tmp1 = md5_round1(tmp1, tmp2, tmp3, tmp4, data_bit[i + 0], 7, -680876936);
        tmp4 = md5_round1(tmp4, tmp1, tmp2, tmp3, data_bit[i + 1], 12, -389564586);
        tmp3 = md5_round1(tmp3, tmp4, tmp1, tmp2, data_bit[i + 2], 17, 606105819);
        tmp2 = md5_round1(tmp2, tmp3, tmp4, tmp1, data_bit[i + 3], 22, -1044525330);
        tmp1 = md5_round1(tmp1, tmp2, tmp3, tmp4, data_bit[i + 4], 7, -176418897);
        tmp4 = md5_round1(tmp4, tmp1, tmp2, tmp3, data_bit[i + 5], 12, 1200080426);
        tmp3 = md5_round1(tmp3, tmp4, tmp1, tmp2, data_bit[i + 6], 17, -1473231341);
        tmp2 = md5_round1(tmp2, tmp3, tmp4, tmp1, data_bit[i + 7], 22, -45705983);
        tmp1 = md5_round1(tmp1, tmp2, tmp3, tmp4, data_bit[i + 8], 7, 1770035416);
        tmp4 = md5_round1(tmp4, tmp1, tmp2, tmp3, data_bit[i + 9], 12, -1958414417);
        tmp3 = md5_round1(tmp3, tmp4, tmp1, tmp2, data_bit[i + 10], 17, -42063);
        tmp2 = md5_round1(tmp2, tmp3, tmp4, tmp1, data_bit[i + 11], 22, -1990404162);
        tmp1 = md5_round1(tmp1, tmp2, tmp3, tmp4, data_bit[i + 12], 7, 1804603682);
        tmp4 = md5_round1(tmp4, tmp1, tmp2, tmp3, data_bit[i + 13], 12, -40341101);
        tmp3 = md5_round1(tmp3, tmp4, tmp1, tmp2, data_bit[i + 14], 17, -1502002290);
        tmp2 = md5_round1(tmp2, tmp3, tmp4, tmp1, data_bit[i + 15], 22, 1236535329);

        tmp1 = md5_round2(tmp1, tmp2, tmp3, tmp4, data_bit[i + 1], 5, -165796510);
        tmp4 = md5_round2(tmp4, tmp1, tmp2, tmp3, data_bit[i + 6], 9, -1069501632);
        tmp3 = md5_round2(tmp3, tmp4, tmp1, tmp2, data_bit[i + 11], 14, 643717713);
        tmp2 = md5_round2(tmp2, tmp3, tmp4, tmp1, data_bit[i + 0], 20, -373897302);
        tmp1 = md5_round2(tmp1, tmp2, tmp3, tmp4, data_bit[i + 5], 5, -701558691);
        tmp4 = md5_round2(tmp4, tmp1, tmp2, tmp3, data_bit[i + 10], 9, 38016083);
        tmp3 = md5_round2(tmp3, tmp4, tmp1, tmp2, data_bit[i + 15], 14, -660478335);
        tmp2 = md5_round2(tmp2, tmp3, tmp4, tmp1, data_bit[i + 4], 20, -405537848);
        tmp1 = md5_round2(tmp1, tmp2, tmp3, tmp4, data_bit[i + 9], 5, 568446438);
        tmp4 = md5_round2(tmp4, tmp1, tmp2, tmp3, data_bit[i + 14], 9, -1019803690);
        tmp3 = md5_round2(tmp3, tmp4, tmp1, tmp2, data_bit[i + 3], 14, -187363961);
        tmp2 = md5_round2(tmp2, tmp3, tmp4, tmp1, data_bit[i + 8], 20, 1163531501);
        tmp1 = md5_round2(tmp1, tmp2, tmp3, tmp4, data_bit[i + 13], 5, -1444681467);
        tmp4 = md5_round2(tmp4, tmp1, tmp2, tmp3, data_bit[i + 2], 9, -51403784);
        tmp3 = md5_round2(tmp3, tmp4, tmp1, tmp2, data_bit[i + 7], 14, 1735328473);
        tmp2 = md5_round2(tmp2, tmp3, tmp4, tmp1, data_bit[i + 12], 20, -1926607734);

        tmp1 = md5_round3(tmp1, tmp2, tmp3, tmp4, data_bit[i + 5], 4, -378558);
        tmp4 = md5_round3(tmp4, tmp1, tmp2, tmp3, data_bit[i + 8], 11, -2022574463);
        tmp3 = md5_round3(tmp3, tmp4, tmp1, tmp2, data_bit[i + 11], 16, 1839030562);
        tmp2 = md5_round3(tmp2, tmp3, tmp4, tmp1, data_bit[i + 14], 23, -35309556);
        tmp1 = md5_round3(tmp1, tmp2, tmp3, tmp4, data_bit[i + 1], 4, -1530992060);
        tmp4 = md5_round3(tmp4, tmp1, tmp2, tmp3, data_bit[i + 4], 11, 1272893353);
        tmp3 = md5_round3(tmp3, tmp4, tmp1, tmp2, data_bit[i + 7], 16, -155497632);
        tmp2 = md5_round3(tmp2, tmp3, tmp4, tmp1, data_bit[i + 10], 23, -1094730640);
        tmp1 = md5_round3(tmp1, tmp2, tmp3, tmp4, data_bit[i + 13], 4, 681279174);
        tmp4 = md5_round3(tmp4, tmp1, tmp2, tmp3, data_bit[i + 0], 11, -358537222);
        tmp3 = md5_round3(tmp3, tmp4, tmp1, tmp2, data_bit[i + 3], 16, -722521979);
        tmp2 = md5_round3(tmp2, tmp3, tmp4, tmp1, data_bit[i + 6], 23, 76029189);
        tmp1 = md5_round3(tmp1, tmp2, tmp3, tmp4, data_bit[i + 9], 4, -640364487);
        tmp4 = md5_round3(tmp4, tmp1, tmp2, tmp3, data_bit[i + 12], 11, -421815835);
        tmp3 = md5_round3(tmp3, tmp4, tmp1, tmp2, data_bit[i + 15], 16, 530742520);
        tmp2 = md5_round3(tmp2, tmp3, tmp4, tmp1, data_bit[i + 2], 23, -995338651);

        tmp1 = md5_round4(tmp1, tmp2, tmp3, tmp4, data_bit[i + 0], 6, -198630844);
        tmp4 = md5_round4(tmp4, tmp1, tmp2, tmp3, data_bit[i + 7], 10, 1126891415);
        tmp3 = md5_round4(tmp3, tmp4, tmp1, tmp2, data_bit[i + 14], 15, -1416354905);
        tmp2 = md5_round4(tmp2, tmp3, tmp4, tmp1, data_bit[i + 5], 21, -57434055);
        tmp1 = md5_round4(tmp1, tmp2, tmp3, tmp4, data_bit[i + 12], 6, 1700485571);
        tmp4 = md5_round4(tmp4, tmp1, tmp2, tmp3, data_bit[i + 3], 10, -1894986606);
        tmp3 = md5_round4(tmp3, tmp4, tmp1, tmp2, data_bit[i + 10], 15, -1051523);
        tmp2 = md5_round4(tmp2, tmp3, tmp4, tmp1, data_bit[i + 1], 21, -2054922799);
        tmp1 = md5_round4(tmp1, tmp2, tmp3, tmp4, data_bit[i + 8], 6, 1873313359);
        tmp4 = md5_round4(tmp4, tmp1, tmp2, tmp3, data_bit[i + 15], 10, -30611744);
        tmp3 = md5_round4(tmp3, tmp4, tmp1, tmp2, data_bit[i + 6], 15, -1560198380);
        tmp2 = md5_round4(tmp2, tmp3, tmp4, tmp1, data_bit[i + 13], 21, 1309151649);
        tmp1 = md5_round4(tmp1, tmp2, tmp3, tmp4, data_bit[i + 4], 6, -145523070);
        tmp4 = md5_round4(tmp4, tmp1, tmp2, tmp3, data_bit[i + 11], 10, -1120210379);
        tmp3 = md5_round4(tmp3, tmp4, tmp1, tmp2, data_bit[i + 2], 15, 718787259);
        tmp2 = md5_round4(tmp2, tmp3, tmp4, tmp1, data_bit[i + 9], 21, -343485551);

        tmp1 = md5_bit_add(tmp1, orig_tmp1);
        tmp2 = md5_bit_add(tmp2, orig_tmp2);
        tmp3 = md5_bit_add(tmp3, orig_tmp3);
        tmp4 = md5_bit_add(tmp4, orig_tmp4);
    }
    
    return Array(tmp1, tmp2, tmp3, tmp4);
}

function core_hmac_md5(user_key, data_buffer) {
    var bkey = str_to_binl(user_key);
    if (bkey.length > 16)  {
        bkey = main_md5_process(bkey, user_key.length * g_char_size);
    }

    var pad1 = Array(16),
        pad2 = Array(16);
        
    for (var i = 0; i < 16; i++) {
        pad1[i] = bkey[i] ^ 0x36363636;
        pad2[i] = bkey[i] ^ 0x5C5C5C5C;
    }

    var hash = main_md5_process(pad1.concat(str_to_binl(data_buffer)), 512 + data_buffer.length * g_char_size);
    return main_md5_process(pad2.concat(hash), 512 + 128);
}

function str_to_binl(str) {
    var result_bin = Array();
    var mask = (1 << g_char_size) - 1;
    
    for (var i = 0; i < str.length * g_char_size; i += g_char_size) {
        result_bin[i >> 5] |= (str.charCodeAt(i / g_char_size) & mask) << (i % 32);
    }
    
    return result_bin;
}

function binl_to_string(bin_array) {
    var result_string = "";
    var mask = (1 << g_char_size) - 1;
    
    for (var i = 0; i < bin_array.length * 32; i += g_char_size) {
        result_string += String.fromCharCode((bin_array[i >> 5] >>> (i % 32)) & mask);
    }
    
    return result_string;
}

function binl_to_hex(bin_array) {
    var hex_tab = g_hex_case ? "0123456789ABCDEF" : "0123456789abcdef";
    var result_string = "";
    
    for (var i = 0; i < bin_array.length * 4; i++) {
        result_string += hex_tab.charAt((bin_array[i >> 2] >> ((i % 4) * 8 + 4)) & 0xF) + hex_tab.charAt((bin_array[i >> 2] >> ((i % 4) * 8)) & 0xF);
    }
    
    return result_string;
}

function binl_to_base64(bin_array) {
    var base64_table = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    var result_string = "";
    
    for (var i = 0; i < bin_array.length * 4; i += 3) {
        var triplet = (((bin_array[i >> 2] >> 8 * (i % 4)) & 0xFF) << 16) |
            (((bin_array[i + 1 >> 2] >> 8 * ((i + 1) % 4)) & 0xFF) << 8) |
            ((bin_array[i + 2 >> 2] >> 8 * ((i + 2) % 4)) & 0xFF);
            
        for (var j = 0; j < 4; j++) {
            if (i * 8 + j * 6 > bin_array.length * 32)  {
                result_string += g_base64_padding;
            } else {
                result_string += base64_table.charAt((triplet >> 6 * (3 - j)) & 0x3F);
            }
        }
    }
    
    return result_string;
}
