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
<script language="javascript" src="../common/wan_check.asp"></script>
<script language="javascript" src="../common/userinfo.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<title>URL Filter</title>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html, urlfiltersetting_language);%>"></script>
<script language="JavaScript" type="text/javascript">
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
var BeltelePONFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOM);%>';
var BelteleLanFlag = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BELTELECOMLAN);%>';
var rosunionGame = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_ROSUNION_GAME);%>';

function IsNeedAddSafeDesForBelTelecom(){
	if(1 == BeltelePONFlag || 1 == BelteleLanFlag || CfgModeWord.toUpperCase().indexOf("BELTELECOM") >= 0){
		return true;
	}
	
	return false;
}
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
		setObjNoEncodeInnerHtmlValue(b, urlfiltersetting_language[b.getAttribute("BindText")]);
	}
}

function LoadFrame()
{
	if('<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>'.toUpperCase() != 'CUSTOM')
	{
		setDisable('UrlEnable' , 1);
		setDisable('SmartEnable' , 1);
		setDisable('FilterMode' , 1);
	}
	loadlanguage();
}

</script>   
</head>
<body  onLoad="LoadFrame();" class="mainbody">
<div id="DivContent" style="display:block"> 
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("urlfiltersettingtitle", GetDescFormArrayById(urlfiltersetting_language, "bbsp_urlmenutitle"), GetDescFormArrayById(urlfiltersetting_language, ""), false);
	 setNoEncodeInnerHtmlValue("urlfiltersettingtitle_content", urlfiltersetting_language['bbsp_urlfilter_title1']);
if (true == IsNeedAddSafeDesForBelTelecom())
{
	setNoEncodeInnerHtmlValue("urlfiltersettingtitle_content", urlfiltersetting_language['bbsp_urlfilter_title1'] + "<p style=\"color:red;\">Пользователь несет полную ответственность за изменение им настроек модема, которые могут повлечь несанкционированный доступ к модему сетевых злоумышленников и причинить пользователю финансовый ущерб.</p>");
}
</script> 
<div class="title_spread"></div>
  
  <table id="TableFilterContent"  width="100%" cellspacing="1" class="tabal_bg"> 
    <tr > 
      <td  class="table_title per_20_25" BindText='bbsp_enableurlfiltermh'></td> 
      <td class="table_right"><input  type="checkbox" id="UrlEnable" onclick="OnUrlEnableClick(this)"/></td> 
    <tr  style="display:none"> 
      <td  class="table_title per_20_25" BindText='bbsp_enablesmarturlfiltermh'></td> 
      <td  class="table_right"><input  type='checkbox' id="SmartEnable" onclick = "OnSmartEnableClick(this)"/></td> 
    </tr> 
    <tr > 
      <td  class="table_title width_per20" BindText='bbsp_urlfiltermodemh'></td> 
      <td  class="table_right"  id="Selectmode" >
	  <select id="FilterMode" onchange="setTimeout(function(){OnNameListModeChange();})"> 
          <option value="0"><script>document.write(urlfiltersetting_language['bbsp_blacklist']);</script></option> 
          <option value="1"><script>document.write(urlfiltersetting_language['bbsp_whitelist']);</script></option> 
      </select>
	   </td>
	   <script>
	   		getElById("UrlEnable").title = urlfiltersetting_language['bbsp_urlfilternote1'];
			getElById("SmartEnable").title = urlfiltersetting_language['bbsp_urlfilternote2'];
			getElById("Selectmode").title = urlfiltersetting_language['bbsp_urlfilternote3'];
	   </script>
    </tr> 
  </table> 
  <div class="func_spread"></div>
  
  <table width="100%"> 
    <tr> 
      <td> <script language="JavaScript" type="text/javascript">
                                  (('<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>'.toUpperCase() == 'CUSTOM') ? writeTabCfgHeader : writeTabInfoHeader)('TableUrlRecord',"100%","140");
            </script> </td> 
    </tr> 
    <tr> 
      <td> <table id="TableUrlRecord"  width="100%"> </table></td> 
    </tr> 
  </table> 
 
  <div id="ConfigUrlPanel" style="display:none"> 
   <div class="list_table_spread"></div>
    <table cellpadding="0" cellspacing="1" class="tabal_bg" width="100%"> 
      <tr class='height20p'> 
        <td   class="table_title width_per20 align_left" nowrap="nowrap" BindText='bbsp_urladdrmh'> </td> 
        <td   class="table_right align_left"> <input type="text" id="UrlValue"  class='width_per95' maxlength="63"/> 
          <font color="red">*</font></td> 
      </tr> 
    </table> 
    <table width="100%" class="table_button"> 
      <tr > 
        <td class='width_per20'></td> 
        <td class="table_submit"> 
		 <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
		<button id='btnApply_ex' name="btnApply_ex" class="ApplyButtoncss buttonwidth_100px" type="button" onClick="OnBtAddUrlClick(this)"><script>document.write(urlfiltersetting_language['bbsp_app']);</script></button> 
          <button id='Cancel' name="cancel" class="CancleButtonCss buttonwidth_100px" type="button" onclick="OnCancel();"><script>document.write(urlfiltersetting_language['bbsp_cancel']);</script></button> </td> 
      </tr> 
    </table> 
  </div> 
