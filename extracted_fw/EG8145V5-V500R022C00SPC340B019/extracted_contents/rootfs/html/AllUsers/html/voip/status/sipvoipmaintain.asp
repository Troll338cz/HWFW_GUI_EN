<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<style>
.uriclass
{ 
	word-break:break-all;
	min-width:30px;
}

.regnameclass
{ 
	word-break:break-all;
	width:110px;
}


</style>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<title>VOIP Status</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, sipstatus);%>"></script>
<script language="JavaScript" type="text/javascript">
var curLoginUserType = "<%HW_WEB_GetUserType();%>";
var CfgMode = '<%HW_WEB_GetCfgMode();%>';
var var_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var CfgWord = CfgMode.toUpperCase();
var additionalNumberHtml = "";
var isUnicomFlag = false;
if(CfgWord.indexOf("CU") >=0 || CfgWord.indexOf("UNICOM") >=0 )
{
	isUnicomFlag = true;
}
else
{
	isUnicomFlag = false;
}



function stLine(Domain, DirectoryNumber, PhyReferenceList, Status, CallState,RegisterError)
{
    this.Domain = Domain;
    if(DirectoryNumber != null)
    {
        this.DirectoryNumber = DirectoryNumber.toString().replace(/&apos;/g,"\'");
    }
    else
    {
        this.DirectoryNumber = DirectoryNumber;
    }

	this.PhyReferenceList = PhyReferenceList;
    this.Status = Status;
    this.CallState = CallState;
    this.RegisterError = RegisterError;
    this.LineIns = parseInt(Domain.split(".")[7]);
}

function stLineURI(Domain, URI)
{
	this.Domain = Domain;
	if(URI != null)
    {
        this.URI = URI.toString().replace(/&apos;/g,"\'");
    }
    else
    {
        this.URI = URI;
    }
}

function stAdditionalNumber(Domain, Number)
{
    this.Domain = Domain;
    this.Number = Number;
    this.LineIns = parseInt(Domain.split(".")[7]);
    this.pilot = "--";
    this.repeat = false;
    for (var i = 0; i < AllLine.length - 1; i++) {
        if (this.LineIns == AllLine[i].LineIns) {
            var srcNum = "";
            if (AllLineURI[i].URI != "") {
                srcNum = AllLineURI[i].URI;
            } else if (AllLine[i].DirectoryNumber != "") {
                srcNum = AllLine[i].DirectoryNumber;
            } else {
                srcNum = AllAuth[i].AuthUserName;
            }

            var k3 = "";
            if ((srcNum.indexOf(":") >= 0)) {
                var UserId = srcNum.split(':');
                var k1 = UserId[1];
                var k2 = k1.split('@');
                k3 = k2[0];
            } else {
                var UserId = srcNum.split('@');
                k3 = UserId[0];
            }
            if (k3 == "") {
                this.pilot = "--";
            } else {
                this.pilot = k3;
            }

            if (this.pilot == this.Number) {
                this.repeat = true;
            }
            return;
        }
    }
    return;
}

function AdditionalNumberShowTab(index, number, pilot)
{
    this.index = index;
    this.number = number;
    this.pilot = pilot;
}

