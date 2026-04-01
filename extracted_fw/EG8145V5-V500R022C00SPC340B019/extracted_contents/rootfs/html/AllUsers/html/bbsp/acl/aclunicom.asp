<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Pragma" content="no-cache" />
    <link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css" />
    <link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
    <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
    <title>ACL</title>
    <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
    <script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
    <script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"
        type="text/javascript"></script>
    <script language="javascript" src="../common/userinfo.asp"></script>
    <script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
    <script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, acl_language);%>"></script>
    <script language="JavaScript" type="text/javascript">
        var FltsecLevel = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>'.toUpperCase();
        var icmpEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.Dosfilter.IcmpEchoReplyEn);%>'
        var pingEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.Dosfilter.PingSweepEn);%>'

        var SingleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_SINGLE_WLAN);%>';
        var DoubleFreqFlag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_DOUBLE_WLAN);%>';
        var LanHttpDisableFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_LANHTTP_EDIT_DISABLE);%>';
        var SingleFlag = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
        var PortAclFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PORT_ACL);%>';
        var HideInfoFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_HIDE_INFO);%>';
        var HideTelnet = '<%HW_WEB_GetFeatureSupport(BBSP_FT_WEB_TELNET_HIDE);%>';
        var HTTPPortFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_WANSERVICE_PORT);%>';
        var FtpFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_USB);%>';
        var TelmexFlag = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TELMEX);%>';
        var IsViettel8045A2Flag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_VIETTEL_8045MODE);%>';
        var telmexflag = <%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_TELMEX);%>;

        var selctIndex = -1;
        var wantelflag = '<%HW_WEB_GetRemoteTelnetAbility();%>';
        var curUserType = '<%HW_WEB_GetUserType();%>';
        var IsGlobeFlag = '<%HW_WEB_GetFeatureSupport(FT_MNGT_GLOBE_XD);%>';
        var IsGlobe1OntFlag = '<%HW_WEB_GetFeatureSupport(FT_MNGT_GLOBE1_ONT);%>';
        var IsGlobe2OntFlag = '<%HW_WEB_GetFeatureSupport(FT_MNGT_GLOBE2);%>';
        var TypeWord = '<%HW_WEB_GetTypeWordMode();%>';
        var CfgModeWord = '<%HW_WEB_GetCfgMode();%>';
        var TableName = "SIPWhiteListConfigList";
        var ProductType = '<%HW_WEB_GetProductType();%>';
        var BeltelePONFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOM);%>';
        var BelteleLanFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOMLAN);%>';
        var certificateFlag = '<%HW_WEB_GetFeatureSupport(FT_SSMP_TELMEX_TELNET);%>';
        var DefaultRule;
        var securityAccessFlag = '<%HW_WEB_GetFeatureSupport(FT_SECURITY_ACCESS);%>';
        var isWanAccess = '<%HW_WEB_GetFeatureSupport(FT_WEB_WAN_ACCESS);%>';

        function IsNeedAddSafeDesForBelTelecom() {
            if ((BeltelePONFlag == 1) || (BelteleLanFlag == 1) || (CfgModeWord.toUpperCase().indexOf("BELTELECOM") >= 0)) {
                return true;
            }

            return false;
        }


        function wanwhitelist(domain, WANSrcWhiteListEnable, WANSrcWhiteListNumberOfEntries) {
            this.domain = domain;
            this.WANSrcWhiteListEnable = WANSrcWhiteListEnable;
            this.WANSrcWhiteListNumberOfEntries = WANSrcWhiteListNumberOfEntries;
        }

        function IsTelmexOpenAccess() {
            if (ProductType == '2') {
                return ((CfgModeWord.toUpperCase() == 'TELMEXVULA') ||
                        (CfgModeWord.toUpperCase() == 'TELMEXACCESS')) ? true : false;
            } else {
                return ((CfgModeWord.toUpperCase() == 'TELMEXVULA') ||
                        (CfgModeWord.toUpperCase() == 'TELMEXACCESS') ||
                        (CfgModeWord.toUpperCase() == 'TELMEXACCESSNV') ||
                        (CfgModeWord.toUpperCase() == 'TELMEXRESALE')) ? true : false;
            }
        }

        function IsTedata() {
            return (('TEDATA' == CfgModeWord.toUpperCase()) || ('TEDATA2' == CfgModeWord.toUpperCase())) ? true : false;
        }

        function list(domain, SrcIPPrefix) {
            this.domain = domain;
            this.SrcIPPrefix = SrcIPPrefix;
        }
        function WanAccessItemClass(domain, Enable, Protocol, WanName, SrcIPPrefix) {
            this.domain = domain;
            this.Enable = Enable;
            this.Protocol = Protocol;
            this.WanName = WanName;
            this.SrcIPPrefix = SrcIPPrefix;
        }
        var WanAccessListTemp = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.AclServices.WanAccess.{i}, Enable|Protocol|WanName|SrcIPPrefix, WanAccessItemClass);%>;

        function stPortManagement(domain, ListenMode, ListenInnerPort, ListenOuterPort, HttpsListenInnerPort, HttpsListenOuterPort) {
            this.domain = domain;
            this.ListenMode = ListenMode;
            this.ListenInnerPort = ListenInnerPort;
            this.ListenOuterPort = ListenOuterPort;
            this.HttpsListenInnerPort = HttpsListenInnerPort;
            this.HttpsListenOuterPort = HttpsListenOuterPort;
        }

        var PortManagements = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_WebServerConfig, ListenMode|ListenInnerPort|ListenOuterPort|HttpsListenInnerPort|HttpsListenOuterPort, stPortManagement);%>;
        var PortManagement = PortManagements[0];

        function ApplyConfig1() {
            if (ConfirmEx(acl_language["s1010"]) == false) {
                return false;
            }

            var Form = new webSubmitForm();
            var PortChangeForLan = getValue('PortChangeForLan');
            var PortChangeForWan = getValue('PortChangeForWan');

            if (((PortChangeForLan != "") && (PortChangeForLan != "80") && (parseInt(PortChangeForLan, 10) <= 1024)) ||
                ((PortChangeForWan != "") && (PortChangeForWan != "80") && (parseInt(PortChangeForWan, 10) <= 1024))) {
                AlertEx(acl_language['s1001']);
                return false;
            }

            var r = new RegExp("^[1-9]{1}\\d*$");
            if (PortChangeForLan != "") {
                console.log(r.test(PortChangeForLan));
                if (r.test(PortChangeForLan)) {
                    Form.addParameter('x.ListenInnerPort', PortChangeForLan);
                } else {
                    AlertEx(acl_language['s1001']);
                }
            }

            if (PortChangeForWan != "") {
                console.log(r.test(PortChangeForWan));
                if (r.test(PortChangeForWan)) {
                    Form.addParameter('x.ListenOuterPort', PortChangeForWan);
                } else {
                    AlertEx(acl_language['s1001']);
                }
            }

            Form.setAction('set.cgi?'
                + 'x=' + 'InternetGatewayDevice.Services.X_HW_WebServerConfig'
                + '&RequestFile=html/ssmp/portmanagement/portmanagement.asp');
            Form.addParameter('x.X_HW_Token', getValue('onttoken'));

            setDisable('ButtonApply1', 1);
            setDisable('ButtonCancel1', 1);

            Form.submit();
        }

        function InitValue1() {
            setText('PortChangeForLan', "");
            setText('PortChangeForWan', "");
        }

        function CancelConfig1() {
            InitValue1();
        }

        function GetInitIcmpWan() {
            for (var i = 0; i < WanAccessListTemp.length - 1; i++) {
                if (WanAccessListTemp[i].SrcIPPrefix == "") {
                    return WanAccessListTemp[i];
                }
            }
        }
        DefaultRule = GetInitIcmpWan();

        var WANSrcWhiteList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_WANSrcWhiteList, InternetGatewayDevice.X_HW_Security.WANSrcWhiteList, WANSrcWhiteListEnable|WANSrcWhiteListNumberOfEntries, wanwhitelist);%>;
        var WhiteList = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaWhiteList, InternetGatewayDevice.X_HW_Security.WANSrcWhiteList.List.{i}, SrcIPPrefix, list);%>;
        function stAclInfo(domain, HttpLanEnable, HttpWanEnable, FtpLanEnable, FtpWanEnable, TelnetLanEnable, TelnetWanEnable, HTTPWifiEnable, TELNETWifiEnable, SSHLanEnable, SSHWanEnable, HTTPSWanEnable) {
            this.domain = domain;
            this.HttpWifiEnable = HTTPWifiEnable;
            this.TelnetWifiEnable = TELNETWifiEnable;
            this.HttpLanEnable = HttpLanEnable;
            this.HttpWanEnable = HttpWanEnable;
            this.FtpLanEnable = FtpLanEnable;
            this.FtpWanEnable = FtpWanEnable;
            this.TelnetLanEnable = TelnetLanEnable;
            this.TelnetWanEnable = TelnetWanEnable;
            this.SSHLanEnable = SSHLanEnable;
            this.SSHWanEnable = SSHWanEnable;
            this.HTTPSWanEnable = HTTPSWanEnable;
        }

        function sthttpPortinfo(domain, ListenMode, ListenInnerPort, ListenOuterPort, HttpsListenInnerPort, HttpsListenOuterPort) {
            this.domain = domain;
            this.ListenMode = ListenMode;
            this.ListenInnerPort = ListenInnerPort;
            this.ListenOuterPort = ListenOuterPort;
            this.HttpsListenInnerPort = HttpsListenInnerPort;
            this.HttpsListenOuterPort = HttpsListenOuterPort;
        }

        var aclinfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecAclInfos, InternetGatewayDevice.X_HW_Security.AclServices, HTTPLanEnable|HTTPWanEnable|FTPLanEnable|FTPWanEnable|TELNETLanEnable|TELNETWanEnable|HTTPWifiEnable|TELNETWifiEnable|SSHLanEnable|SSHWanEnable|HTTPSWanEnable, stAclInfo);%>;
        var AclInfo = aclinfos[0];

        var httpPortinfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_WebServerConfig, ListenMode|ListenInnerPort|ListenOuterPort|HttpsListenInnerPort|HttpsListenOuterPort, sthttpPortinfo);%>;

        function SetCtrlConfigPanel(iDisable) {
            setDisable('httpwifi', iDisable);
            setDisable('telnetwifi', iDisable);
            setDisable('ftplan', iDisable);
            setDisable('httplan', iDisable);
            setDisable('telnetlan', iDisable);
            setDisable('ftpwan', iDisable);
            setDisable('httpwan', iDisable);
            setDisable('telnetwan', iDisable);
            setDisable('bttnApply', iDisable);
            setDisable('cancelValue', iDisable);
            setDisable('sshlan', iDisable);
            setDisable('sshwan', iDisable);
            setDisable('httpswan', iDisable);
            setDisable('HttpsPort', iDisable);
            setDisable('HttpPort', iDisable);
        }

        function OnDisplayhttp(Obj) {
            if (HTTPPortFlag == 1) {
                if (Obj.id == "httpwan") {
                    var httpCheckVal = getCheckVal("httpwan");
                    setDisplay("httpporttitle", httpCheckVal);
                    setDisplay("HttpPort", httpCheckVal);
                } else {
                    var httpCheckVal = getCheckVal("httpswan");
                    setDisplay("httpsporttitle", httpCheckVal);
                    setDisplay("HttpsPort", httpCheckVal);
                }
            }

        }
        function DisplayWanServiceHttps() {
            setDisplay("httpswanRow", HTTPPortFlag);
        }

        function AddHtml() {
            var HtmlHttpline = "<span id=\"httpporttitle\" style=\"padding:0 10px;display:none\" BindText=\"bbsp_table_httpport\"></span><input id = \"HttpPort\" style=\"width:50px;display:none\" type=\"text\"/>";
            var HtmlHttpsline = "<span id=\"httpsporttitle\" style=\"padding:0 10px;display:none\" BindText=\"bbsp_table_httpport\"></span><input id = \"HttpsPort\" style=\"width:50px;display:none\" type=\"text\"/>";
            if (HTTPPortFlag == 1) {
                $("#httpwanCol").append(HtmlHttpline);
                $("#httpswanCol").append(HtmlHttpsline);
            }
        }

        function InitHttpPort() {
            if (HTTPPortFlag == 1) {
                setCheck('httpswan', AclInfo.HTTPSWanEnable);

                setText("HttpPort", httpPortinfo[0].ListenOuterPort);

                setText("HttpsPort", httpPortinfo[0].HttpsListenOuterPort);

                var displayhttp = AclInfo.HttpWanEnable;
                var displayhttps = AclInfo.HTTPSWanEnable;

                setDisplay("httpporttitle", displayhttp);
                setDisplay("HttpPort", displayhttp);
                setDisplay("httpsporttitle", displayhttps);
                setDisplay("HttpsPort", displayhttps);
            }
        }

        function LoadFrame() {
            if (WhiteList.length > 1) {
                selectLine(TableName + '_record_0');
            }

            if (PortAclFlag == 1) {
                setDisplay("appendacltitle", 1);
            }

            if (HideInfoFlag == 1) {
                setDisplay("appendacltitle", 0);
            }

            if ((CfgModeWord.toUpperCase() == 'OI') || (CfgModeWord.toUpperCase() == 'OI2')) {
                setDisplay("appendacltitle", 0);
            }

            if (CfgModeWord.toUpperCase() == 'TRIPLET2WIFI6') {
                setDisplay("portChange", 1);
                if ((icmpEnable == 0) && (pingEnable == 0)) {
                    setCheck('icmpwan', '1');
                } else {
                    setCheck('icmpwan', '0');
                }
            }

            setCheck('ftplan', AclInfo.FtpLanEnable);
            setCheck('ftpwan', AclInfo.FtpWanEnable);
            setCheck('httpwifi', AclInfo.HttpWifiEnable);
            setCheck('httplan', AclInfo.HttpLanEnable);

            if ((TelmexFlag == 1) || (telmexflag == 1)) {
                setCheck('httpwan', AclInfo.HTTPSWanEnable);
            } else {
                setCheck('httpwan', AclInfo.HttpWanEnable);
            }
            setCheck('telnetlan', AclInfo.TelnetLanEnable);
            setCheck('telnetwan', AclInfo.TelnetWanEnable);
            setCheck('telnetwifi', AclInfo.TelnetWifiEnable);
            setCheck('sshlan', AclInfo.SSHLanEnable);
            setCheck('sshwan', AclInfo.SSHWanEnable);
            setCheck('wanwhite', WANSrcWhiteList[0].WANSrcWhiteListEnable);

            if (ProductType == '3') {
                setDisplay('ftplanRow', 0);
                setDisplay('ftpwanRow', 0);
            }

            if (ProductType == '2') {
                if (AclInfo.TelnetLanEnable == 0) {
                    setDisable('telnetwifi', 1);
                }
                if (parseInt(AclInfo.HttpLanEnable, 10) == 0) {
                    setDisable('httpwifi', 1);
                }

                if ((FltsecLevel != 'CUSTOM') && ('CMCC_RMS' != CfgModeWord.toUpperCase())) {
                    SetCtrlConfigPanel(1);
                }
                if (FtpFlag == 0) {
                    setDisplay('ftplanRow', 0);
                    setDisplay('ftpwanRow', 0);
                }
            } else {
                if ((AclInfo.TelnetLanEnable == 0) && (PortAclFlag == 0)) {
                    setDisable('telnetwifi', 1);
                }
                if (parseInt(AclInfo.HttpLanEnable, 10) == 0 && PortAclFlag == 0) {
                    setDisable('httpwifi', 1);
                }

                if (FltsecLevel != 'CUSTOM') {
                    SetCtrlConfigPanel(1);
                }
            }

            if (IsTelmexOpenAccess()) {
                SetCtrlConfigPanel(1);
                setDisable('wanwhite', 1);
                if (('TR181' == TypeWord) && (FltsecLevel == 'CUSTOM')) {
                    setDisable('ftplan', 0);
                    setDisable('httplan', 0);
                    setDisable('telnetlan', 0);
                    setDisable('bttnApply', 0);
                    setDisable('cancelValue', 0);
                }
            }

            if (IsAdminUser() == false) {
                setDisplay('lan_table', 0);
                setDisplay('telnetwifiRow', 0);
                setDisplay('wan_table', 0);
                setDisplay('ListConfigPanel', 0);
                setDisplay('ConfigPanel', 0);
                setDisplay('wifi_space', 0);
                setDisplay('wan_space', 0);
            } else {
                setDisplay('lan_table', 1);
                setDisplay('telnetwifiRow', 1);
                if ((securityAccessFlag != '1') && (isWanAccess == '1')) {
                    setDisplay('wan_table', 1);
                    setDisplay('ListConfigPanel', 1);
                }
            }

            if (wantelflag == '0') {
                setDisable('telnetwan', 1);
                setCheck('telnetwan', 0);
            }


            if ((SingleFreqFlag != 1) && (DoubleFreqFlag != 1)) {
                setDisplay('wifi_space', 0);
                setDisplay('wifi_table', 0);
            } else {
                setDisplay('wifi_table', 1);
            }

            if (SingleFlag == 1) {
                setDisplay('telnetlanRow', 0);
                setDisplay('sshlanRow', 0);
                setDisplay('telnetwanRow', 0);
                setDisplay('sshwanRow', 0);
            }

            if (IsViettel8045A2Flag == 1) {
                setDisplay('telnetlanRow', 0);
                setDisplay('sshlanRow', 0);
                setDisplay('telnetwanRow', 0);
                setDisplay('sshwanRow', 0);
                setDisplay('telnetwifiRow', 0);
            }

            if ((ProductType != '2') && (CfgModeWord.toUpperCase() == "CAT")) {
                setDisable('telnetwan', 1);
                setDisable('sshwan', 1);
            }

            if (LanHttpDisableFlag == 1) {
                setDisable('httplan', 1);
            }

            if (IsGlobeFlag == 1) {
                setDisable('ftpwan', 1);
                setDisable('httpwan', 1);
                setDisable('telnetwan', 1);
                setDisable('sshwan', 1);
                setDisable('ftplan', 1);
                setDisable('telnetlan', 1);
                setDisable('sshlan', 1);
                setDisable('telnetwifi', 1);
                setDisable('ftplan', 1);
            }

            if (IsGlobeOntFlag() == 1) {
                setDisplay('ftplanRow', 0);
                setDisplay('telnetlanRow', 0);
                setDisplay('sshlanRow', 0);
                setDisplay('telnetwifiRow', 0);
                setDisplay('wan_table', 0);
                setDisplay('ListConfigPanel', 0);
                setDisplay('ConfigPanel', 0);
            }

            if (ProductType != '2') {
                if (IsTedata()) {
                    setDisplay('telnetwifiRow', 0);
                    setDisplay('telnetlanRow', 0);
                    setDisplay('telnetwanRow', 0);
                }
            }
            DisplayWanServiceHttps();
            InitHttpPort();

            setDisplay('DivMain', 1);
            if (certificateFlag == 1) {
                setDisplay('telnetlanRow', 0);
                setDisplay('sshlanRow', 0);
                setDisplay('telnetwanRow', 0);
                setDisplay('sshwanRow', 0);
                setDisplay('telnetwifiRow', 0);
            }
            if (CfgModeWord.toUpperCase() == 'TRIPLET2WIFI6') {
                setText('PortChangeForLan', PortManagement.ListenInnerPort);
                setText('PortChangeForWan', PortManagement.ListenOuterPort);
            }
        }

        function SubmitIcmpWanEnable() {
            var SubmitData = "";
            if (getElement("icmpwan").checked == false) {
                SubmitData += "x.IcmpEchoReplyEn=1";
                SubmitData += "&x.PingSweepEn=1";
            } else {
                SubmitData += "x.IcmpEchoReplyEn=0";
                SubmitData += "&x.PingSweepEn=0";
            }

            $.ajax({
                type: "POST",
                async: false,
                cache: false,
                data: SubmitData + "&x.X_HW_Token=" + getValue('onttoken'),
                url: 'set.cgi?x=InternetGatewayDevice.X_HW_Security.Dosfilter&RequestFile=html/bbsp/acl/aclunicom.asp',
                success: function () { }
            });
        }

        function FormCheck() {
            var WifiServiceFlag = 0;
            var LanServiceFlag = 0;
            var WanServiceFlag = 0;

            if (((AclInfo.HttpWifiEnable != getCheckVal('httpwifi')) && (0 == getCheckVal('httpwifi'))) ||
                ((AclInfo.TelnetWifiEnable != getCheckVal('telnetwifi')) && (0 == getCheckVal('telnetwifi')))) {
                WifiServiceFlag++;
            }

            if (((AclInfo.HttpLanEnable != getCheckVal('httplan')) && (0 == getCheckVal('httplan'))) ||
                ((AclInfo.FtpLanEnable != getCheckVal('ftplan')) && (0 == getCheckVal('ftplan'))) ||
                ((AclInfo.TelnetLanEnable != getCheckVal('telnetlan')) && (0 == getCheckVal('telnetlan'))) ||
                ((AclInfo.SSHLanEnable != getCheckVal('sshlan')) && (0 == getCheckVal('sshlan')))) {
                LanServiceFlag++;
            }

            if (HTTPPortFlag != 1) {
                if ((TelmexFlag == 1) || (telmexflag == 1)) {
                    if (((AclInfo.FtpWanEnable != getCheckVal('ftpwan')) && (0 == getCheckVal('ftpwan'))) ||
                        ((AclInfo.TelnetWanEnable != getCheckVal('telnetwan')) && (0 == getCheckVal('telnetwan'))) ||
                        ((AclInfo.SSHWanEnable != getCheckVal('sshwan')) && (0 == getCheckVal('sshwan'))) ||
                        ((AclInfo.HTTPSWanEnable != getCheckVal('httpwan')) && (0 == getCheckVal('httpwan')))) {
                        WanServiceFlag++;
                    }
                } else if (((AclInfo.HttpWanEnable != getCheckVal('httpwan')) && (0 == getCheckVal('httpwan'))) ||
                           ((AclInfo.FtpWanEnable != getCheckVal('ftpwan')) && (0 == getCheckVal('ftpwan'))) ||
                           ((AclInfo.TelnetWanEnable != getCheckVal('telnetwan')) && (0 == getCheckVal('telnetwan'))) ||
                           ((AclInfo.SSHWanEnable != getCheckVal('sshwan')) && (0 == getCheckVal('sshwan'))) ||
                           ((AclInfo.HTTPSWanEnable != getCheckVal('httpswan')) && (0 == getCheckVal('httpswan')))) {
                    WanServiceFlag++;
                }
            }

            var ServiceFlag = WifiServiceFlag + LanServiceFlag + WanServiceFlag;

            if (ServiceFlag > 1) {
                if (false == ConfirmEx(acl_language['bbsp_service_prompt'])) {
                    setCheck('httpwifi', AclInfo.HttpWifiEnable);
                    setCheck('telnetwifi', AclInfo.TelnetWifiEnable);
                    setCheck('httplan', AclInfo.HttpLanEnable);
                    setCheck('ftplan', AclInfo.FtpLanEnable);
                    setCheck('telnetlan', AclInfo.TelnetLanEnable);
                    setCheck('sshlan', AclInfo.SSHLanEnable);
                    setCheck('ftpwan', AclInfo.FtpWanEnable);
                    setCheck('telnetwan', AclInfo.TelnetWanEnable);
                    setCheck('sshwan', AclInfo.SSHWanEnable);
                    if ((TelmexFlag == 1) || (telmexflag == 1)) {
                        setCheck('httpwan', AclInfo.HTTPSWanEnable);
                    } else {
                        setCheck('httpwan', AclInfo.HttpWanEnable);
                        setCheck('httpswan', AclInfo.HTTPSWanEnable);
                    }
                    return false;
                }
            } else if (WifiServiceFlag == 1) {
                if (false == ConfirmEx(acl_language['bbsp_confirm_wifi'])) {
                    setCheck('httpwifi', AclInfo.HttpWifiEnable);
                    setCheck('telnetwifi', AclInfo.TelnetWifiEnable);
                    return false;
                }
            } else if (LanServiceFlag == 1) {
                if (false == ConfirmEx(acl_language['bbsp_confirm_lan'])) {
                    setCheck('httplan', AclInfo.HttpLanEnable);
                    setCheck('ftplan', AclInfo.FtpLanEnable);
                    setCheck('telnetlan', AclInfo.TelnetLanEnable);
                    setCheck('sshlan', AclInfo.SSHLanEnable);
                    return false;
                }
            } else if (WanServiceFlag == 1) {
                if ((TelmexFlag == 1) || (telmexflag == 1)) {
                    if (false == ConfirmEx(acl_language['bbsp_confirm_wan'])) {
                        setCheck('httpwan', AclInfo.HTTPSWanEnable);
                        setCheck('ftpwan', AclInfo.FtpWanEnable);
                        setCheck('telnetwan', AclInfo.TelnetWanEnable);
                        setCheck('sshwan', AclInfo.SSHWanEnable);
                        return false;
                    }
                } else if (ConfirmEx(acl_language['bbsp_confirm_wan']) == false) {
                    setCheck('httpwan', AclInfo.HttpWanEnable);
                    setCheck('ftpwan', AclInfo.FtpWanEnable);
                    setCheck('telnetwan', AclInfo.TelnetWanEnable);
                    setCheck('sshwan', AclInfo.SSHWanEnable);
                    setCheck('httpswan', AclInfo.HTTPSWanEnable);
                    return false;
                }
            }

            if ((PortAclFlag == '1') && (curUserType == '0')) {
                if ((false == getCheckVal('httplan')) && (false == getCheckVal('httpwifi'))) {
                    if (false == ConfirmEx(acl_language['bbsp_alter_http'])) {
                        if (AclInfo.HttpLanEnable == '1') {
                            setCheck('httplan', 1);
                        }

                        if (AclInfo.HttpWifiEnable == 1) {
                            setCheck('httpwifi', 1);
                        }
                        return false;
                    }
                }
            }

            return true;
        }

        function CheckPortSublime() {
            if (HTTPPortFlag == 1) {
                if ((getCheckVal('httpwan') == 1) && (getValue('HttpPort') != httpPortinfo[0].ListenOuterPort)) {
                    return true;
                }

                if ((getCheckVal('httpswan') == 1) && (getValue('HttpsPort') != httpPortinfo[0].HttpsListenOuterPort)) {
                    return true;
                }
            }

            return false;
        }

        function CheckEnableHTTPS() {
            if (HTTPPortFlag == 1) {
                var httpCheckVal = getCheckVal("httpwan");
                var httpsCheckVal = getCheckVal("httpswan");

                if ((httpCheckVal == 1) && (httpsCheckVal == 0)) {
                    return true;
                }
            }

            return false;
        }

        function IsGlobeOntFlag() {
            if ((IsGlobe1OntFlag == 1) || (IsGlobe2OntFlag == 1)) {
                return true;
            } else {
                return false;
            }
        }

        function SubmitForm() {
            if (CfgModeWord.toUpperCase() == 'TRIPLET2WIFI6') {
                SubmitIcmpWanEnable();
            }

            if (ProductType == '2') {
                if (false == FormCheck()) {
                    return;
                }

                setDisable('btnApply', 1);
                setDisable('cancelValue', 1);

                var Form = new webSubmitForm();

                Form.usingPrefix('x');

                if (IsAdminUser() == true) {
                    Form.addParameter('FTPLanEnable', getCheckVal('ftplan'));
                    if (securityAccessFlag != '1') {
                        Form.addParameter('FTPWanEnable', getCheckVal('ftpwan'));
                    }

                    if (LanHttpDisableFlag != 1) {
                        Form.addParameter('HTTPLanEnable', getCheckVal('httplan'));
                    }
                    
                    if (securityAccessFlag != '1') {
                        if (TelmexFlag == 1) {
                            Form.addParameter('HTTPSWanEnable', getCheckVal('httpwan'));
                        } else {
                            Form.addParameter('HTTPWanEnable', getCheckVal('httpwan'));
                        }
                    }
                    Form.addParameter('HTTPWifiEnable', getCheckVal('httpwifi'));
                    Form.addParameter('TELNETWifiEnable', getCheckVal('telnetwifi'));
                    if (SingleFlag != 1) {
                        Form.addParameter('TELNETLanEnable', getCheckVal('telnetlan'));
                        Form.addParameter('SSHLanEnable', getCheckVal('sshlan'));
                        if (securityAccessFlag != '1') {
                            Form.addParameter('TELNETWanEnable', getCheckVal('telnetwan'));
                            Form.addParameter('SSHWanEnable', getCheckVal('sshwan'));
                        }
                    }
                } else {
                    Form.addParameter('HTTPWifiEnable', getCheckVal('httpwifi'));
                }
                Form.endPrefix();
                Form.addParameter('x.X_HW_Token', getValue('onttoken'));
                Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security.AclServices&RequestFile=html/bbsp/acl/aclunicom.asp');
                Form.submit();
                setDisable('bttnApply', 1);
                setDisable('cancelValue', 1);
            } else {
                if (FormCheck() == false) {
                    return;
                }

                setDisable('btnApply', 1);
                setDisable('cancelValue', 1);

                if (CheckEnableHTTPS()) {
                    if (ConfirmEx(acl_language['bbsp_confirm_httpsdisable']) == false) {
                        setDisable('btnApply', 0);
                        setDisable('cancelValue', 0);
                        return false;
                    }
                }

                if (CheckPortSublime()) {
                    if (false == ConfirmEx(acl_language['bbsp_confirm_port'])) {
                        setDisable('btnApply', 0);
                        setDisable('cancelValue', 0);
                        return false;
                    }
                }

                var Form = new webSubmitForm();

                if (IsAdminUser() == true) {
                    Form.addParameter('x.FTPLanEnable', getCheckVal('ftplan'));
                    if (securityAccessFlag != '1') {
                        Form.addParameter('x.FTPWanEnable', getCheckVal('ftpwan'));
                    }
                    if (1 != LanHttpDisableFlag) {
                        Form.addParameter('x.HTTPLanEnable', getCheckVal('httplan'));
                    }
                    if ((HTTPPortFlag == 1) && (securityAccessFlag != '1')) {
                        if (getCheckVal('httpwan') == 1) {
                            if ((getValue('HttpPort') != "") && (getValue('HttpPort') != httpPortinfo[0].ListenOuterPort)) {
                                Form.addParameter('y.ListenOuterPort', getValue('HttpPort'));
                            }
                        }
                        if (getCheckVal('httpswan') == 1) {
                            if ((getValue('HttpsPort') != "") && (getValue('HttpsPort') != httpPortinfo[0].HttpsListenOuterPort)) {
                                Form.addParameter('y.HttpsListenOuterPort', getValue('HttpsPort'));
                            }
                        }
                        Form.addParameter('x.HTTPSWanEnable', getCheckVal('httpswan'));
                    }
                    
                    if (securityAccessFlag != '1') {
                        if (telmexflag) {
                            Form.addParameter('x.HTTPSWanEnable', getCheckVal('httpwan'));
                        } else {
                            Form.addParameter('x.HTTPWanEnable', getCheckVal('httpwan'));
                        }
                    }

                    Form.addParameter('x.HTTPWifiEnable', getCheckVal('httpwifi'));

                    if (IsViettel8045A2Flag != 1) {
                        if (!IsTedata()) {
                            Form.addParameter('x.TELNETWifiEnable', getCheckVal('telnetwifi'));
                        }
                    }

                    if ((SingleFlag != 1) && (IsViettel8045A2Flag != 1)) {
                        if (!IsTedata()) {
                            Form.addParameter('x.TELNETLanEnable', getCheckVal('telnetlan'));
                        }
                        Form.addParameter('x.SSHLanEnable', getCheckVal('sshlan'));
                        if ((CfgModeWord.toUpperCase() != "CAT") && (securityAccessFlag != '1')) {
                            if (!IsTedata()) {
                                Form.addParameter('x.TELNETWanEnable', getCheckVal('telnetwan'));
                            }
                            Form.addParameter('x.SSHWanEnable', getCheckVal('sshwan'));
                        }
                    }
                } else {
                    Form.addParameter('x.HTTPWifiEnable', getCheckVal('httpwifi'));
                }
                Form.addParameter('x.X_HW_Token', getValue('onttoken'));
                if (HTTPPortFlag == 1) {
                    Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security.AclServices&y=InternetGatewayDevice.Services.X_HW_WebServerConfig&RequestFile=html/bbsp/acl/aclunicom.asp');
                } else {
                    Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security.AclServices&RequestFile=html/bbsp/acl/aclunicom.asp');
                }
                Form.submit();
                setDisable('bttnApply', 1);
                setDisable('cancelValue', 1);
            }
        }

        function ChangeLevel(level) {

        }

        function CancelConfig() {
            LoadFrame();
        }

        function CheckParameter() {
            var SrcIPPrefix = getElement('SrcIPPrefix').value;
            if (SrcIPPrefix == '') {
                AlertEx(acl_language['bbsp_alert_srcip1']);
                return false;
            }

            if (SrcIPPrefix.length > 64) {
                AlertEx(acl_language['bbsp_alert_srcip2']);
                return false;
            }

            var addrParts = SrcIPPrefix.split('/');
            if (addrParts.length != 2) {
                AlertEx(acl_language['bbsp_alert_addaddr']);
                return false;
            }

            if ((addrParts[1].length > 2) || ((addrParts[1] == '8 ') && (addrParts[1].length == 2))) {
                AlertEx(acl_language['bbsp_alert_addaddr']);
                return false;
            }


            if ((isValidIpAddress(addrParts[0]) == false) && (IsIPv6AddressValid(addrParts[0]) == false)) {
                AlertEx(acl_language['bbsp_alert_invalidipaddr']);
                return false;
            }

            if (isNaN(addrParts[1].replace(' ', 'a')) == true) {
                AlertEx(acl_language['bbsp_maskinvalid1']);
                return false;
            }


            var IsIPv4 = isValidIpAddress(addrParts[0]);
            var num = parseInt(addrParts[1], 10);
            if ((num == 0) || ((IsIPv4 == true) && (num > 32))) {
                AlertEx(acl_language['bbsp_maskinvalid3']);
                return false;
            }

            if (ProductType == '2') {
                if ((IsIPv4 == true) && (iSIPmatchMask(addrParts[0], num) == false)) {
                    AlertEx(acl_language['bbsp_maskinvalid4']);
                    return false;
                }

                if (IsIPv4 == true) {
                    var addrs = SrcIPPrefix.split('.');
                    var addr = parseInt(addrs[0], 10);
                    if (addr >= 224 && addr <= 239) {
                        AlertEx(acl_language['bbsp_alert_invalidipaddr']);
                        return false;
                    }
                }
            } else {
                if (IsIPv4 == true) {
                    if (isAbcIpAddress(addrParts[0]) == false) {
                        AlertEx(acl_language['bbsp_alert_invalidipaddr']);
                        return false;
                    }

                    if (iSIPmatchMask(addrParts[0], num) == false) {
                        AlertEx(acl_language['bbsp_maskinvalid4']);
                        return false;
                    }
                }
            }

            for (i = 0; i < WhiteList.length - 1; i++) {
                if ((selctIndex != i) && (WhiteList[i].SrcIPPrefix == SrcIPPrefix)) {
                    AlertEx(acl_language['bbsp_iprepeat']);
                    return false;
                }
            }

            return true;
        }
        function checkzeronum(num) {
            var temp = 0;
            var ZeroNum = 0;

            for (var i = 0; i <= 7; i++) {
                temp = num >> i;
                if ((temp & 1) == 0) {
                    ZeroNum++;
                } else {
                    return ZeroNum;
                }
            }
            return ZeroNum;
        }

        function iSIPmatchMask(ip, mask) {
            var addripv4 = ip.split('.')
            var ZeroTotal = 0;

            for (var k = 3; k >= 0; k--) {
                ZeroTotal += checkzeronum(addripv4[k]);
                if (8 != checkzeronum(addripv4[k])) {
                    if ((mask < (32 - ZeroTotal)) || (mask > 32)) {
                        return false;
                    }
                    return true;
                }
            }
        }

        function DeleteLineRow() {
            var tableRow = getElementById(TableName);
            if (tableRow.rows.length > 2)
                tableRow.deleteRow(tableRow.rows.length - 1);
            return false;
        }

        function setControl(Index) {
            selctIndex = Index;
            if (Index < -1) {
                return;
            }
            if (Index == -1) {
                if (WhiteList.length >= 17) {
                    DeleteLineRow();
                    AlertEx(acl_language['bbsp_ipaddrfull']);
                    setDisplay('ConfigPanel', 0);
                    setControl(0);
                    return;
                } else {
                    SetAddMode();
                    setText('SrcIPPrefix', '');
                    setDisplay("ConfigPanel", "1");
                }
            } else {
                SetEditMode();
                setDisplay("ConfigPanel", "1");
                setText('SrcIPPrefix', WhiteList[Index].SrcIPPrefix);
            }
        }

        function SIPWhiteListConfigListselectRemoveCnt(val) {

        }
        function OnDeleteButtonClick(TableID) {
            var Form = new webSubmitForm();
            var SelectCount = 0;
            var CheckBoxList = document.getElementsByName(TableName + 'rml');

            for (var i = 0; i < CheckBoxList.length; i++) {
                if (CheckBoxList[i].checked != true) {
                    continue;
                }
                SelectCount++;
                Form.addParameter(CheckBoxList[i].value, '');
            }

            if (SelectCount == 0) {
                AlertEx(acl_language['bbsp_alert_selwhite']);
                return false;
            }

            Form.addParameter('x.X_HW_Token', getValue('onttoken'));
            Form.setAction('del.cgi?' + 'x=InternetGatewayDevice.X_HW_Security.WANSrcWhiteList.List' + '&RequestFile=html/bbsp/acl/aclunicom.asp');
            Form.submit();
        }

        function OnApplyButtonClick() {
            if (CheckParameter() == false) {
                return false;
            }

            var Form = new webSubmitForm();

            Form.addParameter('x.SrcIPPrefix', getValue('SrcIPPrefix'));
            Form.addParameter('x.X_HW_Token', getValue('onttoken'));

            if (IsAddMode() == true) {
                Form.setAction('add.cgi?' + 'x=InternetGatewayDevice.X_HW_Security.WANSrcWhiteList.List' + '&RequestFile=html/bbsp/acl/aclunicom.asp');
            } else {
                Form.setAction('set.cgi?x=' + WhiteList[selctIndex].domain + '&RequestFile=html/bbsp/acl/aclunicom.asp');
            }
            Form.submit();
            DisableRepeatSubmit();
        }

        function OnCancelButtonClick() {
            setDisplay("ConfigPanel", 0);
            var tableRow = getElement(TableName);

            if ((tableRow.rows.length > 2) && (IsAddMode() == true)) {
                tableRow.deleteRow(tableRow.rows.length - 1);
            }
        }


        function EnableForm() {
            var Form = new webSubmitForm();
            var Enable = getElById("wanwhite").checked;
            if (Enable == true) {
                Form.addParameter('x.WANSrcWhiteListEnable', 1);
            } else {
                Form.addParameter('x.WANSrcWhiteListEnable', 0);
            }

            Form.addParameter('x.X_HW_Token', getValue('onttoken'));
            Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_Security.WANSrcWhiteList'
                + '&RequestFile=html/bbsp/acl/aclunicom.asp');
            Form.submit();
        }
        if ((TelmexFlag == 1) || (telmexflag == 1)) {
            acl_language['bbsp_table_wanhttp'] = acl_language['bbsp_table_wanhttps'];
        }
        
        function TelnetLanEnable()
        {
            var enabletelnet = getCheckVal('telnetlan');
            if (enabletelnet && (ConfirmEx(acl_language['bbsp_confirm_telnet']) == false)) {
                setCheck('telnetlan', 0);
                return;
            }
        }
        function TelnetWifiEnable()
        {
            var enabletelnetwifi = getCheckVal('telnetwifi');
            if (enabletelnetwifi && (ConfirmEx(acl_language['bbsp_confirm_telnet']) == false)) {
                setCheck('telnetwifi', 0);
                return;
            }
        }

        function TelnetWanEnable()
        {
            var enabletelnet = getCheckVal('telnetwan');
            if (enabletelnet && (ConfirmEx(acl_language['bbsp_confirm_telnet']) == false)) {
                setCheck('telnetwan', 0);
                return;
            }
        }
    </script>