</div> 
<script language="javascript">

	var IsBJUNICOMFlag = '<%HW_WEB_GetFeatureSupport(FT_URL_FILTER_SUPPORT_HTTPS);%>';

    function UrlValueClass(_Domain, _Url)
    {
        this.Domain = _Domain;
        this.Url = _Url;
    }
    
    function UrlFilterBaseValueClass(_Domain, _Policy, _Right, _IpConcern)
    {
        this.Domain = _Domain;
        this.Policy = _Policy;
        this.Right = _Right;
        this.IpConcern = _IpConcern;
    }

    var BaseUrlFilterValueArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security,UrlFilterPolicy|UrlFilterRight|UrlFilterIpConcern,UrlFilterBaseValueClass);%>;
    var BaseUrlFilterValue = BaseUrlFilterValueArray[0];
    var UrlValueArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.UrlFilter.{i},UrlAddress,UrlValueClass);%>;
	var selectindex = -1;

    if (null == BaseUrlFilterValue)
    {
        BaseUrlFilterValue = new UrlFilterBaseValueClass();
        BaseUrlFilterValue.Right = "0";
        BaseUrlFilterValue.Policy = "1";
        BaseUrlFilterValue.IpConcern = "0";
        UrlValueArray = new Array();
    }
    
    function DataPersistentClass()
    {   
        this.GetData = function()
        {
            var UrlFilterInfo = new UrlFilterInfoClass();
            var UrlEnable = BaseUrlFilterValue.Right;
            var NameListMode = BaseUrlFilterValue.Policy;
            var SmartEnable = BaseUrlFilterValue.IpConcern;
            var ArrayOfUrl = UrlValueArray;
            var i = 0;
  
            var UrlFilterInfo = new UrlFilterInfoClass(UrlEnable, NameListMode, SmartEnable, ArrayOfUrl);
            UrlFilterInfo.SetEnable(UrlEnable);

            return UrlFilterInfo;
        }

        this.SaveData = function(UrlFilterInfo)
        {   

        }
    }

    function DataUIObserverClass()
    {
        this.UpdateUI = function(UrlFilterInfo)
        {
        	document.getElementById("UrlEnable").checked = UrlFilterInfo.GetEnable() == "1" ? true:false;
             
            document.getElementById("DivContent").style.display = "block";
            if ("1" == UrlFilterInfo.GetEnable())
            {
               document.getElementById("DivContent").style.display = "block";
            }

            getElById("FilterMode")[0].selected = true;
            if (UrlFilterInfo.GetNameListMode() == "1")
            {
                getElById("FilterMode")[1].selected = true;
            }

            document.getElementById("SmartEnable").checked = UrlFilterInfo.GetSmartEnable().toString()=="1"?true:false;
            var Table = document.getElementById("TableUrlRecord");
            var Html = "<table id=\"TableUrlList\" width=\"100%\" cellspacing=\"1\" class=\"tabal_bg\"><tr align=\"center\" class=\"head_title\"><td width=\"8%\" class=\"head_title\"></td><td align=\"center\" class=\"head_title\">"+urlfiltersetting_language['bbsp_urladdr']+"</td></tr>";
			if (rosunionGame == "1") {
				Html = "<table id=\"TableUrlList\" width=\"100%\" cellspacing=\"1\" class=\"tabal_bg\"><tr align=\"center\" class=\"head_title\"><td width=\"8%\" class=\"" + bottomBorderClass(false) + "\"></td><td align=\"center\" class=\"" + bottomBorderClass(false) + "\">"+urlfiltersetting_language['bbsp_urladdr']+"</td></tr>";
			}
            var UrlArray = UrlFilterInfo.GetAllUrl();
            var i = 0;
            var Index = 0;
            if('<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>'.toUpperCase() != 'CUSTOM')
            {
                UrlArray.length = 0;
            }
            if (UrlArray.length <= 1)
            {
               Html += "<tr class=\"trTabContent align_left\"><td class=\"tabal_01 " + bottomBorderClass(false) + "\"></td><td class=\"tabal_01 align_center " + bottomBorderClass(false) + "\">--</td></tr>"; 
            }
            for (i = 0; i < UrlArray.length; i++)
            {
                if (UrlArray[i] == null)
                {
                    continue;
                }
                var URL = htmlencode(UrlArray[i].Url);
                Html += "<tr class=\"trTabContent align_left\"><td class=\"tabal_01" + bottomBorderClass(false) + "\"><input type=\"checkbox\" name=\"rml\" value=\""+htmlencode(UrlArray[i].Domain)+"\" id=\"RecordId"+Index+"\"/></td><td title=\""+  URL +"\" class=\"tabal_01" + bottomBorderClass(false) + "\">"+GetStringContent(URL, 50)+"</td></tr>";
                Index++;
            }
            Html +="</table>";

            setObjNoEncodeInnerHtmlValue(Table, Html);
        }
    }

    function UrlFilterPage()
    {
        this.UrlFileInfoObj = null;
        this.UIObserver = null;

        this.SetUIObserver = function(_UIObserver)
        {
            this.UIObserver = _UIObserver;
            this.UrlFileInfoObj.AddObserver(this.UIObserver);
        }
        this.GetUIObserver = function()
        {
            return this.UIObserver;
        }

        this.SetData = function(_UrlFilterInfo)
        {
            this.UrlFileInfoObj = _UrlFilterInfo;
            this.UrlFileInfoObj.NotifyObserver();
        }
        this.GetData = function()
        {
            return this.UrlFileInfoObj;
        }        

        this.LoadData = function()
        {
            var DataObj = new DataPersistentClass();
            var UIObserver = new DataUIObserverClass();
            var UrlFilterInfo = DataObj.GetData();
            UrlFilterInfo.AddObserver(UIObserver);
            this.SetData(UrlFilterInfo);
        }
        this.SaveData = function()
        {
            this.UrlFileInfoObj.SaveData(new DataPersistentClass());
        } 
    }

   var Page = new UrlFilterPage();

   Page.LoadData();

    function OnDeleteUrlClick(Url)
    {
        Page.GetData().DeleteUrl(Url);
    }

    function OnUrlEnableClick(UrlEnableControl)
    {
        var Checked = UrlEnableControl.checked;
        var Display = true == Checked ? "block" : "none";
        var Right = Checked == true?"1":"0";
        document.getElementById("DivContent").style.display = "block";
        Page.GetData().SetEnable(Right);

        var Form = new webSubmitForm();
	    Form.addParameter('x.UrlFilterRight',Right);
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
	    Form.setAction('set.cgi?' +'x=InternetGatewayDevice.X_HW_Security' + '&RequestFile=html/bbsp/urlfiltersetting/urlfiltersetting.asp');
	    Form.submit();
    }

    function OnNameListModeChange()
	{
    var Form = new webSubmitForm();

    var control = getElById("FilterMode");
    if (control[0].selected == true)
	{ 	
		if (ConfirmEx(urlfiltersetting_language['bbsp_ischange']))
		{
			Form.addParameter('x.UrlFilterPolicy',0);		
		}
		else
		{
		    control[0].selected = false;
			control[1].selected = true;
			return;
		}
	}
	else if (control[1].selected == true)
	{ 
		if (ConfirmEx(urlfiltersetting_language['bbsp_ischange']))
		{
			Form.addParameter('x.UrlFilterPolicy',1);
		}
		else
		{
		     control[0].selected = true;
		     control[1].selected = false;
			 return;
		}
	}
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    Form.setAction('set.cgi?' +'x=InternetGatewayDevice.X_HW_Security' + '&RequestFile=html/bbsp/urlfiltersetting/urlfiltersetting.asp');
    Form.submit();
}

    function OnSmartEnableClick(Control)
    {
        return;
    }

    function OnDeleteBtClick()
    {
        var i = 0;
        var count = Page.GetData().GetUrlList().length;
        var control = null;
        var DeleteInstanceArray = new Array();

		if(0 == (count-1))
		{
		    AlertEx(urlfiltersetting_language['bbsp_nourl']);
			return;
		}

        for (i = 0; i < count; i++)
        {
            control = document.getElementById("RecordId"+i.toString());
            if (null == control)
            {
                continue;
            }
            if (control.checked == false)
            {
                continue;
            }

            DeleteInstanceArray.push(control.value);
        }

        if (DeleteInstanceArray.length == 0)
        {
            AlertEx(urlfiltersetting_language['bbsp_selecturl']);
            return;
        }

        var Form = new webSubmitForm();
        for (i = 0; i < count; i++)
        {
            control = document.getElementById("RecordId"+i.toString());
            if (null == control)
            {
                continue;
            }
            if (control.checked == false)
            {
                continue;
            }
            Form.addParameter(control.value, '');
        }
		
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	    	
	    Form.setAction('del.cgi?&RequestFile=html/bbsp/urlfiltersetting/urlfiltersetting.asp');
	    Form.submit();
    }

	function IsBJUNICOMUrlValid(_Url)
	{	
		if(true == isNull(_Url))
		{
			return false;
		}
		var Url = new String(_Url.toLocaleLowerCase().replace("http://",""));
		var ExitColon = false;
		var ColonLocation = 0;
		var ColorReg = new RegExp(".*[a-zA-Z0-9]+:[0-9]+/*");

		var ArrayOfUrl = Url.split("//");

		if(ArrayOfUrl[0].toUpperCase() == "FTP:")
		{
			return false;
		}
		if (ArrayOfUrl.length >= 2)
		{
			Url = ArrayOfUrl[1];
		}

		if (Url.length == 0)
		{
			return false;
		}

		ColonLocation = Url.indexOf(":", 0);
		if (ColonLocation == 0)
		{
			return false;
		}

		ExitColon = ColonLocation > 0 ? true : false;

		if (ExitColon == false)
		{
			return true;
		}

		return ColorReg.test(Url);
	}
	