function fillAdditionalNumberTab(TableName, ColumnTitleDesArray, TableDataInfo)
{
    var LIneDate;
    for (var Data_j = 0; Data_j < TableDataInfo.length - 1; Data_j++) {
        var LIneDate = TableDataInfo[Data_j];
        if (Data_j % 2 == 0) {
            var LineHtml = '<TR id="' + TableName + '_record_' + Data_j + '" class="tabal_01" onclick="selectLine(this.id);">';
        } else {
            var LineHtml = '<TR id="' + TableName + '_record_' + Data_j + '" class="tabal_02" onclick="selectLine(this.id);">';
        }

        for (var Title_j = 0; Title_j < ColumnTitleDesArray.length - 1; Title_j++) {
            var TitleAttrName = ColumnTitleDesArray[Title_j].ShowAttrName;
            var ShowFlag = ColumnTitleDesArray[Title_j].IsNotShowFlag;
            var TdMaxNum = ColumnTitleDesArray[Title_j].MaxNum;
            var Td_i_Class = (null == ColumnTitleDesArray[Title_j].TableClass ? "" : ColumnTitleDesArray[Title_j].TableClass);
            var Ischangecode = (undefined != ColumnTitleDesArray[Title_j].Ischangecode && 0 == ColumnTitleDesArray[Title_j].Ischangecode ? 0 : 1);
            if (true == ShowFlag || "summary" == ShowFlag) {
                continue;
            }

            if ("DomainBox" == TitleAttrName) {
                var onclickstr = GetCheckboxFuncString(TableName);
                LineHtml += '<TD class="' + Td_i_Class + bottomBorderClass(false) + '" ><input id = "' + TableName + '_rml'+ Data_j + '" type="checkbox" name="' + TableName + 'rml"'  + onclickstr + ' value="' + TableDataInfo[Data_j].domain + '"></TD>';
                continue;
            }

            var TdId = ' id="' + TableName + "_" + Data_j + "_" + Title_j + '" ';
            if ("NumIndexBox" == TitleAttrName) {
                LineHtml += '<td class="' + Td_i_Class + '" ' + TdId + '>' + (Data_j+1) + '</td>';
                continue;
            }
            
            if ("Button" == TitleAttrName.split('_')[1]) {
                var valueHtml = (LIneDate[TitleAttrName] == 'del')?status_wlaninfo_language["amp_booststa_del"]:status_wlaninfo_language["amp_booststa_add"]; 
                LineHtml += '<TD class="' + Td_i_Class + '" ><input id = "' + TableName + '_' + Data_j + '" type="button" class="NewDelbuttoncss"' + 'value="'+ valueHtml +'"' + 'onclick = "'+ TableName + '_'+ LIneDate[TitleAttrName] + '_BtnClick(this); "'  + '></TD>';
                continue;
            }
            
            if (Ischangecode == 0) {
                var ShowAttrValue = LIneDate[TitleAttrName];
            } else {
                var ShowAttrValue = htmlencode(LIneDate[TitleAttrName]);
            }
            
            if (ShowAttrValue != null) {
                var InnerHtml = (TdMaxNum == "undefined" || TdMaxNum == "") ? ShowAttrValue : GetStringContent(ShowAttrValue, TdMaxNum);
                if (ShowAttrValue === InnerHtml) {
                    LineHtml += '<TD class="' + Td_i_Class + bottomBorderClass(false) + '" ' + TdId +'>' + InnerHtml + '</TD>'; 
                } else {
                    LineHtml += '<TD class="' + Td_i_Class + bottomBorderClass(false) + '" title="' + ShowAttrValue + '"' + TdId +'>' + InnerHtml + '</TD>';
                }
            }
        }
        LineHtml+='</tr>';
        additionalNumberHtml += LineHtml;
    }
}

function showAdditionalNumber(TableName, ColumnNum, TableDataInfo, ColumnTitleDesArray, LaguageList)
{
    var width = "80%";
    additionalNumberHtml = "<table";
    additionalNumberHtml += " id=\"" + TableName + "_tbl" + "\"";
    additionalNumberHtml += " width=\"" + width + "\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
            + "<tr class=\"alignment_rule\">"
            + "<td>";
    additionalNumberHtml += "<\/td>"
            + "<\/tr>"
            + "<tr>"
            + "<td id=\"" + TableName + "_head" + "\">";

    var LineRowDataNum = TableDataInfo.length - 1;
    additionalNumberHtml += '<table width="100%" class="tabal_bg" id="' + TableName + '" cellspacing="1">';
    for (var Column_i = 0; Column_i < ColumnNum;  Column_i++) {
        if (Column_i == 0) {
            additionalNumberHtml += '<tr class="head_title">';
        }

        if (ColumnTitleDesArray[Column_i].IsNotShowFlag == true) {
            continue;
        }

        var headid = ' id="head' + TableName +  "_0_" + Column_i + '" ';
        var Column_i_Des = ColumnTitleDesArray[Column_i].DesRef;
        var Column_i_Class = (null == ColumnTitleDesArray[Column_i].TableClass ? "" : ColumnTitleDesArray[Column_i].TableClass);
        var Des = (null == LaguageList[Column_i_Des] || undefined == LaguageList[Column_i_Des]) ? "" : LaguageList[Column_i_Des];
        additionalNumberHtml += '<td class="' + Column_i_Class + bottomBorderClass(false) + '"' + headid + '>' + Des + '<\/td>';
    }
    
    additionalNumberHtml += '</tr>';

    fillAdditionalNumberTab(TableName, ColumnTitleDesArray, TableDataInfo);
    additionalNumberHtml +='</table>' + "<\/td><\/tr><\/table>";

    if (document.getElementById("additionalNumber")) {
        document.getElementById("additionalNumber").innerHTML = additionalNumberHtml;
    }
}

