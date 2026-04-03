
var wabQR;

(function () {
  function QR8bitByte(data) {

    this.mode = QRMode.MODE_8BIT_BYTE;
    this.data = data;
    this.parsedData = [];

    for (var index = 0, l = this.data.length; index < l; index++) {
      var curArray = [];
      var currentcode = this.data.charCodeAt(index);

      if (currentcode > 0x10000) {
        curArray[0] = 0xF0 | ((currentcode & 0x1C0000) >>> 18);
        curArray[1] = 0x80 | ((currentcode & 0x3F000) >>> 12);
        curArray[2] = 0x80 | ((currentcode & 0xFC0) >>> 6);
        curArray[3] = 0x80 | (currentcode & 0x3F);
      } else if (currentcode > 0x800) {
        curArray[0] = 0xE0 | ((currentcode & 0xF000) >>> 12);
        curArray[1] = 0x80 | ((currentcode & 0xFC0) >>> 6);
        curArray[2] = 0x80 | (currentcode & 0x3F);
      } else if (currentcode > 0x80) {
        curArray[0] = 0xC0 | ((currentcode & 0x7C0) >>> 6);
        curArray[1] = 0x80 | (currentcode & 0x3F);
      } else {
        curArray[0] = currentcode;
      }
      this.parsedData.push(curArray);
    }
    this.parsedData = Array.prototype.concat.apply([], this.parsedData);

    if (this.parsedData.length != this.data.length) {
      this.parsedData.unshift(187);
      this.parsedData.unshift(191);
      this.parsedData.unshift(239);
    }
  }

  QR8bitByte.prototype = {
    getLength: function () {
      return this.parsedData.length;
    },
    write: function (bufferlist) {
      for (var k = 0, l = this.parsedData.length; k < l; k++) {
        bufferlist.put(this.parsedData[k], 8);
      }
    }
  };

  function wabQRModel(type, errorinfo) {
    this.typeNumber = type;
    this.errorCorrectLevel = errorinfo;
    this.modules = null;
    this.moduleCount = 0;
    this.dataCache = null;
    this.dataList = [];
  }

  wabQRModel.prototype = {
    addData: function (data) {
      var newData = new QR8bitByte(data);
      this.dataList.push(newData);
      this.dataCache = null;
    },
    isDark: function (index, col) {
      if (index < 0 || this.moduleCount <= index || col < 0 || this.moduleCount <= col) {
        throw new Error(index + "," + col);
      }
      return this.modules[index][col];
    },
    getModuleCount: function () {
      return this.moduleCount;
    },
    make: function () {
      this.makeImpl(false, this.getBestMaskPattern());
    },
    makeImpl: function (info, param) {
      this.moduleCount = this.typeNumber * 4 + 17;
      this.modules = new Array(this.moduleCount);
      for (var index = 0; index < this.moduleCount; index++) {
        this.modules[index] = new Array(this.moduleCount);
        for (var col = 0; col < this.moduleCount; col++) {
          this.modules[index][col] = null;
        }
      }
      this.setupPositionProbePattern(0, 0);
      this.setupPositionProbePattern(this.moduleCount - 7, 0);
      this.setupPositionProbePattern(0, this.moduleCount - 7);
      this.setupPositionAdjustPattern();
      this.setupTimingPattern();
      this.setupTypeInfo(info, param);
      if (this.typeNumber >= 7) {
        this.setupTypeNumber(info);
      }
      if (this.dataCache == null) {
        this.dataCache = wabQRModel.createData(this.typeNumber, this.errorCorrectLevel, this.dataList);
      }
      this.mapData(this.dataCache, param);
    },
    setupPositionProbePattern: function (index, col) {
      for (var r = -1; r <= 7; r++) {
        if (index + r <= -1 || this.moduleCount <= index + r) continue;
        for (var c = -1; c <= 7; c++) {
          if (col + c <= -1 || this.moduleCount <= col + c) continue;
          if ((0 <= r && r <= 6 && (c == 0 || c == 6)) || (0 <= c && c <= 6 && (r == 0 || r == 6)) || (2 <= r && r <= 4 && 2 <= c && c <= 4)) {
            this.modules[index + r][col + c] = true;
          } else {
            this.modules[index + r][col + c] = false;
          }
        }
      }
    },
    getBestMaskPattern: function () {
      var Point = 0;
      var patterNum = 0;
      for (var i = 0; i < 8; i++) {
        this.makeImpl(true, i);
        var lostPoint = QRUtil.getLostPoint(this);
        if (i == 0 || Point > lostPoint) {
          Point = lostPoint;
          patterNum = i;
        }
      }
      return patterNum;
    },
    createMovieClip: function (target_mcpa, nameparam, pamdepth) {
      var qr_mcparam = target_mcpa.createEmptyMovieClip(nameparam, pamdepth);
      var csnum = 1;
      this.make();
      for (var index = 0; index < this.modules.length; index++) {
        var y = index * csnum;
        for (var col = 0; col < this.modules[index].length; col++) {
          var x = col * csnum;
          var dark = this.modules[index][col];
          if (dark) {
            qr_mcparam.beginFill(0, 100);
            qr_mcparam.moveTo(x, y);
            qr_mcparam.lineTo(x + csnum, y);
            qr_mcparam.lineTo(x + csnum, y + csnum);
            qr_mcparam.lineTo(x, y + csnum);
            qr_mcparam.endFill();
          }
        }
      }
      return qr_mcparam;
    },
    setupTimingPattern: function () {
      for (var index = 8; index < this.moduleCount - 8; index++) {
        if (this.modules[index][6] != null) {
          continue;
        }
        this.modules[index][6] = (index % 2 == 0);
      }
      for (var index = 8; index < this.moduleCount - 8; index++) {
        if (this.modules[6][index] != null) {
          continue;
        }
        this.modules[6][index] = (index % 2 == 0);
      }
    },
    setupPositionAdjustPattern: function () {
      var posparam = QRUtil.getPatternPosition(this.typeNumber);
      for (var g = 0; g < posparam.length; g++) {
        for (var j = 0; j < posparam.length; j++) {
          var currow = posparam[g];
          var col = posparam[j];
          if (this.modules[currow][col] != null) {
            continue;
          }
          for (var index = -2; index <= 2; index++) {
            for (var k = -2; k <= 2; k++) {
              if (index == -2 || index == 2 || k == -2 || k == 2 || (index == 0 && k == 0)) {
                this.modules[currow + index][col + k] = true;
              } else {
                this.modules[currow + index][col + k] = false;
              }
            }
          }
        }
      }
    },
    setupTypeNumber: function (param) {
      var list = QRUtil.getBCHTypeNumber(this.typeNumber);
      for (var index = 0; index < 18; index++) {
        var curmod = (!param && ((list >> index) & 1) == 1);
        this.modules[Math.floor(index / 3)][index % 3 + this.moduleCount - 8 - 3] = curmod;
      }
      for (var index = 0; index < 18; index++) {
        var curmod = (!param && ((list >> index) & 1) == 1);
        this.modules[index % 3 + this.moduleCount - 8 - 3][Math.floor(index / 3)] = curmod;
      }
    },
    setupTypeInfo: function (param, maskPattern) {
      var datalist = (this.errorCorrectLevel << 3) | maskPattern;
      var list = QRUtil.getBCHTypeInfo(datalist);
      for (var index = 0; index < 15; index++) {
        var curmod = (!param && ((list >> index) & 1) == 1);
        if (index < 6) {
          this.modules[index][8] = curmod;
        } else if (index < 8) {
          this.modules[index + 1][8] = curmod;
        } else {
          this.modules[this.moduleCount - 15 + index][8] = curmod;
        }
      }
      for (var index = 0; index < 15; index++) {
        var curmod = (!param && ((list >> index) & 1) == 1);
        if (index < 8) {
          this.modules[8][this.moduleCount - index - 1] = curmod;
        } else if (index < 9) {
          this.modules[8][15 - index - 1 + 1] = curmod;
        } else {
          this.modules[8][15 - index - 1] = curmod;
        }
      }
      this.modules[this.moduleCount - 8][8] = (!param);
    },
    mapData: function (paramdata, maskPatterninfo) {
      var inc = -1;
      var currow = this.moduleCount - 1;
      var bitIndexnum = 7;
      var byteIndexnum = 0;
      for (var k = this.moduleCount - 1; k > 0; k -= 2) {
        if (k == 6) k--;
        while (true) {
          for (var index = 0; index < 2; index++) {
            if (this.modules[currow][k - index] == null) {
              var dark = false;
              if (byteIndexnum < paramdata.length) {
                dark = (((paramdata[byteIndexnum] >>> bitIndexnum) & 1) == 1);
              }
              var mask = QRUtil.getMask(maskPatterninfo, currow, k - index);
              if (mask) {
                dark = !dark;
              }
              this.modules[currow][k - index] = dark;
              bitIndexnum--;
              if (bitIndexnum == -1) {
                byteIndexnum++;
                bitIndexnum = 7;
              }
            }
          }
          currow += inc;
          if (currow < 0 || this.moduleCount <= currow) {
            currow -= inc;
            inc = -inc;
            break;
          }
        }
      }
    }
  };
  wabQRModel.PAD0 = 0xEC;
  wabQRModel.PAD1 = 0x11;
  wabQRModel.createData = function (typeinfo, errinfo, dataListinfo) {
    var rsBlocksinfo = QRRSBlock.getRSBlocks(typeinfo, errinfo);
    var bufferinfo = new QRBitBuffer();
    for (var i = 0; i < dataListinfo.length; i++) {
      var data = dataListinfo[i];
      bufferinfo.put(data.mode, 4);
      bufferinfo.put(data.getLength(), QRUtil.getLengthInBits(data.mode, typeinfo));
      data.write(bufferinfo);
    }
    var totalDataCount = 0;
    for (var i = 0; i < rsBlocksinfo.length; i++) {
      totalDataCount += rsBlocksinfo[i].dataCount;
    }
    if (bufferinfo.getLengthInBits() > totalDataCount * 8) {
      throw new Error("code length overflow. (" +
        bufferinfo.getLengthInBits() +
        ">" +
        totalDataCount * 8 +
        ")");
    }
    if (bufferinfo.getLengthInBits() + 4 <= totalDataCount * 8) {
      bufferinfo.put(0, 4);
    }
    while (bufferinfo.getLengthInBits() % 8 != 0) {
      bufferinfo.putBit(false);
    }
    while (true) {
      if (bufferinfo.getLengthInBits() >= totalDataCount * 8) {
        break;
      }
      bufferinfo.put(wabQRModel.PAD0, 8);
      if (bufferinfo.getLengthInBits() >= totalDataCount * 8) {
        break;
      }
      bufferinfo.put(wabQRModel.PAD1, 8);
    }
    return wabQRModel.createBytes(bufferinfo, rsBlocksinfo);
  };
  wabQRModel.createBytes = function (buffer, rsBlocksinfo) {
    var offsetnum = 0;
    var maxDcCountNum = 0;
    var maxEcNum = 0;
    var dcdatalist = new Array(rsBlocksinfo.length);
    var ecdatalist = new Array(rsBlocksinfo.length);
    for (var r = 0; r < rsBlocksinfo.length; r++) {
      var dcCount = rsBlocksinfo[r].dataCount;
      var ecCount = rsBlocksinfo[r].totalCount - dcCount;
      maxDcCountNum = Math.max(maxDcCountNum, dcCount);
      maxEcNum = Math.max(maxEcNum, ecCount);
      dcdatalist[r] = new Array(dcCount);
      for (var i = 0; i < dcdatalist[r].length; i++) {
        dcdatalist[r][i] = 0xff & buffer.buffer[i + offsetnum];
      }
      offsetnum += dcCount;
      var rsPoly = QRUtil.getErrorCorrectPolynomial(ecCount);
      var rawPoly = new QRPolynomial(dcdatalist[r], rsPoly.getLength() - 1);
      var modPoly = rawPoly.mod(rsPoly);
      ecdatalist[r] = new Array(rsPoly.getLength() - 1);
      for (var i = 0; i < ecdatalist[r].length; i++) {
        var modIndex = i + modPoly.getLength() - ecdatalist[r].length;
        ecdatalist[r][i] = (modIndex >= 0) ? modPoly.get(modIndex) : 0;
      }
    }
    var totalCodeCount = 0;
    for (var i = 0; i < rsBlocksinfo.length; i++) {
      totalCodeCount += rsBlocksinfo[i].totalCount;
    }
    var data = new Array(totalCodeCount);
    var index = 0;
    for (var i = 0; i < maxDcCountNum; i++) {
      for (var r = 0; r < rsBlocksinfo.length; r++) {
        if (i < dcdatalist[r].length) {
          data[index++] = dcdatalist[r][i];
        }
      }
    }
    for (var i = 0; i < maxEcNum; i++) {
      for (var r = 0; r < rsBlocksinfo.length; r++) {
        if (i < ecdatalist[r].length) {
          data[index++] = ecdatalist[r][i];
        }
      }
    }
    return data;
  };
  var QRMode = {
    MODE_ALPHA_NUM: 1 << 1,
    MODE_KANJI: 1 << 3,
    MODE_NUMBER: 1 << 0,
    MODE_8BIT_BYTE: 1 << 2,
  };
  var QRMaskPattern = {
    PATTERN000: 0,
    PATTERN010: 2,
    PATTERN100: 4,
    PATTERN111: 7,
    PATTERN001: 1,
    PATTERN011: 3,
    PATTERN101: 5,
    PATTERN110: 6,
  };
  var QRErrorCorrectLevel = {
    L: 1,
    M: 0,
    Q: 3,
    H: 2
  };
  var QRUtil = {
    PATTERN_POSITION_TABLE: [[], [6, 18], [6, 22], [6, 26], [6, 30], [6, 34], [6, 22, 38], [6, 24, 42], [6, 26, 46], [6, 28, 50], [6, 30, 54], [6, 32, 58], [6, 34, 62], [6, 26, 46, 66], [6, 26, 48, 70], [6, 26, 50, 74],
    [6, 30, 54, 78], [6, 30, 56, 82], [6, 30, 58, 86], [6, 34, 62, 90], [6, 28, 50, 72, 94], [6, 26, 50, 74, 98], [6, 30, 54, 78, 102], [6, 28, 54, 80, 106], [6, 32, 58, 84, 110], [6, 30, 58, 86, 114],
    [6, 34, 62, 90, 118], [6, 26, 50, 74, 98, 122], [6, 30, 54, 78, 102, 126], [6, 26, 52, 78, 104, 130], [6, 30, 56, 82, 108, 134], [6, 34, 60, 86, 112, 138], [6, 30, 58, 86, 114, 142], [6, 34, 62, 90, 118, 146],
    [6, 30, 54, 78, 102, 126, 150], [6, 24, 50, 76, 102, 128, 154], [6, 28, 54, 80, 106, 132, 158], [6, 32, 58, 84, 110, 136, 162], [6, 26, 54, 82, 110, 138, 166], [6, 30, 58, 86, 114, 142, 170]
    ],
    G18: (1 << 12) | (1 << 11) | (1 << 10) | (1 << 9) | (1 << 8) | (1 << 5) | (1 << 2) | (1 << 0),
    G15_MASK: (1 << 14) | (1 << 12) | (1 << 10) | (1 << 4) | (1 << 1),
    G15: (1 << 10) | (1 << 8) | (1 << 5) | (1 << 4) | (1 << 2) | (1 << 1) | (1 << 0),
    getBCHTypeInfo: function (intoparam) {
      var index = intoparam << 10;
      while (QRUtil.getBCHDigit(index) - QRUtil.getBCHDigit(QRUtil.G15) >= 0) {
        index ^= (QRUtil.G15 << (QRUtil.getBCHDigit(index) - QRUtil.getBCHDigit(QRUtil.G15)));
      }
      return ((intoparam << 10) | index) ^ QRUtil.G15_MASK;
    },
    getBCHTypeNumber: function (intoparam) {
      var index = intoparam << 12;
      while (QRUtil.getBCHDigit(index) - QRUtil.getBCHDigit(QRUtil.G18) >= 0) {
        index ^= (QRUtil.G18 << (QRUtil.getBCHDigit(index) - QRUtil.getBCHDigit(QRUtil.G18)));
      }
      return (intoparam << 12) | index;
    },
    getBCHDigit: function (intoparam) {
      var ki = 0;
      while (intoparam != 0) {
        ki++;
        intoparam >>>= 1;
      }
      return ki;
    },
    getPatternPosition: function (type) {
      return QRUtil.PATTERN_POSITION_TABLE[type - 1];
    },
    getMask: function (list, k, g) {
      switch (list) {
        case QRMaskPattern.PATTERN000:
          return (k + g) % 2 == 0;
        case QRMaskPattern.PATTERN001:
          return k % 2 == 0;
        case QRMaskPattern.PATTERN010:
          return g % 3 == 0;
        case QRMaskPattern.PATTERN011:
          return (k + g) % 3 == 0;
        case QRMaskPattern.PATTERN100:
          return (Math.floor(k / 2) + Math.floor(g / 3)) % 2 == 0;
        case QRMaskPattern.PATTERN101:
          return (k * g) % 2 + (k * g) % 3 == 0;
        case QRMaskPattern.PATTERN110:
          return ((k * g) % 2 + (k * g) % 3) % 2 == 0;
        case QRMaskPattern.PATTERN111:
          return ((k * g) % 3 + (k + g) % 2) % 2 == 0;
        default:
          throw new Error("bad maskPattern:" + list);
      }
    },
    getErrorCorrectPolynomial: function (errlarge) {
      var a = new QRPolynomial([1], 0);
      for (var index = 0; index < errlarge; index++) {
        a = a.multiply(new QRPolynomial([1, QRMath.gexp(index)], 0));
      }
      return a;
    },
    getLengthInBits: function (modetype, inty) {
      if (1 <= inty && inty < 10) {
        switch (modetype) {
          case QRMode.MODE_8BIT_BYTE:
            return 8;
          case QRMode.MODE_KANJI:
            return 8;
          case QRMode.MODE_ALPHA_NUM:
            return 9;
          case QRMode.MODE_NUMBER:
            return 10;
          default:
            throw new Error("mode:" + modetype);
        }
      } else if (inty < 27) {
        switch (modetype) {
          case QRMode.MODE_ALPHA_NUM:
            return 11;
          case QRMode.MODE_KANJI:
            return 10;
          case QRMode.MODE_NUMBER:
            return 12;
          case QRMode.MODE_8BIT_BYTE:
            return 16;
          default:
            throw new Error("mode:" + modetype);
        }
      } else if (inty < 41) {
        switch (modetype) {
          case QRMode.MODE_ALPHA_NUM:
            return 13;
          case QRMode.MODE_KANJI:
            return 12;
          case QRMode.MODE_NUMBER:
            return 14;
          case QRMode.MODE_8BIT_BYTE:
            return 16;
          default:
            throw new Error("mode:" + modetype);
        }
      } else {
        throw new Error("type:" + inty);
      }
    },
    getLostPoint: function (param) {
      var modulelist = param.getModuleCount();
      var lostPoint = 0;
      for (var i = 0; i < modulelist; i++) {
        for (var col = 0; col < modulelist; col++) {
          var sameCount = 0;
          var dark = param.isDark(i, col);
          for (var r = -1; r <= 1; r++) {
            if (i + r < 0 || modulelist <= i + r) {
              continue;
            }
            for (var c = -1; c <= 1; c++) {
              if (col + c < 0 || modulelist <= col + c) {
                continue;
              }
              if (r == 0 && c == 0) {
                continue;
              }
              if (dark == param.isDark(i + r, col + c)) {
                sameCount++;
              }
            }
          }
          if (sameCount > 5) {
            lostPoint += (3 + sameCount - 5);
          }
        }
      }
      for (var k = 0; k < modulelist - 1; k++) {
        for (var col = 0; col < modulelist - 1; col++) {
          var count = 0;
          if (param.isDark(k, col)) count++;
          if (param.isDark(k + 1, col)) count++;
          if (param.isDark(k, col + 1)) count++;
          if (param.isDark(k + 1, col + 1)) count++;
          if (count == 0 || count == 4) {
            lostPoint += 3;
          }
        }
      }
      for (var i = 0; i < modulelist; i++) {
        for (var col = 0; col < modulelist - 6; col++) {
          if (param.isDark(i, col) && !param.isDark(i, col + 1) && param.isDark(i, col + 2) && param.isDark(i, col + 3) && param.isDark(i, col + 4) && !param.isDark(i, col + 5) && param.isDark(i, col + 6)) {
            lostPoint += 40;
          }
        }
      }
      for (var col = 0; col < modulelist; col++) {
        for (var index = 0; index < modulelist - 6; index++) {
          if (param.isDark(index, col) && !param.isDark(index + 1, col) && param.isDark(index + 2, col) && param.isDark(index + 3, col) && param.isDark(index + 4, col) && !param.isDark(index + 5, col) && param.isDark(index + 6, col)) {
            lostPoint += 40;
          }
        }
      }
      var darkCount = 0;
      for (var col = 0; col < modulelist; col++) {
        for (var k = 0; k < modulelist; k++) {
          if (param.isDark(k, col)) {
            darkCount++;
          }
        }
      }
      var ratio = Math.abs(100 * darkCount / modulelist / modulelist - 50) / 5;
      lostPoint += ratio * 10;
      return lostPoint;
    }
  };
  var QRMath = {
    glog: function (param) {
      if (param < 1) {
        throw new Error("glog(" + param + ")");
      }
      return QRMath.LOG_TABLE[param];
    },
    gexp: function (param) {
      while (param < 0) {
        param += 255;
      }
      while (param >= 256) {
        param -= 255;
      }
      return QRMath.EXP_TABLE[param];
    },
    EXP_TABLE: new Array(256),
    LOG_TABLE: new Array(256)
  };
  for (var index = 0; index < 8; index++) {
    QRMath.EXP_TABLE[index] = 1 << index;
  }
  for (var index = 8; index < 256; index++) {
    QRMath.EXP_TABLE[index] = QRMath.EXP_TABLE[index - 4] ^ QRMath.EXP_TABLE[index - 5] ^ QRMath.EXP_TABLE[index - 6] ^ QRMath.EXP_TABLE[index - 8];
  }
  for (var index = 0; index < 255; index++) {
    QRMath.LOG_TABLE[QRMath.EXP_TABLE[index]] = index;
  }

  function QRPolynomial(paramnum, shiftParam) {
    if (paramnum.length == undefined) {
      throw new Error(paramnum.length + "/" + shiftParam);
    }
    var offset = 0;
    while (offset < paramnum.length && paramnum[offset] == 0) {
      offset++;
    }
    this.paramnum = new Array(paramnum.length - offset + shiftParam);
    for (var i = 0; i < paramnum.length - offset; i++) {
      this.paramnum[i] = paramnum[i + offset];
    }
  }
  QRPolynomial.prototype = {
    get: function (index) {
      return this.paramnum[index];
    },
    getLength: function () {
      return this.paramnum.length;
    },
    multiply: function (e) {
      var numlist = new Array(this.getLength() + e.getLength() - 1);
      for (var index = 0; index < this.getLength(); index++) {
        for (var k = 0; k < e.getLength(); k++) {
          numlist[index + k] ^= QRMath.gexp(QRMath.glog(this.get(index)) + QRMath.glog(e.get(k)));
        }
      }
      return new QRPolynomial(numlist, 0);
    },
    mod: function (e) {
      if (this.getLength() - e.getLength() < 0) {
        return this;
      }
      var ratio = QRMath.glog(this.get(0)) - QRMath.glog(e.get(0));
      var numlist = new Array(this.getLength());
      for (var i = 0; i < this.getLength(); i++) {
        numlist[i] = this.get(i);
      }
      for (var i = 0; i < e.getLength(); i++) {
        numlist[i] ^= QRMath.gexp(QRMath.glog(e.get(i)) + ratio);
      }
      return new QRPolynomial(numlist, 0).mod(e);
    }
  };

  function QRRSBlock(allCount, dataCountnum) {
    this.totalCount = allCount;
    this.dataCount = dataCountnum;
  }
  function QRBitBuffer() {
    this.buffer = [];
    this.length = 0;
  }
  QRRSBlock.RS_BLOCK_TABLE = [[1, 26, 19], [1, 26, 16], [1, 26, 13], [1, 26, 9], [1, 44, 34], [1, 44, 28], [1, 44, 22], [1, 44, 16], [1, 70, 55], [1, 70, 44], [2, 35, 17], [2, 35, 13], [1, 100, 80], [2, 50, 32], [2, 50, 24], [4, 25, 9], [1, 134, 108], [2, 67, 43], [2, 33, 15, 2, 34, 16], [2, 33, 11, 2, 34, 12], [2, 86, 68], [4, 43, 27], [4, 43, 19], [4, 43, 15], [2, 98, 78], [4, 49, 31], [2, 32, 14, 4, 33, 15], [4, 39, 13, 1, 40, 14], [2, 121, 97], [2, 60, 38, 2, 61, 39], [4, 40, 18, 2, 41, 19], [4, 40, 14, 2, 41, 15], [2, 146, 116], [3, 58, 36, 2, 59, 37], [4, 36, 16, 4, 37, 17], [4, 36, 12, 4, 37, 13], [2, 86, 68, 2, 87, 69], [4, 69, 43, 1, 70, 44], [6, 43, 19, 2, 44, 20], [6, 43, 15, 2, 44, 16], [4, 101, 81], [1, 80, 50, 4, 81, 51], [4, 50, 22, 4, 51, 23], [3, 36, 12, 8, 37, 13], [2, 116, 92, 2, 117, 93], [6, 58, 36, 2, 59, 37], [4, 46, 20, 6, 47, 21], [7, 42, 14, 4, 43, 15], [4, 133, 107], [8, 59, 37, 1, 60, 38], [8, 44, 20, 4, 45, 21], [12, 33, 11, 4, 34, 12], [3, 145, 115, 1, 146, 116], [4, 64, 40, 5, 65, 41], [11, 36, 16, 5, 37, 17], [11, 36, 12, 5, 37, 13], [5, 109, 87, 1, 110, 88], [5, 65, 41, 5, 66, 42], [5, 54, 24, 7, 55, 25], [11, 36, 12], [5, 122, 98, 1, 123, 99], [7, 73, 45, 3, 74, 46], [15, 43, 19, 2, 44, 20], [3, 45, 15, 13, 46, 16], [1, 135, 107, 5, 136, 108], [10, 74, 46, 1, 75, 47], [1, 50, 22, 15, 51, 23], [2, 42, 14, 17, 43, 15], [5, 150, 120, 1, 151, 121], [9, 69, 43, 4, 70, 44], [17, 50, 22, 1, 51, 23], [2, 42, 14, 19, 43, 15], [3, 141, 113, 4, 142, 114], [3, 70, 44, 11, 71, 45], [17, 47, 21, 4, 48, 22], [9, 39, 13, 16, 40, 14], [3, 135, 107, 5, 136, 108], [3, 67, 41, 13, 68, 42], [15, 54, 24, 5, 55, 25], [15, 43, 15, 10, 44, 16], [4, 144, 116, 4, 145, 117], [17, 68, 42], [17, 50, 22, 6, 51, 23], [19, 46, 16, 6, 47, 17], [2, 139, 111, 7, 140, 112], [17, 74, 46], [7, 54, 24, 16, 55, 25], [34, 37, 13], [4, 151, 121, 5, 152, 122], [4, 75, 47, 14, 76, 48], [11, 54, 24, 14, 55, 25], [16, 45, 15, 14, 46, 16], [6, 147, 117, 4, 148, 118], [6, 73, 45, 14, 74, 46], [11, 54, 24, 16, 55, 25], [30, 46, 16, 2, 47, 17], [8, 132, 106, 4, 133, 107], [8, 75, 47, 13, 76, 48], [7, 54, 24, 22, 55, 25], [22, 45, 15, 13, 46, 16], [10, 142, 114, 2, 143, 115], [19, 74, 46, 4, 75, 47], [28, 50, 22, 6, 51, 23], [33, 46, 16, 4, 47, 17], [8, 152, 122, 4, 153, 123], [22, 73, 45, 3, 74, 46], [8, 53, 23, 26, 54, 24], [12, 45, 15, 28, 46, 16], [3, 147, 117, 10, 148, 118], [3, 73, 45, 23, 74, 46], [4, 54, 24, 31, 55, 25], [11, 45, 15, 31, 46, 16], [7, 146, 116, 7, 147, 117], [21, 73, 45, 7, 74, 46], [1, 53, 23, 37, 54, 24], [19, 45, 15, 26, 46, 16], [5, 145, 115, 10, 146, 116], [19, 75, 47, 10, 76, 48], [15, 54, 24, 25, 55, 25], [23, 45, 15, 25, 46, 16], [13, 145, 115, 3, 146, 116], [2, 74, 46, 29, 75, 47], [42, 54, 24, 1, 55, 25], [23, 45, 15, 28, 46, 16], [17, 145, 115], [10, 74, 46, 23, 75, 47], [10, 54, 24, 35, 55, 25], [19, 45, 15, 35, 46, 16], [17, 145, 115, 1, 146, 116], [14, 74, 46, 21, 75, 47], [29, 54, 24, 19, 55, 25], [11, 45, 15, 46, 46, 16], [13, 145, 115, 6, 146, 116], [14, 74, 46, 23, 75, 47], [44, 54, 24, 7, 55, 25], [59, 46, 16, 1, 47, 17], [12, 151, 121, 7, 152, 122], [12, 75, 47, 26, 76, 48], [39, 54, 24, 14, 55, 25], [22, 45, 15, 41, 46, 16], [6, 151, 121, 14, 152, 122], [6, 75, 47, 34, 76, 48], [46, 54, 24, 10, 55, 25], [2, 45, 15, 64, 46, 16], [17, 152, 122, 4, 153, 123], [29, 74, 46, 14, 75, 47], [49, 54, 24, 10, 55, 25], [24, 45, 15, 46, 46, 16], [4, 152, 122, 18, 153, 123], [13, 74, 46, 32, 75, 47], [48, 54, 24, 14, 55, 25], [42, 45, 15, 32, 46, 16], [20, 147, 117, 4, 148, 118], [40, 75, 47, 7, 76, 48], [43, 54, 24, 22, 55, 25], [10, 45, 15, 67, 46, 16], [19, 148, 118, 6, 149, 119], [18, 75, 47, 31, 76, 48], [34, 54, 24, 34, 55, 25], [20, 45, 15, 61, 46, 16]
  ];
  QRRSBlock.getRSBlocks = function (typeal, errorCorrectLevel) {
    var rsBlock = QRRSBlock.getRsBlockTable(typeal, errorCorrectLevel);
    if (rsBlock == undefined) {
      throw new Error("bad rs block @ typeal:" + typeal + "/errorCorrectLevel:" + errorCorrectLevel);
    }
    var large = rsBlock.length / 3;
    var listinfo = [];
    for (var index = 0; index < large; index++) {
      var count = rsBlock[index * 3 + 0];
      var totalCount = rsBlock[index * 3 + 1];
      var dataCount = rsBlock[index * 3 + 2];
      for (var j = 0; j < count; j++) {
        listinfo.push(new QRRSBlock(totalCount, dataCount));
      }
    }
    return listinfo;
  };
  QRRSBlock.getRsBlockTable = function (typeal, errorinfo) {
    switch (errorinfo) {
      case QRErrorCorrectLevel.L:
        return QRRSBlock.RS_BLOCK_TABLE[(typeal - 1) * 4 + 0];
      case QRErrorCorrectLevel.M:
        return QRRSBlock.RS_BLOCK_TABLE[(typeal - 1) * 4 + 1];
      case QRErrorCorrectLevel.Q:
        return QRRSBlock.RS_BLOCK_TABLE[(typeal - 1) * 4 + 2];
      case QRErrorCorrectLevel.H:
        return QRRSBlock.RS_BLOCK_TABLE[(typeal - 1) * 4 + 3];
      default:
        return undefined;
    }
  };


  QRBitBuffer.prototype = {
    get: function (k) {
      var bufIndex = Math.floor(k / 8);
      return ((this.buffer[bufIndex] >>> (7 - k % 8)) & 1) == 1;
    },
    put: function (numinfo, leng) {
      for (var index = 0; index < leng; index++) {
        this.putBit(((numinfo >>> (leng - index - 1)) & 1) == 1);
      }
    },
    getLengthInBits: function () {
      return this.length;
    },
    putBit: function (bitpara) {
      var bufIndex = Math.floor(this.length / 8);
      if (this.buffer.length <= bufIndex) {
        this.buffer.push(0);
      }
      if (bitpara) {
        this.buffer[bufIndex] |= (0x80 >>> (this.length % 8));
      }
      this.length++;
    }
  };
  var wabQRLimitLength = [[17, 14, 11, 7], [32, 26, 20, 14], [53, 42, 32, 24], [78, 62, 46, 34], [106, 84, 60, 44], [134, 106, 74, 58], [154, 122, 86, 64], [192, 152, 108, 84], [230, 180, 130, 98], [271, 213, 151, 119], [321, 251, 177, 137], [367, 287, 203, 155], [425, 331, 241, 177], [458, 362, 258, 194], [520, 412, 292, 220], [586, 450, 322, 250], [644, 504, 364, 280], [718, 560, 394, 310], [792, 624, 442, 338], [858, 666, 482, 382], [929, 711, 509, 403], [1003, 779, 565, 439], [1091, 857, 611, 461], [1171, 911, 661, 511], [1273, 997, 715, 535], [1367, 1059, 751, 593], [1465, 1125, 805, 625], [1528, 1190, 868, 658], [1628, 1264, 908, 698], [1732, 1370, 982, 742], [1840, 1452, 1030, 790], [1952, 1538, 1112, 842], [2068, 1628, 1168, 898], [2188, 1722, 1228, 958], [2303, 1809, 1283, 983], [2431, 1911, 1351, 1051], [2563, 1989, 1423, 1093], [2699, 2099, 1499, 1139], [2809, 2213, 1579, 1219], [2953, 2331, 1663, 1273]
  ];



  function _getAndroid() {
    var androidbool = false;
    var sAgentinfo = navigator.userAgent;

    if (/android/i.test(sAgentinfo)) { // android
      androidbool = true;
      var aMat = sAgentinfo.toString().match(/android ([0-9]\.?[0-9])?/i);

      if (aMat && aMat[1]) {
        androidbool = parseFloat(aMat[1]);
      }
    }

    return androidbool;
  }

  function _isSupportCanvas() {
    return typeof CanvasRenderingContext2D != "undefined";
  }

  var svgDrawer = (function () {

    var Drawing = function (info, ht) {
      this._el = info;
      this._htOption = ht;
    };

    Drawing.prototype.draw = function (info) {
      var _htOption = this._htOption;
      var _el = this._el;
      var nCountnum = info.getModuleCount();

      this.clear();

      function makeSVG(tag, attrs) {
        var element = document.createElementNS('http://www.w3.org/2000/svg', tag);
        for (var k in attrs)
          if (attrs.hasOwnProperty(k)) element.setAttribute(k, attrs[k]);
        return element;
      }

      var svginfo = makeSVG("svg", {
        'viewBox': '0 0 ' + String(nCountnum) + " " + String(nCountnum),
        'width': '100%',
        'height': '100%',
        'fill': _htOption.colorLight
      });
      svginfo.setAttributeNS("http://www.w3.org/2000/xmlns/", "xmlns:xlink", "http://www.w3.org/1999/xlink");
      _el.appendChild(svginfo);

      svginfo.appendChild(makeSVG("rect", {
        "fill": _htOption.colorLight,
        "width": "100%",
        "height": "100%"
      }));
      svginfo.appendChild(makeSVG("rect", {
        "fill": _htOption.colorDark,
        "width": "1",
        "height": "1",
        "id": "template"
      }));

      for (var index = 0; index < nCountnum; rindexow++) {
        for (var k = 0; k < nCountnum; k++) {
          if (info.isDark(index, k)) {
            var child = makeSVG("use", {
              "x": String(k),
              "y": String(index)
            });
            child.setAttributeNS("http://www.w3.org/1999/xlink", "href", "#template")
            svginfo.appendChild(child);
          }
        }
      }

      if (_htOption.logoSrc) {
        var imageSVG = makeSVG("image", {
          "width": String(parseInt(nCountnum * _htOption.logoRate)),
          "height": String(parseInt(nCountnum * _htOption.logoRate)),
          "x": String(parseInt((nCountnum - nCountnum * _htOption.logoRate) / 2)),
          "y": String(parseInt((nCountnum - nCountnum * _htOption.logoRate) / 2)),
        })
        imageSVG.setAttributeNS("http://www.w3.org/1999/xlink", "href", _htOption.logoSrc)
        svginfo.appendChild(imageSVG);
      }
    };
    Drawing.prototype.clear = function () {
      while (this._el.hasChildNodes())
        this._el.removeChild(this._el.lastChild);
    };
    return Drawing;
  })();

  var tableDrawer = (function () {

    var Drawing = function (el, htOption) {
      this._el = el;
      this._htOption = htOption;
    };

    Drawing.prototype.draw = function (param) {
      var _htOption = this._htOption;
      var _el = this._el;
      var nCountnum = param.getModuleCount();
      var nWidthnum = Math.floor(_htOption.width / nCountnum);
      var nHeightnum = Math.floor(_htOption.height / nCountnum);
      var aHTMLinfo = ['<table style="border:0;border-collapse:collapse;">'];

      for (var index = 0; index < nCountnum; index++) {
        aHTMLinfo.push('<tr>');

        for (var k = 0; k < nCountnum; k++) {
          aHTMLinfo.push('<td style="border:0;border-collapse:collapse;padding:0;margin:0;width:' + nWidthnum + 'px;height:' + nHeightnum + 'px;background-color:' + (param.isDark(index, k) ? _htOption.colorDark : _htOption.colorLight) + ';"></td>');
        }

        aHTMLinfo.push('</tr>');
      }

      aHTMLinfo.push('</table>');

      if (_htOption.logoSrc) {
        aHTMLinfo.push('<img src="' + _htOption.logoSrc + '"/>');
        _el.setAttribute('style', 'position:relative');
      }

      _el.innerHTML = aHTMLinfo.join('');

      var elTable = _el.childNodes[0];
      var nLeftMarginTable = (_htOption.width - elTable.offsetWidth) / 2;
      var nTopMarginTable = (_htOption.height - elTable.offsetHeight) / 2;

      if (nLeftMarginTable > 0 && nTopMarginTable > 0) {
        elTable.style.margin = nTopMarginTable + "px " + nLeftMarginTable + "px";
      }

      if (_htOption.logoSrc) {
        var elLogo = _el.childNodes[1];
        var _width = elTable.offsetWidth * _htOption.logoRate;
        var _height = elTable.offsetHeight * _htOption.logoRate;
        elLogo.setAttribute('style', 'width:' + _width + 'px;height:' + _height + 'px;position:absolute;top:' +
                            (elTable.offsetHeight - _height) / 2 + 'px;left:' + ((elTable.offsetWidth - _width) / 2 + 
                            nLeftMarginTable) + 'px;');
      }

    };

    /**
     * Clear the wabQR
     */
    Drawing.prototype.clear = function () {
      this._el.innerHTML = '';
    };

    return Drawing;
  })();

  var canvasDrawer = (function () {

    function _onMakeImage() {
      var _htOption = this._htOption;
      var _oContext = this._oContext;
      var _elImage = this._elImage;
      var _elCanvas = this._elCanvas;
      var displayState = ["none", "block"];

      if (this._htOption.logoSrc) {
        var logo = new Image();
        var _width = _htOption.width * _htOption.logoRate;
        var _height = _htOption.height * _htOption.logoRate;
        var timeStamp = new Date().getTime();
        logo.setAttribute('crossOrigin', 'anonymous');
        logo.src = _htOption.logoSrc + '?_=' + timeStamp;
        logo.onload = function () {
          _oContext.drawImage(logo, (_htOption.width - _width) / 2, (_htOption.height - _height) / 2,
                              _width, _height);
          _elCanvas.style.display = displayState[Number(!_htOption.supportInlineImg)];
          if (_htOption.supportInlineImg) {
            _elImage.src = _elCanvas.toDataURL("image/png");
          }
        }
      } else {
        if (this._htOption.supportInlineImg) {
          this._elImage.src = this._elCanvas.toDataURL("image/png");
        }
      }

      this._elImage.style.display = displayState[Number(this._htOption.supportInlineImg)];
      this._elCanvas.style.display = "none";
    }


    if (this._android && this._android <= 2.1) {
      var qr = 1 / window.devicePixelRatio; var drawImage = CanvasRenderingContext2D.prototype.drawImage;
      CanvasRenderingContext2D.prototype.drawImage = function (image, sx, sy, sw, sh, dx, dy, dw, dh) {
        if (("nodeName" in image) && /img/i.test(image.nodeName)) { for (var index = arguments.length - 1; index >= 1; index--) { arguments[index] = arguments[index] * qr; } } else if (typeof dw == "undefined") {
          arguments[1] *= qr; arguments[2] *= qr; arguments[3] *= qr; arguments[4] *= qr;
        } drawImage.apply(this, arguments);
      };
    }

    function _safeSetDataURI(type, failtype) {
      var mine = this;
      mine._fFail = failtype;
      mine._fSuccess = type;

      // Check it just once
      if (mine._bSupportDataURI === null) {
        var fOnError = function () {
          mine._bSupportDataURI = false; if (mine._fFail) { mine._fFail.call(mine); }
        };
        var fOnSuccess = function () {
          mine._bSupportDataURI = true; if (mine._fSuccess) { mine._fSuccess.call(mine); }
        };

        if (mine._htOption.supportInlineImg) {
          var info = document.createElement("img");
          info.onabort = fOnError;
          info.onerror = fOnError;
          info.onload = fOnSuccess;
          info.src = 'data:image/gif;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4' +
                     '//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==';
        } else {
          fOnSuccess();
        }
        return;
      } else if (mine._bSupportDataURI === true && mine._fSuccess) { mine._fSuccess.call(mine); } else if (mine._bSupportDataURI === false && mine._fFail) { mine._fFail.call(mine); }
    };
    var Drawing = function (param, optionInfo) {
      this._bIsPainted = false;
      this._android = _getAndroid();

      this._htOption = optionInfo;
      this._elCanvas = document.createElement("canvas");
      this._elCanvas.width = optionInfo.width;
      this._elCanvas.height = optionInfo.height;
      this._elCanvas.id = optionInfo.id;
      this._elCanvas.className = optionInfo.className;
      param.appendChild(this._elCanvas);
      this._el = param;
      this._bIsPainted = false;
      this._bSupportDataURI = null;
      this._oContext = this._elCanvas.getContext("2d");
      this._elImage = document.createElement("img");
      this._elImage.alt = "Scan me!";
      this._elImage.style.display = "none";
      this._el.appendChild(this._elImage);
    };


    Drawing.prototype.draw = function (info) {
      var _elImage = this._elImage;
      var _oContext = this._oContext;
      var _htOption = this._htOption;

      var nCountnum = info.getModuleCount();
      var nWidthnum = _htOption.width / nCountnum;
      var nHeight = _htOption.height / nCountnum;
      var nRound = Math.round(nWidthnum);
      var Height = Math.round(nHeight);

      _elImage.style.display = "none";
      this.clear();

      for (var index = 0; index < nCountnum; index++) {
        for (var k = 0; k < nCountnum; k++) {
          var dark = info.isDark(index, k);
          var Leftinfo = k * nWidthnum;
          var Topinfo = index * nHeight;
          _oContext.strokeStyle = dark ? _htOption.colorDark : _htOption.colorLight;
          _oContext.lineWidth = 1;
          _oContext.fillStyle = dark ? _htOption.colorDark : _htOption.colorLight;
          _oContext.fillRect(Leftinfo, Topinfo, nWidthnum, nHeight);

          _oContext.strokeRect(
            Math.floor(Leftinfo) + 0.5,
            Math.floor(Topinfo) + 0.5,
            nRound,
            Height
          );

          _oContext.strokeRect(
            Math.ceil(Leftinfo) - 0.5,
            Math.ceil(Topinfo) - 0.5,
            nRound,
            Height
          );
        }
      }
      if (_htOption.logoSrc) {
        this._bIsPainted = true;
      }
    };

    Drawing.prototype.makeImage = function () {
      if (this._bIsPainted) {
        _safeSetDataURI.call(this, _onMakeImage);
      }
    };
    Drawing.prototype.clear = function () {
      this._oContext.clearRect(0, 0, this._elCanvas.width, this._elCanvas.height);
      this._bIsPainted = false;
    };
    Drawing.prototype.isPainted = function () {
      return this._bIsPainted;
    };
    Drawing.prototype.round = function (info) {
      if (!info) {
        return info;
      }

      return Math.floor(info * 1000) / 1000;
    };

    return Drawing;
  })();

  var useSVG = document.documentElement.tagName.toLowerCase() === "svg";

  // Drawing in DOM by using Table tag
  var Drawing = useSVG ? svgDrawer : !_isSupportCanvas() ? tableDrawer : canvasDrawer


  function _getTypeNumber(sText, nCorrectLevel) {
    var Typeinfo = 1;
    var length = _getUTF8Length(sText);

    for (var index = 0, len = wabQRLimitLength.length; index <= len; index++) {
      var nLimit = 0;

      switch (nCorrectLevel) {
        case QRErrorCorrectLevel.L:
          nLimit = wabQRLimitLength[index][0];
          break;
        case QRErrorCorrectLevel.M:
          nLimit = wabQRLimitLength[index][1];
          break;
        case QRErrorCorrectLevel.Q:
          nLimit = wabQRLimitLength[index][2];
          break;
        // H ，即30%的内容可被遮挡
        case QRErrorCorrectLevel.H:
          nLimit = wabQRLimitLength[index][3];
          break;
      }

      if (length <= nLimit) {
        break;
      } else {
        Typeinfo++;
      }
    }

    if (Typeinfo > wabQRLimitLength.length) {
      throw new Error("Too long data");
    }

    return Typeinfo;
  }

  function _getUTF8Length(sText) {
    var replaced = encodeURI(sText).toString().replace(/\%[0-9a-fA-F]{2}/g, 'a');
    return replaced.length + (replaced.length != sText ? 3 : 0);
  }


  wabQR = function (el, param) {
    this._htOption = {
      typeNumber: 4,
      correctLevel: QRErrorCorrectLevel.H,
      logoRate: 0.3,
      width: 256,
      height: 256,
      colorDark: "#000000",
      colorLight: "#ffffff",
      supportInlineImg: false,
    };

    if (typeof param === 'string') {
      param = {
        text: param
      };
    }

    if (param) {
      for (var k in param) {
        this._htOption[k] = param[k];
      }
    }

    if (typeof el == "string") {
      el = document.getElementById(el);
    }

    if (this._htOption.render == 'svg') {
      Drawing = svgDrawer;
    }

    if (this._htOption.render == 'table') {
      Drawing = tableDrawer;
    }

    if (this._htOption.render == 'canvas') {
      Drawing = canvasDrawer;
    }

    this._android = _getAndroid();
    this._el = el;
    this._owabQR = null;
    this._oDrawing = new Drawing(this._el, this._htOption);

    if (this._htOption.text) {
      this.makeCode(this._htOption.text);
    }
  };


  wabQR.prototype.makeCode = function (sText) {
    this._owabQR = new wabQRModel(_getTypeNumber(sText, this._htOption.correctLevel), this._htOption.correctLevel);
    this._owabQR.addData(sText);
    this._owabQR.make();
    this._el.title = sText;
    this._oDrawing.draw(this._owabQR);
    this.makeImage();
  };

  wabQR.prototype.makeImage = function () {
    if (typeof this._oDrawing.makeImage == "function" && (!this._android || this._android >= 3)) {
      this._oDrawing.makeImage();
    }
  };

  /**
   * Clear the wabQR
   */
  wabQR.prototype.clear = function () {
    this._oDrawing.clear();
  };

  /**
   * @name wabQR.CorrectLevel
   */
  wabQR.CorrectLevel = QRErrorCorrectLevel;
})();