<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta name="format-detection" content="telephone=no"/>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<title>VOIP Interface</title>
<script language="javascript" src="../../bbsp/common/managemode.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list_info.asp"></script>
<script language="javascript" src="../../bbsp/common/wan_list.asp"></script>
<style>
.interfacetextclass{
	width:300px;
	height:50px;
}

.TextBox
{
width:155px;
}

.lineclass
{
width:200px;
}


.wordclass
{
word-wrap:break-all;
word-break: break-all;
}


</style>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, sipinterface);%>"></script>
<script language="JavaScript" type="text/javascript"> 
var PortNum = '<%HW_WEB_GetPortNum();%>';
var vagLastInst = '<%HW_WEB_GetVoiceVagIndex();%>'

var vagIndex = 0;

var selctIndex = -1;

function stLine(Domain, DirectoryNumber, Enable,PhyReferenceList )
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
	
	if (Enable.toLowerCase() == 'enabled')
    {
        this.Enable = 1;
    }
    else
    {
        this.Enable = 0;
    }     
	
    this.PhyReferenceList = PhyReferenceList;
}

var AllLine = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i},DirectoryNumber|Enable|PhyReferenceList,stLine);%>;

function stAuth(Domain, AuthUserName, AuthPassword)
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
	
    this.AuthPassword = AuthPassword;

    var temp = Domain.split('.');
    this.key = '.' + temp[7] + '.';
}

var AllAuth = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.SIP,AuthUserName|AuthPassword,stAuth);%>;

function DropDownLineListSelect(id, ArrayOption)
{
    var Control = getElById(id);
    var i = 1;  
	
	var Option = document.createElement("Option");
        Option.value = "";
        Option.innerText = "";
		Option.text = "";
        Control.appendChild(Option);

	var PotsNum = parseInt(PortNum,10);
	
	for (i = 1; i <= PotsNum; i++)
    {
        var Option = document.createElement("Option");
        Option.value = i;
        Option.innerText = i;
		Option.text = i;
        Control.appendChild(Option);
    }
}

function initCtlValue()
{
    setText('DirectoryNumber','');
    setText('AuthUserName','');
    setText('AuthPassword','');
    setSelect('PhyReferenceList', '');
}

function vspaisValidCfgStr(cfgName, val, len)
{
    if (isValidAscii(val) != '')         
    {  
        AlertEx(cfgName + sipinterface['vspa_hasvalidch'] + isValidAscii(val) + sipinterface['vspa_end']);          
        return false;       
    }
    if (val.length > len)
    {
        AlertEx(cfgName + sipinterface['vspa_cantexceed']  + len  + sipinterface['vspa_characters']);
        return false;
    }        
}

function CheckParaForm()
{
     if ( '' != removeSpaceTrim(getValue('DirectoryNumber')))
     {
         if (vspaisValidCfgStr(sipinterface['vspa_theregister'],getValue('DirectoryNumber'),64) == false)
         {
             return false;
         }   
     }
	 
     if ( '' != removeSpaceTrim(getValue('AuthUserName')))
     {
         if (vspaisValidCfgStr(sipinterface['vspa_theauthname'],getValue('AuthUserName'),64) == false)
         {
             return false;
         }
     }
     
     if ( '' != removeSpaceTrim(getValue('AuthPassword')))
     {        
    
         if (vspaisValidCfgStr(sipinterface['vspa_thepassword'],getValue('AuthPassword'),64) == false)
         {
             return false;
         }
     } 
	 
	 if((selctIndex < 0) || (getValue('PhyReferenceList') != LineList[vagIndex][selctIndex].PhyReferenceList) || (getCheckVal('Enable') != LineList[vagIndex][selctIndex].Enable))
     {
	
         for (var i = 0; i < LineList[vagIndex].length; i++)
         {
            if (selctIndex != i)
            {
                if ((getValue('PhyReferenceList') != "") && (getValue('PhyReferenceList') == LineList[vagIndex][i].PhyReferenceList) )
                {
                    if((getCheckVal('Enable') == 1) && (LineList[vagIndex][i].Enable == 1))
                    { 
                        var ulret = ConfirmEx(sipinterface['vspa_pots']+getValue('PhyReferenceList')+sipinterface['vspa_potsassohint']);
                        return ulret;
                    }
                }
            }    
         }
     }
          
     if (getValue('PhyReferenceList') != "")
     {
         for (var i = 0; i < LineList.length; i++)
         {
             if(vagIndex != i)
             {
                 for (var j = 0; j < LineList[i].length; j++)
                 {
                     if(getValue('PhyReferenceList') == LineList[i][j].PhyReferenceList)
                     {
                         AlertEx(sipinterface['vspa_vagsportexsit']);
                         return false;
                     }
                 }
             }
         }
     }
	 
	 return true;
}