function setControl(index, id)
{
    if (CfgWord != "OTE") {
        return;
    }

    if (id != undefined && id.indexOf("tdVoipInfo") < 0) {
        return;
    }
    
    if (index == undefined) {
        index = 0;
    }

    var additionalNumberArray = new Array();
    var count = 0;
    for (var loop = 0; loop < AllAdditionalNumber.length - 1; loop++) {
        if (AllAdditionalNumber[loop].repeat) {
            continue;
        }
        count++;
        var additionalNumberTab = new AdditionalNumberShowTab();
        additionalNumberTab.index = count;
        additionalNumberTab.number = AllAdditionalNumber[loop].Number;
        additionalNumberTab.pilot = AllAdditionalNumber[loop].pilot;
        additionalNumberArray.push(additionalNumberTab);
    }

    if (count == 0) {
        var additionalNumberTab = new AdditionalNumberShowTab();
        additionalNumberTab.index = "--";
        additionalNumberTab.number = "--";
        additionalNumberTab.pilot = "--";
        additionalNumberArray.push(additionalNumberTab);
    }

    additionalNumberArray.push(null);

    var additionalNumberConfiglistInfo = new Array(
    new stTableTileInfo("vspa_seq","align_center ","index", false),
    new stTableTileInfo("vspa_additionnumber","align_center ","number", false),
    new stTableTileInfo("vspa_pilot", "align_center ", "pilot", false), null);

    showAdditionalNumber("tdAdditonalNumberInfo", 3, additionalNumberArray, additionalNumberConfiglistInfo, sipstatus);
}

function IsTURKSGatewayUser()
{
    if ((CfgMode.toUpperCase() == 'TURKSATEBG2') && (curLoginUserType != "0")) {
        return true;
    } else {
        return false;
    }
}

var AllLineURI = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.SIP,URI,stLineURI);%>;
var AllLine = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i},DirectoryNumber|PhyReferenceList|Status|CallState|X_HW_LastRegisterError,stLine);%>;
var AllAuth = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.SIP,AuthUserName,stAuth);%>;
if (CfgWord == "OTE") {
    var AllAdditionalNumber = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.X_HW_MSN.{i}, Number,stAdditionalNumber);%>;
}
var AllCodeAndReason = '<%HW_WEB_GetVspRegReason();%>';

var SplitCodeReason = AllCodeAndReason.split("|");
var SplitCodeReaRegTimeForOneUser = new Array();
var OutputCodeReason = new Array();
var OutputRegTime    = new Array();


