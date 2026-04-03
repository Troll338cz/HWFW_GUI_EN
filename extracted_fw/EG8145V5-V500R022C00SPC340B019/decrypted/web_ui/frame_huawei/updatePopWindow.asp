<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="Cache-Control" content="no-cache">
<script language="JavaScript" src="/../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(safelogin.js);%>"></script>
</head>
<style>
.input_time {border:0px; }
</style>
<script language="JavaScript" type="text/javascript">

var data = "<%GetUpgradePushInfo();%>";

var Wid = "400";
var Hei= "200";
var Xxx= "200";
var Yyy= "200";
var OriUrla= "";
var Urla= "";

function upgrageTraceSet()
{
    $.ajax({
        type  : "POST",
        async : false,
        cache : false,
        data  : getDataWithToken('popType=upgrade'),
        url   : "WEB_WindowsPopTracerSet",
        success : function(data) {
            conflict = true;
        },
        error : function(XMLHttpRequest, textStatus, errorThrown) {
            conflict = false;
        },
        complete: function (XHR, TS) { 
            XHR = null;
      }         
    }); 
}
function LoadFrame()
{ 	
	upgrageTraceSet();
	setTimeout(LoadFrame1,2000);
}

function LoadFrame1()
{ 
	var parameterS = data.split("|");
	
	if (parameterS.length < 4 ){
		return;
	}
	
	Urla = parameterS[4];
	OriUrla = parameterS[5];
	var para = "height="+Hei+",width="+Wid+",top="+Yyy+",left="+Xxx+",toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no";
		
	window.open(Urla, "newwindow",para);
	
	var para ="http://" + OriUrla;
	window.top.location=para;
}

</script>


<body onLoad="LoadFrame();"> 
</body>

</html>









