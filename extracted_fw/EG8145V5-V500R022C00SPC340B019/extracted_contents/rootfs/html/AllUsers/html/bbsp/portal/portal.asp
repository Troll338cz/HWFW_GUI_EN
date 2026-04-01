<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<style type="text/css">
.inputclass
{
   width:300px;
}

.inputclass1
{
   width:214px;
}

</style>
<title>portal</title>
</head>
<body  onLoad="loadlanguage();" class="mainbody"> 
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("portaltitle", GetDescFormArrayById(portal_language, "bbsp_mune"), GetDescFormArrayById(portal_language, "bbsp_portal_title"), false);
</script> 
<div class="title_spread"></div>

<form id="PortalCfg" style="display:block;">
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
		<li   id="EnableControl"     RealType="CheckBox"     DescRef="bbsp_enableportalmh"       RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"    BindField="x.Enable"   InitValue="Empty"   ClickFuncApp="onclick=OnEnablePortal"/>
		<li   id="DefaultUrlControl"           RealType="TextBox"      DescRef="bbsp_defurlmh"             RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.DefaultUrl"  Elementclass="inputclass"  InitValue="Empty"  Maxlength="256"/>
	</table>
	<script>
		var TableClass = new stTableClass("per_20_25", "", "ltr");
		HWParsePageControlByID("PortalCfg", TableClass, portal_language, null);
		getElById('EnableControl').title = portal_language['bbsp_portaltitle'];
		getElById('DefaultUrlControl').title = portal_language['bbsp_defurltitle'];
	</script>
	<table id="OperatorPanel" class="table_button" style="width: 100%" cellpadding="0"> 
	  <tr> 
		<td class="table_submit per_20_25"></td> 
		<td class="table_submit align_left"> 
			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
			<button id='Apply' type=button onclick = "javascript:return OnDefaultUrlApply();" class="ApplyButtoncss buttonwidth_100px"> <script>document.write(portal_language['bbsp_app']);</script></button> 
			<button id='Cancel' type=button onclick = "javascript:return OnDefaultUrlCancel();" class="CancleButtonCss buttonwidth_100px"> <script>document.write(portal_language['bbsp_cancel']);</script></button> 
		</td> 
	  </tr> 
	</table> 
</form>
<script language="javascript">
var selectIndex = -1;
var TableName = "PortalConfigList";
var ProductType = '<%HW_WEB_GetProductType();%>';
function loadlanguage()
{
	var all = document.getElementsByTagName("td");
	for (var i = 0; i <all.length ; i++) 
	{
		var b = all[i];
		if(b.getAttribute("BindText") == null)
		{
			continue;
		}
		b.innerHTML = portal_language[b.getAttribute("BindText")];
	}
}
    
function UIObserver()
{
    this.Update = function(_PortalInfo)
    {
        getElById("EnableControl").checked = _PortalInfo.Enable == 1 ? true : false;
        setText("DefaultUrlControl",_PortalInfo.DefaultUrl);
    }
}

function BasicInfo(_Domain, _Enable, _DefaultUrl)
{
	this.Domain = _Domain;
	this.Enable = _Enable;
	this.DefaultUrl = _DefaultUrl;
}

function UrlInfo(_Domain, _DeviceName, _Url)
{
    this.Domain = _Domain;
    this.DeviceName = _DeviceName;
    this.Url = _Url;
    this.Exist = 1;
}
function PortalInfo(_Enable, _DefaultUrl, _UrlInfoList)
{
    this.Enable = _Enable;
    this.DefaultUrl = _DefaultUrl;
    this.UrlInfoList = _UrlInfoList;
    this.Observer = new Array();

    this.AddObserver = function(Observer)
    {
        this.Observer.push(Observer);
    }    

    this.NodifyObserver = function()
    {
        var i = 0;
        for (i = 0; i < this.Observer.length; i++)
        {
            if (null == this.Observer[i])
            {
                continue;
            }
            
            this.Observer[i].Update(this);
        }
    }

    this.SetEnabel = function(_Enable)
    {
        this.Enable = _Enable;
        this.NodifyObserver();
    }
}

var DeviceList = new Array("Computer", "Phone", "STB");
var BasicInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_PortalManagement,Enable|DefaultUrl,BasicInfo);%>;
var i;
var Enable = BasicInfo[0].Enable;
var DefaultUrl = BasicInfo[0].DefaultUrl;
var TempUrlInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.X_HW_PortalManagement.TypePortal.{i},DeviceTypeName|PortalUrl,UrlInfo);%>;