for ( var m = 0; m < AllLine.length - 1; m++ )
{
	if ( m + 1 > SplitCodeReason.length )
	{
		OutputCodeReason[m] = '--';
		OutputRegTime[m]    = '--';
	}
	else
	{
	
		SplitCodeReaRegTimeForOneUser[m] = SplitCodeReason[m].split("<");
        
		if(SplitCodeReaRegTimeForOneUser[m].length < 2)
		{
			OutputRegTime[m] = "--";
		}
		else
		{
			OutputRegTime[m] = SplitCodeReaRegTimeForOneUser[m][1];
		}
		
		if ( ( AllLine[m].RegisterError == 'ERROR_REGISTRATION_AUTH_FAIL' )
		     || ( AllLine[m].RegisterError == 'ERROR_REGISTRATION_TIME_OUT' )
			 || ( AllLine[m].RegisterError == 'ERROR_ERROR_RESPONSE_RETURNED_BY_CORENET' ) )
		{
			OutputCodeReason[m] = SplitCodeReaRegTimeForOneUser[m][0];
		}
		else
		{
			OutputCodeReason[m] = '--';
		}		
	}
}



function stAuth(Domain, AuthUserName)
{
    this.Domain = Domain;
	if(AuthUserName != null)
    {
        this.AuthUserName = AuthUserName.toString().replace(/&apos;/g,"\'");
    }
    else
    {
        this.AuthUserName = AuthUserName;
    }
        
    var temp = Domain.split('.');
    this.key = '.' + temp[7] + '.';
}

var Auth = new Array();
for (var i = 0; i < AllAuth.length-1; i++) 
    Auth[i] = AllAuth[i];

var User = new Array();

function stUser(Domain, UserId)
{
    this.Domain = Domain;
    this.UserId = UserId;
}

for (var i = 0; i < AllLine.length - 1; i++)
{
    User[i] = new stUser();
    User[i].UserId = AllLine[i].DirectoryNumber;
}

function Reboot()
{
    if(ConfirmEx(sipstatus['vspa_restartalert'])) 
    {               
        var Form = new webSubmitForm();
        
        Form.addParameter('x.X_HW_Reset',1);   
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        
        Form.setAction('set.cgi?x=' + 'InternetGatewayDevice.Services.VoiceService.1'
                        + '&RequestFile=html/voip/status/voipmaintain.asp');
        setDisable('btnReboot',1);
        Form.submit();        
    }
}

function LoadFrame()
{
    if (curLoginUserType == "0")
    {
        setDisplay('resetButton',1);
    }
	else if (((CfgMode.toUpperCase() == 'ANTEL') || (CfgMode.toUpperCase() == 'ANTEL2')) && (curLoginUserType != "0"))
    {
        setDisplay('resetButton', 0);
    }
    else
    {
        setDisplay('resetButton',1);
    }
	
	if(CfgMode.toUpperCase().indexOf('PTVDF')>=0)
    {
	
        setDisplay('resetButton', 0);
    }
	
    if ((CfgMode.toUpperCase() == "RDSGATEWAY") && (curUserType != "0")) {
        setDisplay('resetButton', 0);
    }

	if ('BJUNICOM' == CfgMode.toUpperCase())
	{
		getElementByName('btnReboot').disabled = true;
	}
	
	if (('TELECOM' == CfgMode.toUpperCase())
		||('TELECOM2' == CfgMode.toUpperCase()))
	{
		getElementByName('btnReboot').disabled = true;
	}
		
	if ('BHARTI' == CfgMode.toUpperCase())
	{
		getElementByName('btnReboot').disabled = true;
	}
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = sipstatus[b.getAttribute("BindText")];
	}
} 

function ShowTab(index, URI, AuthUserName, PhyReferenceList, Status,CallState,RegisterError,ErrorCode)
{
	this.index = index;
	this.URI = URI;
	this.AuthUserName = AuthUserName;
	this.PhyReferenceList = PhyReferenceList;
	this.Status = Status;
	this.CallState = CallState;
	this.RegisterError = RegisterError;
	this.ErrorCode = ErrorCode;
}


</script>
</head>



<body class="mainbody" onLoad="LoadFrame();"> 
<script language="JavaScript" type="text/javascript">
if(CfgMode.toUpperCase().indexOf('PTVDF')>=0)
{
	HWCreatePageHeadInfo("VoipStatus", GetDescFormArrayById(sipstatus, "v01"), GetDescFormArrayById(sipstatus, "vspa_voipmaintain_title"), false);
}
else
{
	HWCreatePageHeadInfo("VoipStatus", GetDescFormArrayById(sipstatus, "v01"), GetDescFormArrayById(sipstatus, "v02"), false);
}
</script>


