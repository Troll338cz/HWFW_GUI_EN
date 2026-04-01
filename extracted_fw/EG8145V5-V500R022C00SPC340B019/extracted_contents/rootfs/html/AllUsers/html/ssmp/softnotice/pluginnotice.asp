<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta name="format-detection" content="telephone=no"/>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>

<style type="text/css">

</style>

<script language="JavaScript" type="text/javascript">
var pluginNotice = <%WEB_GetEaiDescription();%>;

function LoadFrame()
{
    document.getElementById('pluginNoticeTitle').innerHTML = SoftNoticeDes["p2001"];
    if ((pluginNotice === "") || (pluginNotice === "0") || (pluginNotice === 0)) {
        document.getElementById('pluginNotice').innerHTML = SoftNoticeDes["p2002"];
    } else {
        document.getElementById('pluginNotice').innerHTML = pluginNotice;
    }
}
</script>
</head>
<body class="mainbody pageBg" onLoad="LoadFrame();">
    <div class="func_title" id="pluginNoticeTitle">EAI Plugin Notice</div>
    <div class="table_title" id="pluginNotice" style="height: 220px;"></div>
</body>
</html>