function SubmitBasicPara()
{
    if (true  != CheckParaForm())
    {
        return false;
    }
    
	var Form = new webSubmitForm();
		
	var ActionURL;
	var strvar = getValue('AuthPassword');
	
	Form.addParameter('c.AuthUserName',getValue('AuthUserName'));
	
	if (strvar != '****************************************************************')
    {
        Form.addParameter('c.AuthPassword',getValue('AuthPassword'));   
    }
	
	Form.addParameter('Add_b.DirectoryNumber',getValue('DirectoryNumber'));
    Form.addParameter('Add_b.PhyReferenceList',getValue('PhyReferenceList'));
	
	if (getCheckVal('Enable') == 1)
	{
		Form.addParameter('Add_b.Enable','Enabled');
	}
	else
	{
		Form.addParameter('Add_b.Enable','Disabled');
	}
	
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	ActionURL = 'set.cgi?'
		+ '&c=' + LineList[vagIndex][selctIndex].Domain + '.SIP'
		+ '&Add_b=' + LineList[vagIndex][selctIndex].Domain
		+ '&RequestFile=html/voip/voipinterface/sipvoipglobe.asp';
	
	Form.setAction(ActionURL); 
	Form.submit();
	
	setDisable('btnApplyVoipUser', 1);
	setDisable('cancelValue', 1);
}

function CancelUserConfig(selctIndex)
{
    LoadFrame();
    selectLine('record_'+selctIndex);
}


function ShowTab(index, TelNo, AuthUserName, Password,PhyReferenceList)
{
	this.index = index;
	this.TelNo = TelNo;
	this.AuthUserName = AuthUserName;
	this.Password = Password;
	this.PhyReferenceList = PhyReferenceList;
}

function stProfile(Domain, X_HW_PortName)
{
    this.Domain = Domain;
    this.X_HW_PortName = X_HW_PortName;
    var temp = Domain.split('.');
    this.key = '.' + temp[5] + '.';
    this.profileid = temp[5];
}

var LineList = new Array(new Array(),new Array(),new Array(),new Array());
var AllLineInsNumArray = new Array(new Array(),new Array(),new Array(),new Array());

var AllProfile = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i},X_HW_PortName,stProfile);%>;
for(var j = 0; j < 4; j++)
{
	for(var i = 0; i < 68; i++)
	{
		AllLineInsNumArray[j][i]=256;
		
	}
}

vagIndex = GetVagIndexByInst(vagLastInst);

for (var i = 0; i < AllLine.length-1; i++)
{
    var temp = AllLine[i].Domain.split('.');
    var Vagindex = GetVagIndexByInst(temp[5]);
    LineList[Vagindex].push(AllLine[i]);
	index = temp[7];
	AllLineInsNumArray[Vagindex][index - 1] = index;
}

function GetVagIndexByInst(vagInst)
{
    for(var i = 0; i < AllProfile.length-1; i++)
    {
        if(AllProfile[i].profileid == vagInst)
        {
            return i;
        }
    }
    
    return 0;
}

