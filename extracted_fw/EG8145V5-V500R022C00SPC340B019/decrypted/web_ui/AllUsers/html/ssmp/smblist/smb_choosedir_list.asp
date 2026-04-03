<!-- InstanceBegin template="/Templates/template_all.dwt" codeOutsideHTMLIsLocked="false" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"> 
<HTML><!-- InstanceBegin template="/Templates/template_all.dwt" codeOutsideHTMLIsLocked="false" -->
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="thickbox.css" type="text/css" media="screen" />
<link rel="stylesheet" href="contentstyle.css" type="text/css">
<title>dir/usb/</title>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="<%HW_WEB_CleanCache_Resource(sambaTreeview.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" src="<%HW_WEB_CleanCache_Resource(thickbox.js);%>"></script>
<style type="text/css">
#BaseMask {
	width:90%;
	height:95%;
	position:absolute;
	margin-left:auto;
	margin-right:auto;
	z-index:2;
	filter: alpha(opacity=60);
	-moz-opacity: 0.6;
	-khtml-opacity: 0.6;
	opacity: 0.6;
	background-color:#eeeeee;
	display:none;
	/*
	background:url(../images/nimages/maskbg.jpg) no-repeat center;
	-webkit-filter: blur(3px);
	-moz-filter: blur(3px);
	-ms-filter: blur(3px);
	-o-filter: blur(3px);
	*/	
}
</style>
<script language="JavaScript"type="text/javascript">
try 
{ 
	document.execCommand('BackgroundImageCache', false, true); 
} 
catch(e) 
{}
</script>

<script type="text/JavaScript">

var IsFinishGetPath = 0;
function getQueryValue( name )
{
	var query = location.search;
	if (query=="") return "" ;
	query = query.substr( 1, query.length ) ; 
	var arr = query.split( /\&/ );
	name = name+"=" ;
	var index;
	for( var x = 0 ; x < arr.length ; x++ ){
		index = arr[x].indexOf(name) ;
		if( index != 0 )  continue ; 
		return arr[x].substr( name.length, arr[x].length ) ;
	}
	return "" ;
}
    
function getIntQueryValue( name, default_val )
{
	var r ;
	var q = getQueryValue( name ) ;
	if( q=='' )  r = default_val ;
	else		 r = parseInt(q) ;

	return r ;
}

var currentNameTypeAsp = '<%webAspGetUsbLogic();%>';
 var pr = window.opener; 
 var g_idNum = 0; 
 var g_radioValue = 0; 
 var $folderimage = '<img src="images/folder-closed.gif" />'; 
 var $fileimage = '<img src="images/file.gif" />'; 
 var $diskimage = '<img src="images/pic_t_disk.gif" />'; 
 var path = ''; 
 var OldPath = ''; 
 var strTmp = ''; 
 var bSupportFile = getIntQueryValue('fileType', 0); 

 var choose = getIntQueryValue('Choose', 1); 
 var strANSIName=''; 
 var strUTF8Name=''; 


function ChangeHtmlToBlank(SrcStr)
{
    var DestStr = '';
    var re = /&nbsp;/g;
    DestStr = SrcStr.replace(re, ' ');
    return DestStr;
}

function closePOPUP() {

	self.parent.tb_removeFunc();
}
var medienwdg_verzname = '';
function applyPOPUP() {

	var Submitpath;
	var SubmitBase64path;
	strTmp = path.split("/*");
	if (strTmp[0].length >= self.parent.avMaxPathLen) {
		return false;
	}
    path = "/mnt" + strTmp[0];
    var tempURI = encodeURI(strTmp[0]);
    strTmp[0] = decodeURI(tempURI.replace(new RegExp(/(%C2%A0)/g),"%20"));

    if (strTmp[0].indexOf('&nbsp;') > -1)
    {
        medienwdg_verzname = ChangeHtmlToBlank(strTmp[0]);
    }
    else
    {
        medienwdg_verzname = strTmp[0];
    }
	Submitpath  = medienwdg_verzname;
	SubmitBase64path=strTmp[1];
	if(Submitpath.charAt(Submitpath.length-1) == '/')
 	{
 		Submitpath = Submitpath.substring(0,Submitpath.length-1);
 	}
 	if(SubmitBase64path.charAt(SubmitBase64path.length-1) == '-')
 	{
 		SubmitBase64path = SubmitBase64path.substring(0,SubmitBase64path.length-1);
 	}
 	
	if (top.FTPType == "SFTP")
	{
		self.parent.getElementById('ChoosDir').value = Submitpath;
	}
	else
	{
		var CurUrlUtf = self.parent.getElementById('UrlUtf');
        var CurUrlBase;
        if (choose == '2') {
            CurUrlBase = self.parent.getElementById('UrlBase_account');
            if ( CurUrlUtf == null) {
                CurUrlUtf = self.parent.getElementById('SaveAsPath_text_account');
            }
        } else {
            CurUrlBase = self.parent.getElementById('UrlBase');
            if ( CurUrlUtf == null) {
                CurUrlUtf = self.parent.getElementById('SaveAsPath_text');
            }
        }

		CurUrlUtf.value = Submitpath;
		CurUrlBase.value = SubmitBase64path; 
	}
	

	self.parent.tb_removeFunc();
}

