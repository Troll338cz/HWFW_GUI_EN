<!DOCTYPE html
    PUBLIC"-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="Pragma" content="no-cache" />
        <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
        <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
        <script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
        <script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
        <link rel="stylesheet" href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>'type='text/css'>
        <link rel="stylesheet" href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>'type='text/css'>
        <script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
        <script language="JavaScript" type="text/javascript">
        
        var deviceType = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.UserInterface.CfgClone.DeviceType);%>';
        var ontToken = '<%HW_WEB_GetToken();%>';

        function LoadFrame() {
            initLayout();
        }

        function GetLanguageDesc(Name) {
            return ConfigMgmtDes[Name];
        }

        function initLayout() {
            this.currentType = "OldDevice";
            if (deviceType === "1") {
                this.currentType = "NewDevice";
            }
            setRadio("DeviceSelection", this.currentType);
        }

        function onDevRadioChecked(selectedType, descKey) {
            if (this.currentType === selectedType) {
                return;
            }
            if (descKey && !showPrompt(descKey)) {
                setRadio("DeviceSelection", this.currentType);
                return;
            }
            setDeviceType(selectedType);
        }

        function setDeviceType(selectedType) {
            var attrVal = (selectedType === "OldDevice") ? "0" : "1";   
            var parainfo="";
            parainfo+='x.DeviceType='+ attrVal + "&";
            parainfo+='x.X_HW_Token=' + ontToken;
            $.ajax({
                type : "POST",
                async : false,
                cache : false,
                data : parainfo,
                url : "setajax.cgi?x=InternetGatewayDevice.UserInterface.CfgClone" +
                "&RequestFile=html/ssmp/cfgmgmt/cfgmgmt.asp",
                success : function(data) {
                    if (selectedType === "NewDevice"){
                        resetONT();
                    }
                },
	        });
        }

        function resetONT() {
            var Form = new webSubmitForm();
            Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.X_HW_DEBUG.SMP.DM.ResetBoard'
                                    + '&RequestFile=html/ssmp/accoutcfg/ontmngt.asp');
            Form.addParameter('x.X_HW_Token', ontToken);
            Form.submit();
        }   

        function showPrompt(descKey) {
            var promptDes = GetLanguageDesc(descKey);
            if (!ConfirmEx(promptDes)) {
                return false;
            }
            return true;
        }

        function CancelConfig() {
            LoadFrame();
        }

    </script>
    </head>

    <body class="mainbody" onLoad="LoadFrame();">
        <script language="JavaScript" type="text/javascript">
        HWCreatePageHeadInfo("ledcfg", GetDescFormArrayById(ConfigMgmtDes, "s1105"), GetDescFormArrayById(ConfigMgmtDes, "s1102"), false);
    </script>
        <div class="title_spread"></div>
        <div class="func_title" BindText="s1101"></div>
        <div id="EnableForbidLedId">
            <table width="100%" border="0" cellpadding="0" cellspacing="1"
                class="tabal_noborder_bg">
                <tr>
                    <td class="table_right width_per15" id="EnableLedId">
                        <input type='radio' name='DeviceSelection'
                            id='DeviceSelection' value="OldDevice"
                            onclick="setDeviceType(this.value)">
                        <script>document.write(GetLanguageDesc("s1104"));</script>
                    </td>
                    <td class="table_right width_per15" id="EnableLedId">
                        <input type='radio' name='DeviceSelection'
                            id='DeviceSelection' value="NewDevice"
                            onclick="onDevRadioChecked(this.value, 's1106')">
                        <script>document.write(GetLanguageDesc("s1103"));</script>
                    </td>
                </tr>
            </table>
        </div>
        <script>
        ParseBindTextByTagName(ConfigMgmtDes, "div", 1);
        ParseBindTextByTagName(ConfigMgmtDes, "td", 1);
        ParseBindTextByTagName(ConfigMgmtDes, "input", 2);
    </script>
    </body>
</html>