var UrlInfoList = new Array();
for (i = 0; i < TempUrlInfoList.length; i++)
{
    if (TempUrlInfoList[i] == null)
    {
        continue;
    }

    UrlInfoList[i] = TempUrlInfoList[i];
}

var Data = new PortalInfo(Enable, DefaultUrl, UrlInfoList);


Data.AddObserver(new UIObserver());
Data.NodifyObserver();

function OnEnablePortal(EnableControl)
{
    var Enable = EnableControl.checked == true ? 1 : 0;
    Data.SetEnabel(Enable);

    var Form = new webSubmitForm();
    Form.addParameter('x.Enable',Enable);
	Form.addParameter('x.X_HW_Token', getValue('onttoken')); 	
	Form.setAction('set.cgi?' +'x=InternetGatewayDevice.Services.X_HW_PortalManagement' + '&RequestFile=html/bbsp/portal/portal.asp');
	Form.submit();
	DisableRepeatSubmit();
}

function OnDefaultUrlApply()
{
    var DefaultUrl = getElById("DefaultUrlControl").value;
	if (ProductType  == '2')
	{
		if (DefaultUrl.length != 0)
		{
			if (isValidAscii(DefaultUrl) != '')         
			{  
				AlertEx(urlfiltersetting_language['bbsp_urladdr'] + Languages['Hasvalidch'] + isValidAscii(DefaultUrl) + '".');          
				return false;       
			}

			if((CheckUrlParameter(DefaultUrl) == false) || (IsUrlValid(DefaultUrl) == false))
			{
				AlertEx(portal_language['bbsp_urlinvalid']);
				return false;
			}
		}
	}
	
    if (DefaultUrl.toLowerCase() == Data.DefaultUrl.toLowerCase())
    {
        return false;
    }
   
    var Form = new webSubmitForm();
    Form.addParameter('x.DefaultUrl',DefaultUrl);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
	Form.setAction('set.cgi?' +'x=InternetGatewayDevice.Services.X_HW_PortalManagement' + '&RequestFile=html/bbsp/portal/portal.asp');
	Form.submit();
	DisableRepeatSubmit();
}

function OnDefaultUrlCancel()
{
    setText("DefaultUrlControl",Data.DefaultUrl);
}

function IsDeviceTypeNormal(Value)
{
	var i;
	
	for (i = 0; i < DeviceList.length; i++)
	{
		if (Value == DeviceList[i])
		{
			return true;
		}
	}  
	return false;
}

function InitTableData()
{
	var ColumnNum = 3;
	var ShowButtonFlag = true;
	var TableDataInfo = new Array();
	var Listlen = 0;
	
	if (Data.UrlInfoList.length == 0)
    {
		TableDataInfo[Listlen] = new UrlInfo();
		TableDataInfo[Listlen].domain = '--';
		TableDataInfo[Listlen].devtype = '--';
		TableDataInfo[Listlen].redurl = '--';
		HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, PortalConfiglistInfo, portal_language, null);
        return;
    }
    else
    {
        for (var i = 0; i < Data.UrlInfoList.length; i++)
        {
			TableDataInfo[Listlen] = new UrlInfo();
			TableDataInfo[Listlen].domain = Data.UrlInfoList[i].Domain;
			if (IsDeviceTypeNormal(Data.UrlInfoList[i].DeviceName) == false)
			{
				TableDataInfo[Listlen].devtype = Data.UrlInfoList[i].DeviceName;
			}
			else
			{
				TableDataInfo[Listlen].devtype = portal_language[Data.UrlInfoList[i].DeviceName];
			}
        	TableDataInfo[Listlen].redurl = Data.UrlInfoList[i].Url;
			Listlen++;
        }
		TableDataInfo.push(null);
		HWShowTableListByType(1, TableName, ShowButtonFlag, ColumnNum, TableDataInfo, PortalConfiglistInfo, portal_language, null);
    }
}
</script> 
<div class="func_spread"></div>

<script language="JavaScript" type="text/javascript">
	var TableClass = new stTableClass("per_25_35", "", "ltr");
	var PortalConfiglistInfo = new Array(new stTableTileInfo("Empty","","DomainBox"),
										new stTableTileInfo("bbsp_devtype","","devtype",false,20),
										new stTableTileInfo("bbsp_redurl","","redurl",false,50),null);
	InitTableData();
