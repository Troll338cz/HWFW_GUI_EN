<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="Pragma" content="no-cache"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" type="text/javascript">
var ForceSupport = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_UserInfo.ForceSupport);%>';

function OnClick()
{
    if (ConfirmEx("关闭RMS注册强制跳转功能设备将会自动重启生效，确认关闭吗？") == false) {
        return;
    }

    if (ForceSupport == 0) {
        location.reload(true);
        return;
    }
    setDisable('closermsjump', 1);
    $.ajax({
            type : "POST",
            async : true,
            cache : false,
            data : "x.X_HW_Token="+getValue('onttoken'),
            url : "closeforcesupport.cgi?&RequestFile=html/ssmp/closeforcesupport/closeforcesupport.asp",
            success : function(data) {
                location.reload(true);
            },
            complete: function (XHR, TS) {
                XHR=null;
            }
        });
}
function LoadFrame()
{
    if (ForceSupport === '0') {
        setDisable('closermsjump', 1);
    }
}
</script>
</head>
<body class="mainbody" onLoad="LoadFrame();">
	<div class="func_spread"></div>
	<div class="title_with_desc">
		<label id="Title_reboot_lable">关闭RMS跳转</label>
	</div>
	<div class="title_01" style="padding-left:10px;" width="100%">
		<label id="Title_reboot_tips_lable">点击[关闭RMS跳转]按钮，系统将关闭RMS注册强制跳转功能。</label>
	</div>
	<div class="button_spread"></div>
	<div align="right">
		<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
		<input type='button' name="closermsjump" id="closermsjump" class="submit" style="width:98px" onClick='OnClick()' value="关闭RMS跳转">
	</div>
</body>
</html>
