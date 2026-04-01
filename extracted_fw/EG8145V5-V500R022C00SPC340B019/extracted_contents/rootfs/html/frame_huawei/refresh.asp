<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1">
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<title></title>
<script type="text/javascript">
var refreshData = 1;
var xmlHttp = false;
var curUserName = '<%HW_WEB_GetCurUserName();%>';
var totalPlay = '<%HW_WEB_GetFeatureSupport(FT_SSMP_TOTALPLAY);%>';

function IsFF()
{          
	return navigator.userAgent.indexOf("Firefox")!=-1;      
}

function CheckHeartAllWithoutFF()
{
	$.ajax({
        type : "GET",
        async : true,
        cache : false,
        url : "../html/ssmp/common/refreshTime.asp",
        success : function(data) {
            refreshData = data;
            if ( refreshData != 1)
            {
                clearInterval(TimerHandle);
                window.location.replace("/login.asp");
            }
        }
    });

    if (totalPlay == '1') {
        $.ajax({
            type : "GET",
            async : true,
            cache : false,
            url : "../html/ssmp/common/getCurrentUserName.asp",
            success : function(data) {
                curUserName = data;
            }
        });
    }
}

function handleResponse()
{
	if(xmlHttp.readyState == 4 && xmlHttp.status==200)
	{
		var HeartStatus = xmlHttp.responseText;
		if (HeartStatus.substr(0,1) == "1") 
		{
			xmlHttp = null;
			return true;
		} 
		
		xmlHttp = null;
		clearInterval(TimerHandle);
		window.location.replace("/login.asp");
		return true;
	}
}

function CheckHeartStatus()
{
	try 
	{
		xmlHttp = new XMLHttpRequest();
	}
	catch (trymicrosoft) 
	{
	 	try 
		{
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} 
		catch (othermicrosoft) 
		{
			try 
			{
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			} 
			catch (failed) 
			{ 
				xmlHttp = false;
			}
		}
	}
	
	if (!xmlHttp)
	{
		return true;
	}
	
	try
	{
	    xmlHttp.open("GET", "/html/ssmp/common/refreshTime.asp", true);
		xmlHttp.send(null);
		setTimeout("xmlHttp.onreadystatechange = handleResponse();", 3000);
	}
	catch(e)
	{
		return true;
	}
	
    return true;
}

function requestCgi()
{
    if (totalPlay == '1') {
        if (top.UserName != curUserName) {
            window.location.replace("/login.asp");
        }
    }

	if (parent.UpgradeFlag == "0")
	{ 
		if (true == IsFF())
		{
			xmlHttp = null;
			CheckHeartStatus();
			//CheckHeartAllWithoutFF();
		}
		else
		{
			CheckHeartAllWithoutFF();
		}
	}
}

var TimerHandle = setInterval("requestCgi()", 5000);
</script>
</head>
<body onload=""> </body>
</html>
