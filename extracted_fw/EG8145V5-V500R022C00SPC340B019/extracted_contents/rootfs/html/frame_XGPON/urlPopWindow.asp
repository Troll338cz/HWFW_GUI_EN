<html>
<head>	
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1">
<title></title>	
</head>
<style>
.input_time {border:0px; }
</style>

<script type="text/javascript" src="../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(safelogin.js);%>"></script>
<script language="javascript">


var data = "<%GetUrlPushInfo();%>";
var Wid = "";
var Hei= "";
var Xxx= "";
var Yyy= "";
var Urla= "";
var OriUrla= "";
var IsMaintWan = '<%HW_WEB_IfMainWanLink();%>';

function getPageHeight(){
  var g = document, a = g.body, f = g.documentElement, d = g.compatMode == "BackCompat"
  ? a
  : g.documentElement;
  return Math.max(f.scrollHeight, a.scrollHeight, d.clientHeight);
}

function getPageWidth(){
  var g = document, a = g.body, f = g.documentElement, d = g.compatMode == "BackCompat"
  ? a
  : g.documentElement;
  return Math.max(f.scrollWidth, a.scrollWidth, d.clientWidth);
}

function WdPopWinTraceSet()
{
    $.ajax({
        type  : "POST",
        async : false,
        cache : false,
        url   : "WebWdPopCancel",
        data: getDataWithToken(),
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
    var br0Ip = '<%HW_WEB_GetBr0IPString();%>';
    var httpport = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_WebServerConfig.ListenInnerPort);%>';
	if(IsMaintWan ==1)
	{
		var starIdx = window.location.href.indexOf('://');
	    var subAddr = window.location.href.substr(starIdx+3);
		var br0Ip = subAddr.substring(0, subAddr.indexOf('/'));
	}
    if( window.location.href.indexOf(br0Ip) == -1 )
    {
    	if(IsMaintWan !=1)
		{
    	    window.location = 'http://' + br0Ip +':'+ httpport +'/urlPopWindow.asp';    
		}
		else
		{
		     window.location = 'http://' + br0Ip +'/urlPopWindow.asp';  
		}    
    }

    WdPopWinTraceSet();
	setTimeout(LoadFrame1,2000);
}

function LoadFrame1()
{ 
	 var parameterS = data.split("|");
	 var browserWidth = getPageWidth();
	 var browserheight = getPageHeight();
	 var  browserWidthInt = parseInt(browserWidth,10);
 	 var  browserheightInt = parseInt(browserheight,10);
	 Wid = parameterS[0];
	 Hei = parameterS[1];
	 Xxx = parameterS[2];
	 Yyy = parameterS[3];
	 Urla = parameterS[4];
	 OriUrla = parameterS[5];
	var WidInt = 	 parseInt(Wid,10); 
	var HeiInt = 	 parseInt(Hei,10); 
	var XxxInt = 	 parseInt(Xxx,10); 
	var YyyInt = 	 parseInt(Yyy,10);

	 if ( (Wid>browserWidth) || (Xxx>browserWidth) || (Hei>browserheight) || (Yyy>browserheight) )
	 {
	     Wid = browserWidth/2;
	     Hei = browserheight/2;
	     Xxx = browserWidth/4;	    
	     Yyy = browserheight/4;
	 }
	 
	  if ( ((WidInt+XxxInt)>browserWidthInt) || ((HeiInt+YyyInt)>browserheightInt))
	 {
	     Wid = browserWidth/2;
	     Hei = browserheight/2;
	     Xxx = browserWidth/4;	    
	     Yyy = browserheight/4;
	 }
	var para = "height="+Hei+",width="+Wid+",top="+Yyy+",left="+Xxx+",toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no";
	window.open(Urla, "newwindow",para);
	window.top.location=OriUrla;
}

</script>


<body onLoad="LoadFrame();"> 
</body>

</html>