function stAuth(Domain, AuthUserName, AuthPassword)
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
	
    this.AuthPassword = AuthPassword;

    var temp = Domain.split('.');
    this.key = '.' + temp[7] + '.';
}

var AllAuth = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.SIP,AuthUserName|AuthPassword,stAuth);%>;
var AuthList = new Array(new Array(),new Array(),new Array(),new Array());
for (var i = 0; i < AllAuth.length-1; i++)
{
    var temp = AllAuth[i].Domain.split('.');
    var index = GetVagIndexByInst(temp[5]);
    AuthList[index].push(AllAuth[i]);
}

function GetVAGPara(vagInsId)
{

	var VoipArray = new Array();
		
	if(LineList[vagInsId].length == 0)
	{
		var VoipShowTab = new ShowTab();
		VoipShowTab.index = "--";
		VoipShowTab.TelNo = "--";
		VoipShowTab.AuthUserName = "--";
		VoipShowTab.Password = "--";
		VoipShowTab.PhyReferenceList = "--";
	}
	else
	{
		
		for (var i = 0; i < LineList[vagInsId].length; i++)
		{	
			var VoipShowTab = new ShowTab();
			
			VoipShowTab.domain = LineList[vagInsId][i].Domain;
			
			VoipShowTab.index = i+1;
			
			if (LineList[vagInsId][i].DirectoryNumber == "")
			{
				VoipShowTab.TelNo = "--";
			}
			else
			{
				VoipShowTab.TelNo = LineList[vagInsId][i].DirectoryNumber;
			}

			if (AuthList[vagInsId][i].AuthUserName == "")
			{
				VoipShowTab.AuthUserName = "--";
			}
			else
			{
				VoipShowTab.AuthUserName = AuthList[vagInsId][i].AuthUserName;
			} 
			
			VoipShowTab.Password = "*******";                 
			if (LineList[vagInsId][i].PhyReferenceList == "")
			{
				VoipShowTab.PhyReferenceList = "--";
			}
			else
			{
				VoipShowTab.PhyReferenceList = LineList[vagInsId][i].PhyReferenceList;
			}
			VoipArray.push(VoipShowTab);
		}
	}
	
	VoipArray.push(null);
	return VoipArray;
}

function stPhyInterface(Domain, InterfaceID )
{
    this.Domain = Domain;
}

var AllPhyInterface = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.PhyInterface.{i},InterfaceID,stPhyInterface);%>;


var g_Index = -1;

function setCtlDisplay(LineRecord, AuthRecord)
{
    setText('DirectoryNumber',LineRecord.DirectoryNumber);
    setText('AuthUserName',AuthRecord.AuthUserName);
    setText('AuthPassword',AuthRecord.AuthPassword);
    setSelect('PhyReferenceList', LineRecord.PhyReferenceList);
	setCheck('Enable', LineRecord.Enable);
}

function setControl(index)
{
    var record;
    selctIndex = index;
    if (index == -1)
    {   
        if(LineList[vagIndex].length >= ((AllPhyInterface.length - 1) * 17))
        {
            setDisplay('ConfigForm1', 0);
            AlertEx(sipinterface['vspa_toomanyuser']);
            return false;
        }   
        
        var LineRecord = new stLine("","","Disabled","");
        var AuthRecord = new stAuth("","","","");
        setDisplay('ConfigForm1', 1);
        setCtlDisplay(LineRecord, AuthRecord);
    }
    else if (index == -2)
    {
        setDisplay('ConfigForm1', 0);
    }
    else
    {
        record = LineList[vagIndex][index];
        var LineRecord = LineList[vagIndex][index];
        var AuthRecord = AuthList[vagIndex][index];
        setDisplay('ConfigForm1', 1);
        setCtlDisplay(LineRecord, AuthRecord);
    }
    g_Index = index;
}
function LoadFrame()
{
	initCtlValue();
	if(AllLine.length <= 1)
	{
		setDisable('DirectoryNumber',1);
		setDisable('AuthUserName',1);
		setDisable('AuthPassword',1);
		setDisable('PhyReferenceList', 1);
		setDisable('btnApplyVoipUser', 1);
		setDisable('cancelValue', 1);
	}
	else
	{
		selectLine('linelist0_record_0');
		setControl(0);
	}	
}
</script>
</head>
<body class="mainbody" onLoad="LoadFrame();">  
<script language="JavaScript" type="text/javascript">
HWCreatePageHeadInfo("VoipInterface", GetDescFormArrayById(sipinterface, "v01"), GetDescFormArrayById(sipinterface, "v02"), false);
</script>