function CheckBJUNICOMUrlParameter(inputUrl)
{	
	if(checkSpace(inputUrl)==false)
	{
	  return false;
	}

	if(inputUrl.indexOf('http://')!=-1)
	{	
		if(inputUrl.indexOf('http://')!=0)
		{
			return false;
		}
		if(inputUrl=="http://")
		{
			return false;
		}
		inputUrl=inputUrl.substring(7);
	}
	if(inputUrl.indexOf('https://')!=-1)
	{	
		if(inputUrl.indexOf('https://')!=0)
		{	
			return false;
		}
		if(inputUrl=="https://")
		{	
			return false;
		}
		inputUrl=inputUrl.substring(8);
		
	}
	if(inputUrl.indexOf('/')==0)
	{
		return false;
	}
	var CutUrl=inputUrl.split('/');
	var Domine=CutUrl[0];
	var ports=Domine.split(':');
	var len=ports.length;
	if(ports.length>1)
	{
		if((parseInt(ports[len-1],10)>0&&parseInt(ports[len-1],10)<65536)==false)
		{
			return false;
		}
		Domine=Domine.substring(0,(Domine.length)-1-ports[len-1].length);
	}

	var i=0;
	var adds=Domine.split('.');
	if(adds[0]=='0'&&adds.length==4)
	{
		var isip=1;
		for(var key=1;key<=3;key++)
		{
			if(adds[key]<=255 && adds[key]>=0)
			{
				continue;
			}
			else
			{
				isip=0;
				break;
			}
		}
		if(isip==1)
		{
			return false;
		}
	}
	while(Domine.indexOf(" ")==0)
	{
		Domine=Domine.substring(1);
	}
	if(Domine=='0.0.0.0'||Domine=='255.255.255.255')
	{
		return false;
	}
	if ((isValidIpAddress(Domine) == true))
	{
		var addrs=Domine.split('.');
		if(parseInt(addrs[0],10)>=224)
		{
			return false;
		}
		if(Domine=='127.0.0.1')
		{
			return false;
		}
		if(addrs[3]=='0')
		{
			return false;
		}
	}
	return true;

}
	
    function IsUrlRepeat(UrlList, NewUrl)
    {
        var i;
        for (i = 0; i < UrlList.length; i++)
        {   
            if (UrlList[i] == null)
            {
                break;
            }
        
            if (UrlList[i].Url.toLowerCase() == NewUrl.toLowerCase())
            {
                return true;
            }
        }
        return false;
    }

    function OnBtAddUrlClick(BtAddUrlControl)
    {
		var UrlValueControl = document.getElementById("UrlValue");
        var UrlString = UrlValueControl.value;
        var ArrayOfUrl = Page.GetData().GetUrlList();

		if (isValidAscii(UrlString) != '')         
		{  
			AlertEx(urlfiltersetting_language['bbsp_urladdr'] + Languages['Hasvalidch'] + isValidAscii(UrlString) + '".');          
			return false;       
		}

		if(IsBJUNICOMFlag ==1)
		{	
			if((CheckBJUNICOMUrlParameter(UrlString) == false) || (IsBJUNICOMUrlValid(UrlString) == false))
			{	
				AlertEx(urlfiltersetting_language['bbsp_urlinvalid']);
				return false;
			}
		}
		else
		{	
			if((CheckUrlParameter(UrlString) == false) || (IsUrlValid(UrlString) == false))
			{	
				AlertEx(urlfiltersetting_language['bbsp_urlinvalid']);
				return false;
			}
		}
		
        if (IsUrlRepeat(ArrayOfUrl, UrlString) == true)
        {
            AlertEx(urlfiltersetting_language['bbsp_urlrepeat']);

            return false;
        }

        var Form = new webSubmitForm();
	    Form.addParameter('x.UrlAddress',UrlString);
		Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
	    Form.setAction('add.cgi?' +'x=InternetGatewayDevice.X_HW_Security.UrlFilter' + '&RequestFile=html/bbsp/urlfiltersetting/urlfiltersetting.asp');
	    Form.submit();
		DisableRepeatSubmit();
    }
	
	function DeleteLineRow()
	{
	   var tableRow = getElementById("TableUrlList");
	   if (tableRow.rows.length > 2)
	   tableRow.deleteRow(tableRow.rows.length-1);
	   return false;
	}
	
    function setControl(Index)
    {
		selectindex = Index;
		if (-1 == Index)
		{
			if(Page.GetData().GetUrlList().length >= 129)
			{
				DeleteLineRow();
				AlertEx(urlfiltersetting_language['bbsp_urlfull']);
				return ;
			} 
		}
		else
		{
			return ;
		}
        getElById("ConfigUrlPanel").style.display = "block";
    }
    function clickRemove() 
    {
        return OnDeleteBtClick();
    }

    function OnCancel()
    {   
        getElById("ConfigUrlPanel").style.display = "none";
        var tableRow = getElementById("TableUrlList");
        tableRow.deleteRow(tableRow.rows.length-1);
        return false;
    }
    </script> 
<br> 
<br> 
</body>
</html>
