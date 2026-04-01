<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Pragma" content="no-cache" />
    <link rel="stylesheet" href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
    <link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
    <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
    <script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
    <script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
    <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
    <script language="Javascript"
        src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>

    <title>Optic information</title>

    <style>
        .dragbar {
            height: 15px;
            background-Image: url("../../../images/scale.gif");
        }

        .draghandle {
            height: 15px;
            width: 28px;
            border: 1px solid #444;
            overflow: hidden;
            background: #3d642d;
            top: 0px;
            left: 0px;
            z-index: 10;
            cursor: pointer;
            position: absolute;
        }
    </style>

    <script language="JavaScript" type="text/javascript">
        var ProductType = '<%HW_WEB_GetProductType();%>';
        var CfgMode = '<%HW_WEB_GetCfgMode();%>';
        var SfpExInfoFlag = '<%HW_WEB_GetFeatureSupport(AMP_FT_EXINFO_OPTIC);%>';
        var FtXdPonSupport = '<%HW_WEB_GetFeatureSupport(FT_XD_PON_SURPPORTED);%>';

        function UserOpticInfo(domain, TXPower, SupplyVottage, TransceiverTemperature, BiasCurrent) {
            this.domain = domain;
            this.transOpticPower = (10 * Math.log(TXPower / 10000.00, 10)).toFixed(1);
            this.voltage = (SupplyVottage / 10).toFixed(0);
            this.temperature = (TransceiverTemperature / 256).toFixed(0);
            this.bias = (BiasCurrent / 500).toFixed(0);
        }

        var opticInfos = <% HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.X_HW_LANOpticInterfaceConfig.1., TXPower|SupplyVottage|TransceiverTemperature|BiasCurrent, UserOpticInfo);%>;
        var opticInfo = opticInfos[0];
        var ontPonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.AccessMode);%>';
        if ((ontPonMode == 'gpon') || (ontPonMode.indexOf("gpon")) > 0) {
            ontPonMode = 'gpon';
        }
        else if ((ontPonMode == 'epon') || (ontPonMode.indexOf("epon")) > 0) {
            ontPonMode = 'epon';
        }
        else {
            ontPonMode = 'ge';
        }

        var ontPonRFNum = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.RF.RfPortNum);%>';
        if ('' == ontPonRFNum) {
            ontPonRFNum = '0';
        }
        var opticPower = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.SMP.APM.ChipStatus.Optical);%>';
        var opticStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.GetOptStaus.status);%>';
        var opticType = '<%HW_WEB_GetOpticType();%>';
        var CfgMode = '<%HW_WEB_GetCfgMode();%>';
        var curWebFrame = '<%HW_WEB_GetWEBFramePath();%>';
        var curUserType = '<%HW_WEB_GetUserType();%>';
        var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
        var IPOnlyFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FT_IPONLY);%>';
        var RFAdjustFlag = false;
        var ont2onrEnable = 0;
        var onr = new Array('amp_optinfo_ontinfo');
        var TelMexFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_TELMEX);%>';

        if ((1 == '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>') && ('ENGLISH' == curLanguage.toUpperCase())) {
            ont2onrEnable = 1;
        }

        function ont2onr(resourcename) {
            var index = 0;
            var len = onr.length;

            if (0 == ont2onrEnable) {
                return resourcename;
            }

            for (index = 0; index < len; index++) {
                if (resourcename == onr[index]) {
                    return resourcename + '_onr';
                }
            }

            return resourcename;
        }

        function stCATVConfiguration(domain, Enable, RFOutputAdjustment) {
            this.domain = domain;
            this.Enable = Enable;
            this.RFOutputAdjustment = RFOutputAdjustment;
        }

        if ((1 == '<%HW_WEB_GetFeatureSupport(AMP_FT_RF_ADJUST);%>') && ontPonRFNum != '0' && curUserType == '0') {
            RFAdjustFlag = true;
        }

        function GetLinkState() {
            var State = <% HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.OntOnlineStatus.ontonlinestatus);%>;

            if (State == 1 || State == "1") {
                return "已连接";
            }
            else {
                return "未连接";
            }
        }

        function GetLinkTime() {
            var LinkTime = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.EPONLinkInfo.PONLinkTime);%>';
            var LinkDesc;

            LinkDesc = parseInt(LinkTime / 3600) + "小时" + parseInt((LinkTime % 3600) / 60) + "分钟" + parseInt(((LinkTime % 3600) % 60)) + "秒";
            if (GetLinkState() == "未连接") {
                LinkDesc = "--";
            }

            return LinkDesc;
        }

        function GetPONTxPackets() {
            var PONTxPackets = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.WANDevice.1.X_HW_PonInterface.Stats.PacketsSent);%>';
            var PONTxPacketsString = parseInt(PONTxPackets);
            return PONTxPacketsString;
        }

        function GetPONRxPackets() {
            var PONTxPackets = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.WANDevice.1.X_HW_PonInterface.Stats.PacketsReceived);%>';
            var PONTxPacketsString = parseInt(PONTxPackets);
            return PONTxPacketsString;
        }

        function LoadOpticRef() {
            getElById("ref_head").style.display = "";
            getElById("ref_tx").style.display = "";
            getElById("ref_vol").style.display = "";
            getElById("ref_cur").style.display = "";
            getElById("ref_temp").style.display = "";
        }

        function stSFPEnble(domain, Enable) {
            this.domain = domain;
            this.Enable = Enable;
        }
        var Sfps = <% HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.4.WANSFPInterfaceConfig, Enable, stSFPEnble);%>;

        var SfpEnble = Sfps[0];

        function LoadFrame() {
            var all = document.getElementsByTagName("td");
            for (var i = 0; i < all.length; i++) {
                var b = all[i];
                if (b.getAttribute("BindText") == null) {
                    continue;
                }
                b.innerHTML = status_optinfo_language[b.getAttribute("BindText")];
            }


            if (SfpExInfoFlag == '1' && ontPonMode != 'gpon') {
                $("#TROpticLinkStaus").css("display", "");
                $("#TROpticVendorSN").css("display", "");
                $("#TROpticVendorName").css("display", "");
            }
            else {
                $("#TROpticLinkStaus").css("display", "none");
                $("#TROpticVendorSN").css("display", "none");
                $("#TROpticVendorName").css("display", "none");
            }

            if (('1' == TelMexFlag) || ('GPON' != ontPonMode.toUpperCase())) {
                setDisplay("DivOltInfo", 0);
                setDisplay("ont_info_head", 0);
            }
            else {
                setDisplay("DivOltInfo", 1);
                setDisplay("ont_info_head", 1);
            }

            if (curWebFrame != 'frame_UNICOM') {
                setDisplay("table_ani_linkup_time_info", 0);
                setDisplay("table_ani_linkup_time_content", 0);
            }
            if (curWebFrame == 'frame_UNICOM') {
                setDisplay("DivOltInfo", 0);
            }

            if (ontPonMode == 'ge' || ontPonMode == 'GE') {
                setDisplay("optic_status_tr", 0);
                setDisplay("DivOltInfo", 0);
                setDisplay("table_ani_linkup_time_info", 0);
                setDisplay("table_ani_linkup_time_content", 0);
            }

            if ('1' == IPOnlyFlag) {
                setDisplay("optic_status_tr", 1);
            }

            LoadOpticRef();

            if (true == RFAdjustFlag && ontPonRFNum != '0') {
                $("#ref_catvtx").html("≥60 dBuV");
                if (opticInfo.rfOutputPower == "--") {
                    $("#tr2_2").html(opticInfo.rfOutputPower + " dBuV(dBuV=dBmV+60)");
                }
                else {
                    var rfOutputPower = parseInt(opticInfo.rfOutputPower) + 60;
                    $("#tr2_2").html(rfOutputPower + " dBuV(dBuV=dBmV+60)");
                }
            }

        }

        var g_rfAdjust = 0;
        var g_prev_RFadjust = 0xff;
        var RFAdjustActionTimer = null;
        var RFAdjustActionTimer1 = null;

        function Left2rfAdjust(left_) {
            var dragbar = $(".dragbar");
            var rfadjust_ = (left_ - dragbar.offset().left) / 2 - 127;

            return parseInt(rfadjust_);
        }

        function throttle_RFAdjustAction() {
            if (RFAdjustActionTimer) {
                clearTimeout(RFAdjustActionTimer)
            }

            RFAdjustActionTimer = setTimeout(RFAdjustAction, 1000);
        }

        function RFAdjustActiondisplay() {
            $.ajax({
                type: "POST",
                async: true,
                cache: false,
                url: "../opticinfo/getOpticInfo.asp",
                success: function (data) {
                    var opticInfos1 = dealDataWithFun(data);
                    var OltOptic1 = opticInfos1[0];
                    if (OltOptic1.rfOutputPower == "--") {
                        $("#tr2_2").html(OltOptic1.rfOutputPower + " dBuV(dBuV=dBmV+60)");
                    }
                    else {
                        var rfOutputPower = parseInt(OltOptic1.rfOutputPower) + 60;
                        $("#tr2_2").html(rfOutputPower + " dBuV(dBuV=dBmV+60)");
                    }
                }
            });
        }

        function RFAdjustAction() {
            // 防止重复设置
            if (parseInt(g_prev_RFadjust) == parseInt(g_rfAdjust)) {
                return false;
            }
            g_prev_RFadjust = parseInt(g_rfAdjust);

            $.ajax({
                type: "POST",
                async: true,
                cache: false,
                url: "set.cgi?x=InternetGatewayDevice.X_CATVConfiguration&RequestFile=html/amp/opticinfo/getOpticInfo.asp",
                data: "x.RFOutputAdjustment=" + g_rfAdjust + "&x.X_HW_Token=" + getValue('onttoken'),
                success: function (data) {
                    if (RFAdjustActionTimer1) {
                        clearTimeout(RFAdjustActionTimer1)
                    }

                    RFAdjustActionTimer1 = setTimeout(RFAdjustActiondisplay, 500);
                }
            });
        }



        function RFAdjust(op) {
            var handle = $(".draghandle");
            var dragbar = $(".dragbar");
            var bar_left = parseInt(handle.offset().left);
            var maxlen = parseInt(dragbar.width()) - parseInt(handle.outerWidth());

            if (op == 1) {
                bar_left = bar_left - 10;
                if (bar_left < dragbar.offset().left) {
                    bar_left = dragbar.offset().left;
                }
            }
            else {
                bar_left = bar_left + 10;
                if (bar_left > parseInt(maxlen + dragbar.offset().left)) {
                    bar_left = parseInt(maxlen + dragbar.offset().left);
                }
            }

            g_rfAdjust = Left2rfAdjust(bar_left);

            handle.css({
                left: bar_left,
                top: dragbar.offset().top
            });

            $("#drag_bar_value").html(" " + g_rfAdjust / 10 + " dB");

            throttle_RFAdjustAction();
        }

        function leftCountAdjust(count) {
            return ' style="display:none"';
        }

    </script>