<script language="JavaScript" type="text/javascript">
var ColumnNum = 5;
var ConfiglistInfo = new Array(new stTableTileInfo("vspa_seq","align_center","index",false),
							new stTableTileInfo("vspa_regusername","wordclass align_center","TelNo",false),
							new stTableTileInfo("vspa_authusername","wordclass align_center","AuthUserName",false),
							new stTableTileInfo("vspa_password","align_center","Password",false),
							new stTableTileInfo("vspa_assopot","align_center","PhyReferenceList",false),null);
var maxvagnum = AllProfile.length-1;

for(var index = 0 ; index < maxvagnum; index++)
{
	var tableid = "linelist"+index;
	VoipArray = GetVAGPara(index);
	HWShowTableListByType(1, tableid, 0, ColumnNum, VoipArray, ConfiglistInfo, sipinterface, null);
}
</script>

<form id="ConfigForm1">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="tabal_noborder_bg">
<li id="Enable" RealType="CheckBox" DescRef="vspa_enableuser" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="Enable" InitValue="Empty"/>
<li id="DirectoryNumber" RealType="TextBox" DescRef="vspa_regname" RemarkRef="vspa_telno" ErrorMsgRef="Empty" Require="FALSE" BindField="DirectoryNumber" InitValue="Empty" Elementclass="lineclass"/>
<li id="PhyReferenceList" RealType="DropDownList" DescRef="vspa_asspot" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="PhyReferenceList" InitValue="Empty"/>
<li id="AuthUserName" RealType="TextBox" DescRef="vspa_authname" RemarkRef="vspa_authnamehint" ErrorMsgRef="Empty" Require="FALSE" BindField="AuthUserName" InitValue="Empty" Elementclass="lineclass"/>
<li id="AuthPassword" RealType="TextBox" DescRef="vspa_paasw" RemarkRef="vspa_passwdhint" ErrorMsgRef="Empty" Require="FALSE" BindField="AuthPassword" InitValue="Empty" Elementclass="lineclass"/>
<script>
var TableClass = new stTableClass("width_per30", "width_per70", "ltr");
var VoipConfigFormList2 = HWGetLiIdListByForm("ConfigForm1", null);
HWParsePageControlByID("ConfigForm1", TableClass, sipinterface, null);
DropDownLineListSelect("PhyReferenceList",AllPhyInterface);
</script>
</table>
</form>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
<tr >
<td class="table_submit width_per25"></td>
<td class="table_submit"> 
<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
<input name="btnApplyVoipUser" id="btnApplyVoipUser" type="button" class="ApplyButtoncss buttonwidth_100px" value="Apply" onClick="SubmitBasicPara();"/>
<script type="text/javascript">
document.getElementsByName('btnApplyVoipUser')[0].value = sipinterface['vspa_apply'];    
</script>
<input name="cancelValue" id="cancelValue" type="button" class="CancleButtonCss buttonwidth_100px" value="Cancel" onClick="CancelUserConfig(selctIndex);"/>
<script>
document.getElementsByName('cancelValue')[0].value = sipinterface['vspa_cancel'];
</script>

</td>
</tr>
</table>
<br></br>

</body>
</html>
