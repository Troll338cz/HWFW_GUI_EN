<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<title>Video Recognition</title>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
</head>
<script language="JavaScript" type="text/javascript">
function VideoDeviceInfo(_Domain, _Enable, _DSCP)
{
    this.Domain = _Domain;
    
	this.Enable = _Enable;
	
	this.DSCP = _DSCP;
}

function VideoMACAddressItem(_Domain, _MacAddress)
{
	this.Domain = _Domain;
    this.MacAddress = _MacAddress;
}

var VideoMACAddressList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_VideoDevice.VideoDeviceList.{i}, MacAddress, VideoMACAddressItem);%>;
var VideoDeviceInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_VideoDevice, Enable|DSCP, VideoDeviceInfo);%>;
if (VideoMACAddressList == null)
{
    VideoDeviceInfoList[0] = new VideoMACAddressItem("","");
}
var VideoDeviceInfo = VideoDeviceInfoList[0];
var TableName = "VideomacList";

function LoadFrame()
{
    setCheck("VideoRecognitionEnable",VideoDeviceInfo.Enable);
    setText("DSCPremark",VideoDeviceInfo.DSCP);

    var enable = getElById("VideoRecognitionEnable").checked;
        setDisplay("DSCPremarkRow",VideoDeviceInfo.Enable);
		setDisplay("VideomacList_tbl",VideoDeviceInfo.Enable);
		setDisplay("videolist",VideoDeviceInfo.Enable);

}

function CheckForm()
{
    var dscpmark = getValue("DSCPremark");
    if (isNaN(dscpmark))
    {
        AlertEx(video_recognition_language["bbsp_video_recognition_isNaN"]);
        return false;
    }
    if (dscpmark<0 || dscpmark >63)
    {
        AlertEx(video_recognition_language["bbsp_video_recognition_rang"]);
        return false;
    }
	if(dscpmark == '')
	{
	    AlertEx(video_recognition_language["bbsp_video_recognition_null"]);
        return false;
	}
    return true;
}

function ApplyConfig()
{
    if (!CheckForm())
    {
        return false;
    }

    var Form = new webSubmitForm();
	Form.addParameter('x.Enable',getCheckVal("VideoRecognitionEnable")); 

    Form.addParameter('x.DSCP',getValue("DSCPremark")); 

    Form.addParameter('x.X_HW_Token', getValue('onttoken'));

    Form.setAction('set.cgi?x=InternetGatewayDevice.Services.X_HW_VideoDevice'
                        + '&RequestFile=html/bbsp/video/video.asp');
    Form.submit();  
}

function CancelConfig()
{
    LoadFrame();
}

function InitTableData()
{
    var videomaclen = VideoMACAddressList.length-1;
    var index = 0;
	var TableDataInfo = new Array()
    if (!videomaclen)
    {
		TableDataInfo[index] = new VideoMACAddressItem();
        TableDataInfo[index].domain = "--";
        TableDataInfo[index].MacAddress = "--";
    }
    else
    {
	    videomaclen = (videomaclen > 32)?32:videomaclen;
        for (var i =0 ;i < videomaclen; i++) 
        {
			TableDataInfo[i] = new VideoMACAddressItem();
            TableDataInfo[i].domain = VideoMACAddressList[i].domain;
            TableDataInfo[i].MacAddress = VideoMACAddressList[i].MacAddress;            
        }
    }

    TableDataInfo.push(null);
    HWShowTableListByType(1, TableName, false, ColumnNum, TableDataInfo, VideolistInfo, video_recognition_language, null);    
}

function selectLine()
{

}

function SubmitEnableForm()
{ 
    
	var enable = getCheckVal("VideoRecognitionEnable");
	setDisplay("DSCPremarkRow",enable);
	if(!enable)
    {
        setDisplay("DSCPremarkRow",0);
		setDisplay("VideomacList_tbl",0);
		setDisplay("videolist",0);	
    }
}
</script>
<body onLoad="LoadFrame();" class="mainbody">
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("dscptopbittitle", GetDescFormArrayById(video_recognition_language, "bbsp_mune"), GetDescFormArrayById(video_recognition_language, "bbsp_video_recognition_title"), false);
</script>
<div class="title_spread"></div>
<div class="func_title" BindText="bbsp_video_recognition">
    
</div>
<form id="DscpForm" name="DscpForm">
	<table>
    	<li   id="VideoRecognitionEnable"                 RealType="CheckBox"           DescRef="bbsp_enableVideoRecognition"       RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Enable"    InitValue="Empty" ClickFuncApp="onclick=SubmitEnableForm"/>
    	<li   id="DSCPremark"             RealType="TextBox"           DescRef="bbsp_videodscpmark"          RemarkRef="bbsp_videodscpmark_range"              		ErrorMsgRef="Empty"    Require="TRUE"    BindField="x.DSCP"    InitValue="Empty" Elementclass="width_60px restrict_dir_ltr"/>
	</table>
	<script>
		var TableClass = new stTableClass("width_per25", "width_per75", "ltr");
		HWParsePageControlByID("DscpForm", TableClass, video_recognition_language, null);
	</script>
	<table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
        <tr>
            <td class='width_per20'></td>
            <td class="table_submit pad_left5p">
    			<input id="ButtonApply"  type="button" onclick="ApplyConfig();" class="ApplyButtoncss buttonwidth_100px" BindText="bbsp_video_recognition_app">
                <input id="ButtonCancel" type="button" onclick="CancelConfig();" class="CancleButtonCss buttonwidth_100px" BindText="bbsp_video_recognition_cancel">
                <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">                
            </td>
        </tr>
	</table>
</form>
<div class="title_spread"></div>
<div BindText="bbsp_videolist" class="func_title" id="videolist"></div>
<script language="JavaScript" type="text/javascript">
    var VideolistInfo = new Array();
    VideolistInfo.push(new stTableTileInfo("bbsp_MACAddress","align_center","MacAddress"));
    VideolistInfo.push(new stTableTileInfo(null));
    var ColumnNum = VideolistInfo.length - 1;
    InitTableData();
</script>
</body>
<script>
    ParseBindTextByTagName(video_recognition_language, "span", 1);
    ParseBindTextByTagName(video_recognition_language, "input", 2);
    ParseBindTextByTagName(video_recognition_language, "td", 1);
    ParseBindTextByTagName(video_recognition_language, "div", 1);
</script> 
</html>