</head>

<body class="mainbody" onLoad="LoadFrame();">

    <script language="JavaScript" type="text/javascript">
        HWCreatePageHeadInfo("amp_optinfo_title",
            GetDescFormArrayById(status_optinfo_language, "amp_optinfo_title_head"),
            GetDescFormArrayById(status_optinfo_language, "amp_optinfo_title"), false);
    </script>

    <div class="title_spread"></div>

    <div id="ont_info_head" class="func_title" style="display:none">
        <script>document.write(status_optinfo_language[ont2onr("amp_optinfo_ontinfo")]);</script>
    </div>

    <table id="optic_status_table" width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_bg"
        style="table-layout:fixed; word-break:break-all">
        <tr>
            <script language="javascript" type="text/javascript">
                document.write('<td class="tableTopTitle width_per35">&nbsp;</td>');
                document.write('<td class="tableTopTitle" BindText="amp_optinfo_cur"></td>');
                document.write('<td id="ref_head" class="tableTopTitle" BindText="amp_optinfo_ref" style="display:none"></td>');
            </script>
        </tr>
        <tr>
            <script language="javascript" type="text/javascript">
                var count = 0;
                document.write('<td class="width_per35 table_title" BindText="amp_optic_txpower"></td>');
                document.write('<td class="table_right">');
                if (opticInfo == null) {
                    document.write(status_optinfo_language['amp_optic_unknown']);
                } else {
                    document.write(opticInfo.transOpticPower + ' ' + status_optinfo_language['amp_optic_dBm']);
                }
                document.write('</td>');
                document.write('<td id="ref_tx" class="table_right" ' + leftCountAdjust(count++) + '>');
                document.write(status_optinfo_language['amp_optic_txref_lan']);
                document.write('</td>');
            </script>
        </tr>
        <tr>
            <script language="javascript" type="text/javascript">
                var count = 0;
                document.write('<td class="width_per35 table_title" BindText="amp_optic_voltage"></td>');
                document.write('<td class="table_right">');
                if (opticInfo == null) {
                    document.write(status_optinfo_language['amp_optic_unknown']);
                } else {
                    document.write(opticInfo.voltage + ' ' + status_optinfo_language['amp_optic_mV']);
                }
                document.write('</td>');
                document.write('<td id="ref_vol" class="table_right" BindText="amp_optic_volref" ' + leftCountAdjust(count++) + '></td>');
            </script>
        </tr>
        <tr>
            <script language="javascript" type="text/javascript">
                var count = 0;
                document.write('<td class="width_per35 table_title" BindText="amp_optic_current"></td>');
                document.write('<td class="table_right">');
                if (opticInfo == null) {
                    document.write(status_optinfo_language['amp_optic_unknown']);
                } else {
                    document.write(opticInfo.bias + ' ' + status_optinfo_language['amp_optic_mA']);
                }
                document.write('</td>');
                document.write('<td id="ref_cur" class="table_right" BindText="amp_optic_curref" ' + leftCountAdjust(count++) + '></td>');
            </script>
        </tr>
        <tr>
            <script language="javascript" type="text/javascript">
                var count = 0;
                document.write('<td class="width_per35 table_title" BindText="amp_optic_temp"></td>');
                if ((ProductType == '2') && (ontPonMode != 'gpon')) {
                    document.write('<td class="table_right" colspan="2">');
                } else {
                    document.write('<td class="table_right">');
                }
                if (opticInfo == null) {
                    document.write(status_optinfo_language['amp_optic_unknown']);
                } else {
                    document.write(opticInfo.temperature + '&nbsp;' + '℃');
                }
                document.write('</td>');
                document.write('<td id="ref_temp" class="table_right" BindText="amp_optic_tempref" ' + leftCountAdjust(count++) + '></td>');
            </script>
        </tr>
    </table>
    </div>
</body>

</html>