<div class="title_spread"></div>
<script language="JavaScript" type="text/JavaScript">
var i = 0;
var ShowableFlag = 1;
var ShowButtonFlag = 0;
var ColumnNum = 9;

var VoipArray = new Array();
var singtel_hide = false;
if((true == var_singtel)&&(curLoginUserType != '0'))
	{
		singtel_hide = true;
	}
	else
	{
		singtel_hide = false;
	}
var ConfiglistInfo = new Array(
	new stTableTileInfo("vspa_seq","align_center ","index",false),
	new stTableTileInfo("vspa_uri","uriclass align_center","URI",((CfgMode.toUpperCase().indexOf('PTVDF')>=0)||singtel_hide)),
	new stTableTileInfo("vspa_username","uriclass align_center","AuthUserName",false),
	new stTableTileInfo("vspa_assopots","align_center","PhyReferenceList",false),
	new stTableTileInfo("vspa_userstat","align_center","Status",false),
	new stTableTileInfo("vspa_callstat","align_center","CallState",false),
	new stTableTileInfo("vspa_regtime","align_center","RegTime",!(isUnicomFlag)),	
	new stTableTileInfo("vspa_errorstat","regnameclass align_left","RegisterError",false),
	new stTableTileInfo("vspa_regcodereason","align_center","ErrorCode",false),null);

if(AllLine.length - 1 == 0)
{
	var VoipShowTab = new ShowTab();
	VoipShowTab.index = "--";
	VoipShowTab.URI = "--";
	VoipShowTab.AuthUserName = "--";
	VoipShowTab.PhyReferenceList = "--";
	VoipShowTab.Status = "--"; 
	if(isUnicomFlag == true)
	{
		VoipShowTab.RegTime = "--";
	}
	VoipShowTab.CallState = "--"; 
	VoipShowTab.RegisterError = "--"; 
	VoipShowTab.ErrorCode = "--"; 
}

