<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>JVM Resource Monitoring</title>
</head>
<script>
    function initstring(str)
    {
        var partvalue = str.split(";");
        var arr = [];

        for (var i = 0; i< partvalue.length-1; i++) 
        {
        	arr.push(partvalue[i]);
        }
        return arr;
    }

	function ConvertEmptyString(str)
	{
		var value = "";
		if (str == "")
		{
			value = "--";
		}
		else
		{
			value = str;
		}
		return value;
	}

	function InitData()
	{
		var status = "";
		var htmlline = "";
		
		$.ajax({
			type : "POST",
			async : true,
			cache : false,
			url : 'GetJVMStatus.asp',
			success : function(data) 
			{
				status = hexDecode(data);
        
                if (status == "" || status == null)
                {
                    htmlline += '<tr align="center" class= "tabal_01 jvmclass">';
                    htmlline += '<td align="center" class="width_per16">--</td>';
                    htmlline += '<td align="center" class="width_per16">--</td>';
                    htmlline += '<td align="center" class="width_per16">--</td>';
                    htmlline += '<td align="center" class="width_per16">--</td>';
                    htmlline += '<td align="center" class="width_per16">--</td>';
                    htmlline += '<td align="center" class="width_per16">--</td></tr>';  
                }
                else
                {
                    for (var i = 0;i < initstring(status).length; i++)
                    {
                        var statusvalue = initstring(status)[i].split("|");
                        htmlline += '<tr class= "tabal_01 jvmclass">';
                        htmlline += '<td align="center" class="width_per16" title='+statusvalue[0]+'>'+GetStringContent(ConvertEmptyString(statusvalue[0]),20)+'</td>';
                        htmlline += '<td align="center" class="width_per16">'+ConvertEmptyString(statusvalue[1])+'</td>';
                        htmlline += '<td align="center" class="width_per16">'+ConvertEmptyString(statusvalue[2])+'</td>';
                        htmlline += '<td align="center" class="width_per16">'+ConvertEmptyString(statusvalue[3])+'</td>';
                        htmlline += '<td align="center" class="width_per16">'+ConvertEmptyString(statusvalue[4])+'</td>';
                        htmlline += '<td align="center" class="width_per16">'+ConvertEmptyString(statusvalue[5])+'</td></tr>';  
                    }
                }

                $("#jvminfo").siblings('.jvmclass').remove();

                $("#jvminfo").after(htmlline);                 
			}
		});	
	}

	function refreshstatus()
	{ 
		setDisable("refreshbtn",1);
		
		InitData();

        setTimeout(function(){
            setDisable("refreshbtn",0);
        },5000);
	}

	function backupSetting()
	{
        var Form = new webSubmitForm();

        Form.addParameter('logtype', "opt");

        Form.setAction('jvmlogdown.cgi?FileType=snapshot&RequestFile=html/ssmp/smartontinfo/JVMResourceMonitoring.asp');

        Form.addParameter('x.X_HW_Token', getValue('onttoken'));

        Form.submit();
	}

	function LoadFrame()
	{
		InitData();
	}
</script>
<body class="mainbody" onLoad = "LoadFrame();">
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("boundlestatusasp", GetDescFormArrayById(SmartOntdes, "s1126"), GetDescFormArrayById(SmartOntdes, "s1127"), false);
</script> 
<div class="title_spread"></div>
<table class="tabal_bg width_100p" cellspacing="1" width="100%;">  
  <tr class="head_title" id="jvminfo"> 
    <td align="center" class="width_per16" BindText = 's1120'></td> 
    <td align="center" class="width_per16" BindText = 's1121'></td> 
    <td align="center" class="width_per16" BindText = 's1122'></td>
    <td align="center" class="width_per16" BindText = 's1123'></td>      
	<td align="center" class="width_per16" BindText = 's1124'></td>
	<td align="center" class="width_per16" BindText = 's1125'></td>  
  </tr> 
</table>
<div class="title_spread"></div>
<table width="100%" cellpadding="0" cellspacing="0"> 
	<tr> 
		<td> 
			<input style= "float: right;" class="ApplyButtoncss buttonwidth_150px_250px" name="button" id="refreshbtn" type="button"  onclick="refreshstatus()" BindText="s1129" > 
		</td> 
	</tr> 
</table>
<table width="100%" cellpadding="0" cellspacing="0"> 
	<tr> 
		<td> 
			<input  class="ApplyButtoncss buttonwidth_150px_250px" name="button" id="downbutton" type="button"  onclick="backupSetting()" BindText="s1128" > 
			<input type="hidden" name="onttoken" id="onttoken" value="<%HW_WEB_GetToken();%>">
		</td> 
	</tr> 
</table>
<div>
	<textarea name="logarea" id="logarea" class="text_log" wrap="off" readonly="readonly">
	</textarea>
	<script type="text/javascript">
        var readstr = '<%HW_WEB_GetJvmSnapshot();%>';
		if (readstr == "none")
		{
			document.getElementById("logarea").value = SmartOntdes["s1131"];
            setDisable("downbutton",1);
		}
		else
		{
			document.getElementById("logarea").value = readstr;
		}
	</script>  
</div>   
<div class="func_spread"></div>
<div class="func_spread"></div>
<script>
	ParseBindTextByTagName(SmartOntdes, "span", 1);
	ParseBindTextByTagName(SmartOntdes, "input", 2)
	ParseBindTextByTagName(SmartOntdes, "td", 1);
	ParseBindTextByTagName(SmartOntdes, "div", 1);
</script>
</body>
</html>