</script>

  <script language="JavaScript" type="text/javascript">
    var OperatorFlag = 0;
    var OperatorIndex = 0;

    function OnNewInstance(index)
    {
       OperatorFlag = 1;
       
       document.getElementById("ChooseDeviceType").disabled = false;
       document.getElementById("UrlAddressControl").value = "";
       setDisable("DeviceNameControl", 0);
       InitDeviceTypeComlexControl("Computer");

       document.getElementById("TableUrlInfo").style.display = "block";
    }
	
    function OnAddNewSubmit()
    {
        var DeviceName = getElById("DeviceNameControl").value;
        var Url = getElById("UrlAddressControl").value;
        
        var i;
        for (i = 0; i < Data.UrlInfoList.length; i++)
        {
            if (Data.UrlInfoList[i].DeviceName == DeviceName)
            {
                AlertEx(getElById("DeviceNameControl").ErrorMsg);
                return false;
            }
        }

	    if (DeviceName.length == 0)
	    {
			AlertEx(portal_language['bbsp_devtypeisreq']);
			return false;	
	    }
		if (ProductType  == '2')
		{
			if (isValidAscii(Url) != '')         
			{  
				AlertEx(urlfiltersetting_language['bbsp_urladdr'] + Languages['Hasvalidch'] + isValidAscii(Url) + '".');          
				return false;       
			}

			if((CheckUrlParameter(Url) == false) || (IsUrlValid(Url) == false))
			{
				AlertEx(portal_language['bbsp_urlinvalid']);
	            return false;
			}		
		}
		
        var Form = new webSubmitForm();
	    Form.addParameter('x.DeviceTypeName',DeviceName);
	    Form.addParameter('x.PortalUrl',Url);
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
	    Form.setAction('add.cgi?' +'x=InternetGatewayDevice.Services.X_HW_PortalManagement.TypePortal' + '&RequestFile=html/bbsp/portal/portal.asp');
	    Form.submit();
		DisableRepeatSubmit();
    }

    function ModifyInstance(index)
    {
        OperatorFlag = 2;
        var InstanceId = Data.UrlInfoList[index].Domain;
        var DeviceName = Data.UrlInfoList[index].DeviceName;
        var Url = Data.UrlInfoList[index].Url;

        getElById("DeviceNameControl").disabled = true;
        getElById("ChooseDeviceType").disabled = true;
        getElById("TableUrlInfo").style.display = "block";
        setText("UrlAddressControl",Url);
        InitDeviceTypeComlexControl(DeviceName);

    } 
    function OnModifySubmit()
    {
        var DeviceName = getElById("DeviceNameControl").value;
        var Url = getElById("UrlAddressControl").value;
		if (ProductType == '2')
		{
			if (isValidAscii(Url) != '')         
			{  
				AlertEx(urlfiltersetting_language['bbsp_urladdr'] + Languages['Hasvalidch'] + isValidAscii(Url) + '".');          
				return false;       
			}

			if((CheckUrlParameter(Url) == false) || (IsUrlValid(Url) == false))
			{
				AlertEx(portal_language['bbsp_urlinvalid']);
	            return false;
			}		
		}

        var Form = new webSubmitForm();
	    Form.addParameter('x.PortalUrl',Url);
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
	    Form.setAction('set.cgi?' +'x='+ Data.UrlInfoList[OperatorIndex].Domain + '&RequestFile=html/bbsp/portal/portal.asp');
	    Form.submit();
        DisableRepeatSubmit();
    }

    function setControl(index)
    { 
    	selectIndex = index;
    	if (index < -1)
    	{
			return;
		}

        OperatorIndex = index;   
    
        if (-1 == index)
        {
            if (Data.UrlInfoList.length == 3)
			{
				AlertEx(portal_language['bbsp_urlfull']);
				getElById('TableUrlInfo').style.display='none';
			  
				var tableRow = getElementById(TableName);
				tableRow.deleteRow(tableRow.rows.length-1)
		
				return false;
            }
            return OnNewInstance(index);
        }
        else
        {
            return ModifyInstance(index);
        }
    }

	function PortalConfigListselectRemoveCnt(val)
	{
	
	}
	
	function OnDeleteButtonClick(TableID)
    {
        var CheckBoxList = document.getElementsByName(TableName + 'rml');
        var Count = 0;
        var i;
        for (i = 0; i < CheckBoxList.length; i++)
        {
            if (CheckBoxList[i].checked == true)
            {
                Count++;
            }
        }

        if (Count == 0)
        {
            AlertEx(portal_language['bbsp_selecturl']);
            return false;
        }

        var Form = new webSubmitForm();
        for (i = 0; i < CheckBoxList.length; i++)
        {
            if (CheckBoxList[i].checked != true)
            {
                continue;
            }

            Form.addParameter(CheckBoxList[i].value,'');
        }
		Form.addParameter('x.X_HW_Token', getValue('onttoken')); 
	    Form.setAction('del.cgi?' +'x=InternetGatewayDevice.Services.X_HW_PortalManagement.TypePortal' + '&RequestFile=html/bbsp/portal/portal.asp');
	    Form.submit();
    }
  
    function OnApply()
    {
        if (OperatorFlag == 1)
        {
            return OnAddNewSubmit();
        }
        else
        {
            return OnModifySubmit();
        }
    }

    function OnItemCancel()
    {
        getElById('TableUrlInfo').style.display='none';
        
        var tableRow = getElementById(TableName);
        if (tableRow.rows.length <=2)
        {
            return false;
        }
        if (selectIndex == -1)
        {
            tableRow.deleteRow(tableRow.rows.length-1)
        }
    }
  
   function InitDeviceTypeComlexControl(Value)
   {
        setSelect("ChooseDeviceType", Value);
        setText("DeviceNameControl", Value);
        setDisplay("DeviceNameControl",0);
        if (IsDeviceTypeNormal(Value) == false)
        {   
            if (Value == "Other")
            {
               setText("DeviceNameControl", ""); 
            }
            setSelect("ChooseDeviceType", "Other");
            setDisplay("DeviceNameControl",1);
        }
   }  

   function OnChooseDeviceType(Select)
   {
        InitDeviceTypeComlexControl(getSelectVal(Select.id));
   }
   
   function InitDeviceType()
   {
  	 	var List = getElementById("ChooseDeviceType");
		List.options.length = 0;
		List.options.add(new Option(portal_language['Computer'],"Computer"));
		List.options.add(new Option(portal_language['Phone'],"Phone"));
		List.options.add(new Option(portal_language['STB'],"STB"));
		List.options.add(new Option(portal_language['Other'],"Other"));
   }
   </script> 