</head>

<body onLoad="LoadFrame();" class="mainbody" id="DivMain" style="display:none;">
    <script language="JavaScript" type="text/javascript">
        if (true == IsNeedAddSafeDesForBelTelecom()) {
            HWCreatePageHeadInfo("acltitle", GetDescFormArrayById(acl_language, "bbsp_mune"), GetDescFormArrayById(acl_language, "bbsp_title_prompt") + "<p style=\"color:red;\">Пользователь несет полную ответственность за изменение им настроек модема, которые могут повлечь несанкционированный доступ к модему сетевых злоумышленников и причинить пользователю финансовый ущерб.</p>", false);
        } else if (CfgModeWord.toUpperCase() == 'TRIPLET2WIFI6') {
            HWCreatePageHeadInfo("acltitle", GetDescFormArrayById(acl_language, "bbsp_mune"), GetDescFormArrayById(acl_language, "bbsp_title_prompt2"), false);
        } else {
            HWCreatePageHeadInfo("acltitle", GetDescFormArrayById(acl_language, "bbsp_mune"), GetDescFormArrayById(acl_language, "bbsp_title_prompt"), false);
        }
    </script>
    <div class="title_spread"></div>

    <form id="lan_table" style="display:none;">
        <div id="LanServiceTitle" class="func_title" BindText="bbsp_table_lan"></div>
        <table border="0" cellpadding="0" cellspacing="1" width="100%" class="tabal_noborder_bg">
            <li id="ftplan" RealType="CheckBox" DescRef="bbsp_table_lanftp" RemarkRef="Empty" ErrorMsgRef="Empty"
                Require="FALSE" BindField="x.FTPLanEnable" InitValue="" />
            <li id="httplan" RealType="CheckBox" DescRef="bbsp_table_lanhttp" RemarkRef="Empty" ErrorMsgRef="Empty"
                Require="FALSE" BindField="x.HTTPLanEnable" InitValue="" />
            <li id="telnetlan" RealType="CheckBox" DescRef="bbsp_table_lantel" RemarkRef="Empty" ErrorMsgRef="Empty"
                Require="FALSE" BindField="x.TELNETLanEnable" InitValue="" ClickFuncApp="onclick=TelnetLanEnable"/>
            <li id="sshlan" RealType="CheckBox" DescRef="bbsp_table_lanssh" RemarkRef="Empty" ErrorMsgRef="Empty"
                Require="FALSE" BindField="x.SSHLanEnable" InitValue="" />
        </table>
        <script>
            var TableClass = new stTableClass("per_35_52", "per_65_48", "ltr");
            var LanServiceFormList = new Array();
            LanServiceFormList = HWGetLiIdListByForm("lan_table", null);
            HWParsePageControlByID("lan_table", TableClass, acl_language, null);
        </script>
        <div class="func_spread"></div>
    </form>

    <form id="wifi_table" style="display:none;">
        <div id="WlanServiceTitle" class="func_title" BindText="bbsp_table_wifi"></div>
        <table border="0" cellpadding="0" cellspacing="1" width="100%" class="tabal_noborder_bg">
            <li id="httpwifi" RealType="CheckBox" DescRef="" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE"
                BindField="x.HTTPWifiEnable" InitValue="" />
            <li id="telnetwifi" RealType="CheckBox" DescRef="bbsp_table_wifitelnet" RemarkRef="Empty"
                ErrorMsgRef="Empty" Require="FALSE" BindField="x.TELNETWifiEnable" InitValue="" ClickFuncApp="onclick=TelnetWifiEnable"/>
        </table>
        <script>
            var WlanServiceFormList = new Array();
            WlanServiceFormList = HWGetLiIdListByForm("wifi_table", null);
            HWParsePageControlByID("wifi_table", TableClass, acl_language, null);
            document.getElementById("httpwifiColleft").innerHTML = acl_language['bbsp_table_wifihttp'];
        </script>
    </form>

    <form id="wan_table" style="display:none;">
        <div class="func_spread"></div>
        <div id="WanServiceTitle" class="func_title" BindText="bbsp_table_wan"></div>
        <table border="0" cellpadding="0" cellspacing="1" width="100%" class="tabal_noborder_bg">
            <li id="ftpwan" RealType="CheckBox" DescRef="bbsp_table_wanftp" RemarkRef="Empty" ErrorMsgRef="Empty"
                Require="FALSE" BindField="x.FTPWanEnable" InitValue="" />
            <li id="httpwan" RealType="CheckBox" DescRef="bbsp_table_wanhttp" RemarkRef="Empty" ErrorMsgRef="Empty"
                Require="FALSE" BindField="x.HTTPLanEnable" InitValue="" ClickFuncApp="onclick=OnDisplayhttp" />
            <li id="httpswan" RealType="CheckBox" DescRef="bbsp_table_wanhttps" RemarkRef="Empty" ErrorMsgRef="Empty"
                Require="FALSE" BindField="x.HTTPLanEnable" InitValue="" ClickFuncApp="onclick=OnDisplayhttp" />
            <li id="telnetwan" RealType="CheckBox" DescRef="bbsp_table_wantel" RemarkRef="Empty" ErrorMsgRef="Empty"
                Require="FALSE" BindField="x.TELNETWanEnable" InitValue="" ClickFuncApp="onclick=TelnetWanEnable"/>
            <li id="sshwan" RealType="CheckBox" DescRef="bbsp_table_wanssh" RemarkRef="Empty" ErrorMsgRef="Empty"
                Require="FALSE" BindField="x.SSHWanEnable" InitValue="" />
            <script>
                if (CfgModeWord.toUpperCase() == 'TRIPLET2WIFI6') {
                    document.write("\<li id=\"icmpwan\"  RealType=\"CheckBox\"   DescRef=\"bbsp_table_wanicmp\"  RemarkRef=\"Empty\"  ErrorMsgRef=\"Empty\"    Require=\"FALSE\"    BindField=\"Empty\"  InitValue=\"Empty\" \/\> ");
                }
            </script>
        </table>
        <script>
            var WanServiceFormList = new Array();
            WanServiceFormList = HWGetLiIdListByForm("wan_table", null);
            HWParsePageControlByID("wan_table", TableClass, acl_language, null);
            AddHtml();

        </script>
    </form>
    <table class="table_button" width="100%">
        <tr>
            <td class='width_per35'></td>
            <td class="table_submit width_per65"> <button id="bttnApply" name="bttnApply" type="button"
                    class="ApplyButtoncss buttonwidth_100px" onClick="SubmitForm();" id="Button1">
                    <script>document.write(acl_language['bbsp_app']);</script></button>
                <button name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px"
                    onClick="CancelConfig();">
                    <script>document.write(acl_language['bbsp_cancel']);</script></button></td>
        </tr>
    </table>
    <div class="func_spread"></div>

    <div id="ListConfigPanel" style="display:none;">
        <form id="WanSideEnableForm" style="display:block;">
            <div id="WanSideEnableTitle" class="func_title" BindText="bbsp_title_wanwhite"></div>
            <table border="0" cellpadding="0" cellspacing="1" width="100%" class="tabal_noborder_bg">
                <li id="wanwhite" RealType="CheckBox" DescRef="bbsp_title_wanwhiteenable" RemarkRef="Empty"
                    ErrorMsgRef="Empty" Require="FALSE" BindField="y.WANSrcWhiteListEnable" InitValue=""
                    ClickFuncApp="onclick=EnableForm" />
            </table>
            <script>
                var WanSideEnableFormList = new Array();
                WanSideEnableFormList = HWGetLiIdListByForm("WanSideEnableForm", null);
                HWParsePageControlByID("WanSideEnableForm", TableClass, acl_language, null);
            </script>
            <div class="func_spread"></div>
        </form>

        <script language="JavaScript" type="text/javascript">
            var SIpWhiteListConfiglistInfo = new Array(new stTableTileInfo("Empty", "width_per20", "DomainBox"),
                new stTableTileInfo("bbsp_title_ipwhitelist", "width_per80", "SrcIPPrefix"), null);
            var ColumnNum = 2;
            var ShowButtonFlag = true;
            var TableDataInfo = HWcloneObject(WhiteList, 1);
            HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, SIpWhiteListConfiglistInfo, acl_language, null);
        </script>
    </div>
    <form id="ConfigPanel" style="display:none;">
        <div class="list_table_spread"></div>
        <table border="0" cellpadding="0" cellspacing="1" width="100%" class="tabal_noborder_bg">
            <li id="SrcIPPrefix" RealType="TextBox" DescRef="bbsp_table_srcaddrwlist" RemarkRef="Empty"
                ErrorMsgRef="Empty" Require="TRUE" BindField="x.VenderClassId" Elementclass="width_150px"
                InitValue="Empty" MaxLength="64" />
            <script>
                var TableClass = new stTableClass("width_per20", "width_per80", "ltr");
                var SrcIpPrefixConfigFormList = new Array();
                SrcIpPrefixConfigFormList = HWGetLiIdListByForm("ConfigPanel", null);
                var formid_hide_id = null;
                HWParsePageControlByID("ConfigPanel", TableClass, acl_language, formid_hide_id);
                document.getElementById("SrcIPPrefixRemark").innerHTML = "(A.B.C.D/E)";
            </script>
        </table>

        <table id="ConfigPanelButtons" width="100%" class="table_button">
            <tr>
                <td class='width_per20'> </td>
                <td class="table_submit pad_left5p">
                    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
                    <button id="ButtonApply" type="button" onclick="javascript:return OnApplyButtonClick();"
                        class="ApplyButtoncss buttonwidth_100px">
                        <script>document.write(acl_language['bbsp_app']);</script></button>
                    <button id="ButtonCancel" type="button" onclick="javascript:OnCancelButtonClick();"
                        class="CancleButtonCss buttonwidth_100px">
                        <script>document.write(acl_language['bbsp_cancel']);</script></button> </td>
            </tr>
            <tr>
                <td style="display:none"> <input type='text'> </td>
            </tr>
        </table>
    </form>

    <div id="portChange" style="display:none;">
        <div class="title_spread"></div>
        <div class="func_title">
            <script>document.write(acl_language["s1002"]);</script>
        </div>
        <form id="DscpForm" name="DscpForm">
            <table>
                <li id="PortChangeForLan" RealType="TextBox" DescRef="s1007" RemarkRef="s1009" ErrorMsgRef="Empty"
                    Require="FALSE" BindField="" InitValue="Empty" MaxLength="256"
                    Elementclass="width_180px restrict_dir_ltr" />
                <li id="PortChangeForWan" RealType="TextBox" DescRef="s1008" RemarkRef="s1009" ErrorMsgRef="Empty"
                    Require="FALSE" BindField="" InitValue="Empty" MaxLength="256"
                    Elementclass="width_180px restrict_dir_ltr" />
            </table>
            <script>
                var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
                HWParsePageControlByID("DscpForm", TableClass, acl_language, null);
            </script>
            <table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
                <tr>
                    <td class='width_per35'></td>
                    <td class="table_submit pad_left5p">
                        <button id="ButtonApply1" type="button" onclick="javascript:return ApplyConfig1();"
                            class="ApplyButtoncss buttonwidth_100px">
                            <script>document.write(acl_language['s1005']);</script></button>
                        <button id="ButtonCancel2" type="button" onclick="javascript:CancelConfig1();"
                            class="CancleButtonCss buttonwidth_100px">
                            <script>document.write(acl_language['s1006']);</script></button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <br>
    <br>
    <script>
        ParseBindTextByTagName(acl_language, "td", 1);
        ParseBindTextByTagName(acl_language, "div", 1);
        ParseBindTextByTagName(acl_language, "span", 1);
    </script>
</body>

</html>