function splitData(inputData)
{
	var tmpArray=inputData.split("/|");
	var tmpArrayName;
	var uLength = tmpArray.length - 1;
	var uNameCount =0;
	var tmpNew;
	strANSIName = '';
	strUTF8Name = '';
	for(var i=0; i<uLength; i++)
	{			
		tmpArrayName = tmpArray[i].split("/*");
		if (2 != tmpArrayName.length)
		{
			continue;
		}
	
		strUTF8Name += tmpArrayName[1]+"/|";
		tmpNew 	=tmpArrayName[1].split("/:");
	
		strANSIName +=tmpArrayName[0]+"/:"+tmpNew[1]+"/|";
		
		uNameCount +=1;
		
	}
	return ;
}


	$(document).ready(function(){
		$("#browser").treeview({
			toggle: function() {
			path = $(this).findTreePath();
			
			var AppendId = '';
			
		    if ('' != path)
			{
				var pose = path.indexOf('notAppend#');
			    if (-1 == pose)
				{  
					$("#BaseMask").css("display","block");
					var d = new Date();
   					var tStart = d.getMinutes()*60 + d.getSeconds();
   					var tval   = 0;
                   
				    AppendId = $(this).find('ul').attr('id');
	
				    var tmpPath = path.split("/*");
				    var urlPath = '';
				    urlPath = tmpPath[1];
					
				   if(0 != IsFinishGetPath)
				   {
						return;
				   }
				   
				   IsFinishGetPath = 1;
				    $.ajax({
					type:'POST',
					url:'../common/getCurrentUsbDir.asp?&1=1',
					data:'usbDir='+urlPath + '&FileType='+bSupportFile,
					success:function(data){
					    data = hexDecode(data);
						var d = new Date();
						var tend = d.getMinutes()*60 + d.getSeconds();
						tval= tend -tStart;		
						data = splitData(data);								
						$(this).AppendOthersFromAjax(bSupportFile, 1, AppendId, strUTF8Name, strANSIName);
						IsFinishGetPath = 0;						
						$("#BaseMask").css("display","none");
					},
					error:function(){
						IsFinishGetPath = 0;
						$("#BaseMask").css("display","none");
					}
					});
				}
				else
				{
				    path = path.substring(10);
				}
			}
		}
	});
	window.onresize=$(this).resize;	
	$(function() {
		   
		    splitData(currentNameTypeAsp);
		    $(this).AppendOthersFromAjax(bSupportFile, 0, 'browser', strUTF8Name, strANSIName);
	});
});


</script>

<link rel="stylesheet" href="<%HW_WEB_CleanCache_Resource(sambaTreeview.css);%>" type="text/css" />
</head>
<body>

<table id="showContent" border="0" cellpadding="0" cellspacing="0" width="100%" style="height: 100%;">
  <tr>
    <td valign="top">
	<div id="BaseMask" style="display:none"></div>
	 <p>&nbsp;</p>
      <table border="1" cellpadding="1" cellspacing="0" width="95%" style="background-color: #F0F0F0;">
        <tr width="100%" >
          <td align="center" style="width: 100%;"><script language="JavaScript" type="text/javascript">document.write(SambaLgeDes['s1433']);</script></td>
        </tr>
      </table>

		<div style="height:220px; width:560px; overflow-y:scroll;overflow-x:scroll; white-space:nowrap;" id="main">
		<ul id="browser" class="filetree" style="height:260px; margin-left:10px;">
		</ul>	
		</div>
		<p>&nbsp;</p>
      <table border="1" cellpadding="1" cellspacing="0" width="95%" style="background-color: #F0F0F0;" >
        <tr>
          <td><button type="button" id="btnApplyReturn" class="stylebut" style="width:108px" onclick="closePOPUP()"><script language="JavaScript" type="text/javascript">document.write(SambaLgeDes['s1434']);</script></td>
	      <td style="width: 100%;">&nbsp;</td>
          <td align="right"><button type="button" id="btnApplyOK" class="stylebut" style="width:108px" onclick="applyPOPUP()"  disabled="disabled"><script language="JavaScript" type="text/javascript">document.write(SambaLgeDes['s1435']);</script></td>
        </tr>
      </table>

    </td>
  </tr>
</table>
<div id="maskWaiteImg"></div>
<div id="maskContent"></div>
</BODY>

</HTML>