<form id="TableUrlInfo" style="display:none"> 
	<div class="list_table_spread"></div>
	<table border="0" cellpadding="0" cellspacing="1"  width="100%" class="tabal_noborder_bg"> 
		<li id="ChooseDeviceType_select" RealType="SmartBoxList" DescRef="bbsp_devtypemh" RemarkRef="Empty" ErrorMsgRef="Empty" Require="FALSE" BindField="x.DeviceTypeName"        
		InitValue="[{Item:[{AttrName:'id', AttrValue:'DeviceNameControl'},{AttrName:'type', AttrValue:'text'},{AttrName:'class', AttrValue:'inputclass1'},{AttrName:'Maxlength', AttrValue:'32'}]}]" ClickFuncApp="onChange=OnChooseDeviceType"/>
		<li   id="UrlAddressControl"    RealType="TextBox"          DescRef="bbsp_urlmh"       RemarkRef="Empty"     ErrorMsgRef="Empty"    Require="FALSE"     BindField="x.PortalUrl"  Elementclass="inputclass"  InitValue="Empty" Maxlength="256"/>
	</table>
	<script language="JavaScript" type="text/javascript">
		var PortalConfigFormList = new Array();
		PortalConfigFormList = HWGetLiIdListByForm("TableUrlInfo", null);
		var formid_hide_id = null;
		HWParsePageControlByID("TableUrlInfo", TableClass, portal_language, formid_hide_id);
		getElById('DeviceNameControl').ErrorMsg = portal_language['bbsp_portalemsg'];
		InitDeviceType();
	</script>
  <table width="100%"  cellspacing="1" class="table_button"> 
    <tr> 
      <td class="per_25_35"></td> 
      <td class="table_submit pad_left5p">
	  	<button id='Applys' type=button onclick = "javascript:return OnApply();" class="ApplyButtoncss buttonwidth_100px"><script>document.write(portal_language['bbsp_app']);</script></button> 
        <button id='Cancels' type=button onclick="javascript:return OnItemCancel();" class="CancleButtonCss buttonwidth_100px"><script>document.write(portal_language['bbsp_cancel']);</script></button>
	</td> 
    </tr> 
  </table> 
</form> 
</body>
</html>