else
{
	for (i = 0; i < AllLine.length - 1; i++)
	{
		var VoipShowTab = new ShowTab();
		VoipShowTab.index = i + 1;
		
		if (CfgMode.toUpperCase().indexOf('PTVDF') < 0)
		{
			if ((AllLineURI[i].URI == "") || (IsTURKSGatewayUser() == true))
			{
				VoipShowTab.URI = "--";
			}
			else
			{
				VoipShowTab.URI = AllLineURI[i].URI;
			}
		}
		
		
		if (User[i].UserId == "")
		{
			 if( Auth[i].AuthUserName.indexOf(":") >= 0)
			 {
				var Authpart = Auth[i].AuthUserName.split(':');
				var k1 = Authpart[1];
				var k2 = k1.split('@');
				var k3 = k2[0];
				if ((k3 == "") || (IsTURKSGatewayUser() == true))
				{   
					VoipShowTab.AuthUserName = "--";
				}
				else
				{    
					VoipShowTab.AuthUserName = k3;
				}
			 }
			 else
			 {
				 var Authpart = Auth[i].AuthUserName.split('@');
				 var k = Authpart[0];
				if ((k == "") || (IsTURKSGatewayUser() == true))
				{    
					VoipShowTab.AuthUserName = "--";
				}
				else
				{   
					VoipShowTab.AuthUserName = k; 
				}
			 }
		}
		else
		{
			 if( User[i].UserId.indexOf(":") >= 0)
			 {
				 var UserId = User[i].UserId.split(':');
				 var k1 = UserId[1];
				var k2 = k1.split('@');
				var k3 = k2[0];
				if ((k3 == "") || (IsTURKSGatewayUser() == true))
				{    
					VoipShowTab.AuthUserName = "--";
				}
				else
				{    
					VoipShowTab.AuthUserName = k3;
				}
			 }
			 else
			 {
				 var UserId = User[i].UserId.split('@');
				 var k = UserId[0];
				if ((k == "") || (IsTURKSGatewayUser() == true))
				{ 
					VoipShowTab.AuthUserName = "--";   
				}
				else
				{    
					VoipShowTab.AuthUserName = k; 
				}
			 }
		}   
		
		if (AllLine[i].PhyReferenceList == "")
		{    
			VoipShowTab.PhyReferenceList = "--";
		}
		else
		{    
			VoipShowTab.PhyReferenceList = AllLine[i].PhyReferenceList;
		}
		
 		if ( AllLine[i].Status == 'Up' )
		{
			VoipShowTab.Status = sipstatus['vspa_status_succ'];
		}
		else if ( AllLine[i].Status == 'Initializing' )
		{    
			VoipShowTab.Status = sipstatus['vspa_status_ini'];
		}
		else if ( AllLine[i].Status == 'Registering' )
		{    
			VoipShowTab.Status = sipstatus['vspa_status_reg'];
		}
		else if ( AllLine[i].Status == 'Unregistering' )
		{  
	    	VoipShowTab.Status = sipstatus['vspa_status_unreg'];
		}
		else if ( AllLine[i].Status == 'Quiescent' )
		{    
			VoipShowTab.Status = sipstatus['vspa_status_qui'];
		}
		else if ( AllLine[i].Status == 'Disabled' )
		{
			VoipShowTab.Status = sipstatus['vspa_status_disa'];    
		}
		else if ( AllLine[i].Status == 'Error' )
		{
			VoipShowTab.Status = sipstatus['vspa_status_err'];    
		}
		else if ( AllLine[i].Status == 'Testing' )
		{
			VoipShowTab.Status = sipstatus['vspa_status_test'];    
		}
		else
		{
			VoipShowTab.Status = "--";  
		}
	
		if(isUnicomFlag == true)
		{
			VoipShowTab.RegTime =  htmlencode(OutputRegTime[i]);
		}
		
		
		if ( AllLine[i].CallState == 'Idle' )
		{
			VoipShowTab.CallState = sipstatus['vspa_callstat_idle']; 
		}
		else if ( AllLine[i].CallState == 'Calling' )
		{
			VoipShowTab.CallState = sipstatus['vspa_callstat_cal']; 
		}
		else if ( AllLine[i].CallState == 'Ringing' )
		{
			VoipShowTab.CallState = sipstatus['vspa_callstat_ring'];
		}
		else if ( AllLine[i].CallState == 'Connecting' )
		{
			VoipShowTab.CallState = sipstatus['vspa_callstat_con']; 
		}
		else if ( AllLine[i].CallState == 'InCall' )
		{
			VoipShowTab.CallState = sipstatus['vspa_callstat_incall']; 
		}
		else if ( AllLine[i].CallState == 'Hold' )
		{
			VoipShowTab.CallState = sipstatus['vspa_callstat_hold'];    
		}
		else if ( AllLine[i].CallState == 'Disconnecting' )
		{
			VoipShowTab.CallState = sipstatus['vspa_callstat_dis'];    
		}
		else
		{
			VoipShowTab.CallState = "--";    
		}		

		if ( AllLine[i].RegisterError == '-' )
		{
			VoipShowTab.RegisterError = "--";    
		}
		else if ( AllLine[i].RegisterError == 'ERROR_ONU_OFFLINE' )
		{
			if (true == var_singtel)
			{
				VoipShowTab.RegisterError = sipstatus['vspa_errorstate_onroffine'];
			}
			else
			{
				VoipShowTab.RegisterError = sipstatus['vspa_errorstate_onuoffine'];
			}
		}
		else if ( AllLine[i].RegisterError == 'ERROR_WAN_NOT_CONFIGURED' )
		{
			VoipShowTab.RegisterError = sipstatus['vspa_errorstate_wannotconfigured'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_WAN_IP_NOT_OBTAINED' )
		{
			VoipShowTab.RegisterError = sipstatus['vspa_errorstate_wannotobtained'];
			
		}
		else if ( AllLine[i].RegisterError == 'ERROR_CORENET_ADDRESS_INCORRECT' )
		{
			VoipShowTab.RegisterError = sipstatus['vspa_errorstate_mgcincorrect'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_VOICESERVICE_DISABLED' )
		{
			VoipShowTab.RegisterError = sipstatus['vspa_errorstate_voicedisabled'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_USER_NOT_CONFIGURED' )
		{
			VoipShowTab.RegisterError = sipstatus['vspa_errorstate_usernotconfigured'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_USER_NOT_BOUND_TO_POTS' )
		{
			VoipShowTab.RegisterError = sipstatus['vspa_errorstate_usernotboundport'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_POTS_DISABLED_BY_OLT' )
		{
			VoipShowTab.RegisterError = sipstatus['vspa_errorstate_portdisabledOLT'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_USER_DISABLED' )
		{
			VoipShowTab.RegisterError = sipstatus['vspa_errorstate_userdisable'];
		}
        else if ( AllLine[i].RegisterError == 'ERROR_USER_CONFLICT' )
		{
			VoipShowTab.RegisterError = sipstatus['vspa_errorstate_userconflict'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_REGISTRATION_AUTH_FAIL' )
		{
			VoipShowTab.RegisterError = sipstatus['vspa_errorstate_regauthfails'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_REGISTRATION_TIME_OUT' )
		{
			VoipShowTab.RegisterError = sipstatus['vspa_errorstate_regtimesout'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_ERROR_RESPONSE_RETURNED_BY_CORENET' )
		{
			VoipShowTab.RegisterError = sipstatus['vspa_errorstate_mgcerrorresponse'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_DOMAIN_CHECKFAIL' )
		{
			VoipShowTab.RegisterError = sipstatus['vspa_errorstate_domainerror'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_POTS_FAIL' )
		{
			VoipShowTab.RegisterError = sipstatus['vspa_errorstate_potsfail'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_SLIC_DOWN' )
		{
			VoipShowTab.RegisterError = sipstatus['vspa_errorstate_slicdown'];
		}
		else if ( AllLine[i].RegisterError == 'ERROR_UNKNOWN' )
		{
			VoipShowTab.RegisterError = sipstatus['vspa_errorstate_unknownerror'];
		}
		else
		{
			VoipShowTab.RegisterError = "--";
		}
		
		VoipShowTab.ErrorCode = htmlencode(OutputCodeReason[i]);		
		VoipArray.push(VoipShowTab);
	}
}
VoipArray.push(null);
HWShowTableListByType(ShowableFlag, "tdVoipInfo", ShowButtonFlag, ColumnNum, VoipArray, ConfiglistInfo, sipstatus, null);

if (CfgWord == "OTE") {
    document.write('<p id="additionalNumber"></p>');
    setControl();
}
</script>

<div id="resetButton">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr ><td class="height5p"></td></tr>
</table>
<table width="100%" height="35" cellpadding="0" cellspacing="0" class="" >      
 <tr>
    <td  class="table_right" class="align_left">
    <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
    <script type="text/javascript">
        if (CfgMode == "DICELANDVDF") {
            document.write('<input name="btnReboot" id="btnReboot" type="button" class="ApplyButtoncss buttonwidth_150px_250px" value="Restart VoIP" onClick="Reboot();"/> ')
        } else {
            document.write('<input name="btnReboot" id="btnReboot" type="button" class="CancleButtonCss buttonwidth_150px_250px" value="Restart VoIP" onClick="Reboot();"/> ')
        }
        document.getElementsByName('btnReboot')[0].value = sipstatus['vspa_restartvoip'];
    </script>
    </td>
</tr>
</table>
<table width="100%" height="5" cellpadding="0" cellspacing="0" class="" >  
<tr>
</tr>
</table>
    </div> 
       
</form>
</td></tr>
</table>
</body>
</html>
