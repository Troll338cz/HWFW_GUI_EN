<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<style type="text/css">
#pccframeWarpContent {
	height: 610px;
}
</style>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<script language="javascript" src="../common/userinfo.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="JavaScript" type="text/javascript">
var isUrlFilCategory = '<%HW_WEB_GetFeatureSupport(FT_URLFIL_CATEGORY);%>';
var numpara1 = '';
var numpara2 = '';
if ( window.location.href.indexOf("?") > 0)
{
    numpara1 = window.location.href.split("?")[1];
    numpara2 = window.location.href.split("?")[2];
}

function loadlanguage()
{
    var all = document.getElementsByTagName("td");
    for (var i = 0; i <all.length ; i++) {
        var b = all[i];
        if (b.getAttribute("BindText") == null) {
            continue;
        }
        setObjNoEncodeInnerHtmlValue(b, parentalctrl_language[b.getAttribute("BindText")]);
    }
}

var firewallLevel = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>';
function LoadFrame()
{
    ClickAllInfo();
    loadlanguage();
    if (isUrlFilCategory == 1) {
        setDisplay("tdCategory", 1);
        setDisplay("tdCategorySpace", 1);
        setDisplay("tdCategoryLine", 1);
        setDisplay("tdCategoryEndSpace", 1);
        $("#middleSpace").css("width", "70%");
    }

    if (firewallLevel.toUpperCase() != 'CUSTOM') {
        setDisable('UrlEnable' , 1);
        setDisable('FilterMode' , 1);
    }
}

function ClickAllInfo()
{
    document.getElementById("ParentalctrlAllInfo").style.color = $(".TagTitleClick").css("color");
    document.getElementById("ParentalctrlTemplate").style.color = $(".TagTitleNoClick").css("color");
    document.getElementById("ParentalctrlCategory").style.color = $(".TagTitleNoClick").css("color");
    document.getElementById("ParentalctrlStatistics").style.color = $(".TagTitleNoClick").css("color");
    if ((window.location.href.indexOf("?") > 0) && ((ManageCfgWord.OSK == 1) || (ManageCfgWord.COMMON == 1))) {
        document.getElementById("pccframeContent").src="/html/bbsp/parentalctrl/parentalctrlmac.asp?" + htmlencode(numpara1) +'?' + htmlencode(numpara2);
    } else {
        document.getElementById("pccframeContent").src="/html/bbsp/parentalctrl/parentalctrlmac.asp";
    }
}
function ClickTemplate()
{
    document.getElementById("ParentalctrlAllInfo").style.color = $(".TagTitleNoClick").css("color");
    document.getElementById("ParentalctrlTemplate").style.color = $(".TagTitleClick").css("color");
    document.getElementById("ParentalctrlCategory").style.color = $(".TagTitleNoClick").css("color");
    document.getElementById("ParentalctrlStatistics").style.color = $(".TagTitleNoClick").css("color");
    document.getElementById("pccframeContent").src="/html/bbsp/parentalctrl/parentalctrltemplate.asp";
}
function ClickCategory()
{
    document.getElementById("ParentalctrlAllInfo").style.color = $(".TagTitleNoClick").css("color");
    document.getElementById("ParentalctrlTemplate").style.color = $(".TagTitleNoClick").css("color");
    document.getElementById("ParentalctrlCategory").style.color = $(".TagTitleClick").css("color");
    document.getElementById("ParentalctrlStatistics").style.color = $(".TagTitleNoClick").css("color");
    document.getElementById("pccframeContent").src="/html/bbsp/parentalctrl/parentalctrlcategory.asp";
}
function ClickStatistics()
{
    document.getElementById("ParentalctrlAllInfo").style.color = $(".TagTitleNoClick").css("color");
    document.getElementById("ParentalctrlTemplate").style.color = $(".TagTitleNoClick").css("color");
    document.getElementById("ParentalctrlCategory").style.color = $(".TagTitleNoClick").css("color");
    document.getElementById("ParentalctrlStatistics").style.color = $(".TagTitleClick").css("color");
    document.getElementById("pccframeContent").src="/html/bbsp/parentalctrl/parentalctrlStat.asp";
}

function showdiag()
{
    var d = document.getElementById("diag");
    d.style.left = 20;
    d.style.top = 0;
    var srcUrl = document.getElementById("pccframeContent").src;
    if ((isUrlFilCategory == 1) && (srcUrl.indexOf("/html/bbsp/parentalctrl/parentalctrltemplate.asp") >= 0)) {
        $("#diag").css("height", '1000px');
    } else {
        $("#diag").css("height", '800px');
    }
    d.style.display = "block";
}
function closeDiag()
{
    var d = document.getElementById("diag");
    d.style.display = "none";
}

function adjustParentHeight(containerID, newHeight)
{
    $("#DivContent").css("height", 'auto');
    var newHeight1 = (newHeight > 700) ? newHeight : 700;
    $("#" + containerID).css("height", newHeight1 + "px");

    if ((navigator.appName.indexOf("Internet Explorer") == -1)
        && (containerID == "pccframeWarpContent")) {
        var height1 = document.body.scrollHeight;
        var height = (height1 > 700) ? height1 : 700;
        $("#DivContent").css("height", height + "px");
    }
}

</script>
</head>
<body onLoad="LoadFrame();" class="mainbody">
    <div id="DivContent" style="display:block">
    <table width="100%" height="0" border="0" cellpadding="0" cellspacing="0"><tr> <td></td></tr>
    <script language="JavaScript" type="text/javascript">
    HWCreatePageHeadInfo("parental", GetDescFormArrayById(parentalctrl_language, "bbsp_mune"), GetDescFormArrayById(parentalctrl_language, "bbsp_parental_control_title_cnt"), false);
    </script>
    </table>
    <div id="urlfiltercfg">
    <div class="title_spread"></div>
    <div class="func_title">URL Filter Configuration</div>
    <table id="TableFilterContent" width="100%" cellspacing="1" class="tabal_bg">
    <tr>
      <td class="table_title per_20_25" BindText='bbsp_enableurlfiltermh'></td>
      <td class="table_right"><input type="checkbox" id="UrlEnable" onclick="OnUrlEnableClick(this)"/></td>
    <tr>
      <td class="table_title width_per20" BindText='bbsp_urlfiltermodemh'></td>
      <td class="table_right" id="Selectmode">
      <select id="FilterMode" onchange="setTimeout(function(){OnNameListModeChange();})">
          <option value="0"><script>document.write(parentalctrl_language['bbsp_blacklist']);</script></option>
          <option value="1"><script>document.write(parentalctrl_language['bbsp_whitelist']);</script></option>
      </select>
    </td>
       <script>
            getElById("UrlEnable").title = parentalctrl_language['bbsp_urlfilternote1'];
            getElById("Selectmode").title = parentalctrl_language['bbsp_urlfilternote3'];
       </script>
    </tr> 
  </table> 
   </div> 
  <div class="func_spread"></div>
  <table id="urlfilterinfo" width="100%">
    <tr>
      <td><script language="JavaScript" type="text/javascript">
        (('<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>'.toUpperCase() == 'CUSTOM') ? writeTabCfgHeader : writeTabInfoHeader)('TableUrlRecord',"100%","140");
    </script></td>
    </tr>
    <tr>
      <td> <table id="TableUrlRecord" width="100%" style="display:none;"> </table></td>
    </tr>
  </table>
  <div id="ConfigUrlPanel" style="display:none">
   <div class="list_table_spread"></div>
    <table cellpadding="0" cellspacing="1" class="tabal_bg" width="100%">
      <tr class='height20p'>
        <td class="table_title width_per20 align_left" nowrap="nowrap" BindText='bbsp_urladdrmh'> </td>
        <td class="table_right align_left"> <input type="text" id="UrlValue"  class='width_per95' maxlength="63"/>
          <font color="red">*</font></td>
      </tr>
    </table>
    <table width="100%" class="table_button">
      <tr >
        <td class='width_per20'></td>
        <td class="table_submit">
        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        <button id='btnApply_ex' name="btnApply_ex" class="ApplyButtoncss buttonwidth_100px" type="button" onClick="OnBtAddUrlClick(this)"><script>document.write(parentalctrl_language['bbsp_app']);</script></button>
          <button id='Cancel' name="cancel" class="CancleButtonCss buttonwidth_100px" type="button" onclick="OnCancel();"><script>document.write(parentalctrl_language['bbsp_cancel']);</script></button> </td>
      </tr>
    </table>
  </div>
</div>
  <script language="javascript">
    function UrlValueClass(_Domain, _Url)
    {
        this.Domain = _Domain;
        this.Url = _Url;
    }
    
    function UrlFilterBaseValueClass(_Domain, _Policy, _Right)
    {
        this.Domain = _Domain;
        this.Policy = _Policy;
        this.Right = _Right;
    }

    var BaseUrlFilterValueArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.ParentalCtrl.Templates.1,UrlFilterPolicy|UrlFilterRight,UrlFilterBaseValueClass);%>;
    var BaseUrlFilterValue = BaseUrlFilterValueArray[0];
    var UrlValueArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.ParentalCtrl.Templates.1.UrlFilter.{i},UrlAddress,UrlValueClass);%>;
    var selectindex = -1;

    if (BaseUrlFilterValue == null)
    {
        BaseUrlFilterValue = new UrlFilterBaseValueClass();
        BaseUrlFilterValue.Right = "0";
        BaseUrlFilterValue.Policy = "1";
        UrlValueArray = new Array();
    }
    
    function DataPersistentClass()
    {   
        this.GetData = function() {
            var UrlFilterInfo = new UrlFilterInfoClass();
            var UrlEnable = BaseUrlFilterValue.Right;
            var NameListMode = BaseUrlFilterValue.Policy;
            var ArrayOfUrl = UrlValueArray;
            var UrlFilterInfo = new UrlFilterInfoClass(UrlEnable, NameListMode, "" ,ArrayOfUrl);
            UrlFilterInfo.SetEnable(UrlEnable);
            return UrlFilterInfo;
        }
        this.SaveData = function(UrlFilterInfo) {
        }
    }

    function DataUIObserverClass()
    {
        this.UpdateUI = function(UrlFilterInfo) {
            document.getElementById("UrlEnable").checked = UrlFilterInfo.GetEnable() == "1" ? true:false;
            document.getElementById("DivContent").style.display = "block";
            if (UrlFilterInfo.GetEnable() == "1") {
               document.getElementById("DivContent").style.display = "block";
            }

            getElById("FilterMode")[0].selected = true;
            if (UrlFilterInfo.GetNameListMode() == "1") {
                getElById("FilterMode")[1].selected = true;
            }

            var Table = document.getElementById("TableUrlRecord");
            var Html = "<table id=\"TableUrlList\" width=\"100%\" cellspacing=\"1\" class=\"tabal_bg\"><tr align=\"center\" class=\"head_title\"><td width=\"8%\" class=\"head_title\"></td><td align=\"center\" class=\"head_title\">"+parentalctrl_language['bbsp_urladdr']+"</td></tr>";
            var UrlArray = UrlFilterInfo.GetAllUrl();
            var i = 0;
            var Index = 0;
            if ('<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>'.toUpperCase() != 'CUSTOM') {
                UrlArray.length = 0;
            }
            if (UrlArray.length <= 1) {
               Html += "<tr class=\"trTabContent align_left\"><td class=\"tabal_01\"></td><td class=\"tabal_01 align_center\">--</td></tr>"; 
            }
            for (i = 0; i < UrlArray.length; i++) {
                if (UrlArray[i] == null) {
                    continue;
                }
                var URL = htmlencode(UrlArray[i].Url);
                Html += "<tr class=\"trTabContent align_left\"><td class=\"tabal_01\"><input type=\"checkbox\" name=\"rml\" value=\""+htmlencode(UrlArray[i].Domain)+"\" id=\"RecordId"+Index+"\"/></td><td title=\""+  URL +"\" class=\"tabal_01\">"+GetStringContent(URL, 50)+"</td></tr>";
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

        this.SetUIObserver = function(_UIObserver) {
            this.UIObserver = _UIObserver;
            this.UrlFileInfoObj.AddObserver(this.UIObserver);
        }
        this.GetUIObserver = function() {
            return this.UIObserver;
        }

        this.SetData = function(_UrlFilterInfo) {
            this.UrlFileInfoObj = _UrlFilterInfo;
            this.UrlFileInfoObj.NotifyObserver();
        }
        this.GetData = function() {
            return this.UrlFileInfoObj;
        }

        this.LoadData = function() {
            var DataObj = new DataPersistentClass();
            var UIObserver = new DataUIObserverClass();
            var UrlFilterInfo = DataObj.GetData();
            UrlFilterInfo.AddObserver(UIObserver);
            this.SetData(UrlFilterInfo);
        }
        this.SaveData = function() {
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
        Form.setAction('set.cgi?' +'x=InternetGatewayDevice.X_HW_Security.ParentalCtrl.Templates.1' + '&RequestFile=html/bbsp/parentalctrl/parentalctrlstatus_cnt.asp');
        Form.submit();
    }

    function OnNameListModeChange()
    {
        var Form = new webSubmitForm();
        var control = getElById("FilterMode");
        if (control[0].selected == true) { 	
            if (ConfirmEx(parentalctrl_language['bbsp_ischange'])) {
                Form.addParameter('x.UrlFilterPolicy',0);
            } else {
                control[0].selected = false;
                control[1].selected = true;
                return;
            }
        } else if (control[1].selected == true) { 
            if (ConfirmEx(parentalctrl_language['bbsp_ischange'])) {
                Form.addParameter('x.UrlFilterPolicy',1);
            } else {
                control[0].selected = true;
                control[1].selected = false;
                return;
            }
        }
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('set.cgi?' +'x=InternetGatewayDevice.X_HW_Security.ParentalCtrl.Templates.1' + '&RequestFile=html/bbsp/parentalctrl/parentalctrlstatus_cnt.asp');
        Form.submit();
    }

    function OnDeleteBtClick()
    {
        var i = 0;
        var count = Page.GetData().GetUrlList().length;
        var control = null;
        var DeleteInstanceArray = new Array();

        if ((count-1) == 0) {
            AlertEx(parentalctrl_language['bbsp_nourl']);
            return;
        }

        for (i = 0; i < count; i++) {
            control = document.getElementById("RecordId"+i.toString());
            if (control == null) {
                continue;
            }
            if (control.checked == false) {
                continue;
            }

            DeleteInstanceArray.push(control.value);
        }

        if (DeleteInstanceArray.length == 0) {
            AlertEx(parentalctrl_language['bbsp_selecturl']);
            return;
        }

        var Form = new webSubmitForm();
        for (i = 0; i < count; i++) {
            control = document.getElementById("RecordId"+i.toString());
            if (control == null) {
                continue;
            }
            if (control.checked == false) {
                continue;
            }
            Form.addParameter(control.value, '');
        }

        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('del.cgi?&RequestFile=html/bbsp/parentalctrl/parentalctrlstatus_cnt.asp');
        Form.submit();
    }

    function IsUrlRepeat(UrlList, NewUrl)
    {
        var i;
        for (i = 0; i < UrlList.length; i++) { 
            if (UrlList[i] == null) {
                break;
            }
        
            if (UrlList[i].Url.toLowerCase() == NewUrl.toLowerCase()) {
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

        if (isValidAscii(UrlString) != '') {
            AlertEx(parentalctrl_language['bbsp_urladdr'] + Languages['Hasvalidch'] + isValidAscii(UrlString) + '".');          
            return false;
        }


        if ((CheckUrlParameter(UrlString) == false) || (IsUrlValid(UrlString) == false)) {	
            AlertEx(parentalctrl_language['bbsp_urlinvalid']);
            return false;
        }
        if (IsUrlRepeat(ArrayOfUrl, UrlString) == true) {
            AlertEx(parentalctrl_language['bbsp_urlrepeat']);
            return false;
        }

        var Form = new webSubmitForm();
        Form.addParameter('x.UrlAddress',UrlString);
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
        Form.setAction('add.cgi?' +'x=InternetGatewayDevice.X_HW_Security.ParentalCtrl.Templates.1.UrlFilter' + '&RequestFile=html/bbsp/parentalctrl/parentalctrlstatus_cnt.asp');
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
        if (Index == -1) {
            if(Page.GetData().GetUrlList().length >= 129) {
                DeleteLineRow();
                AlertEx(parentalctrl_language['bbsp_urlfull']);
                return ;
            }
        } else {
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
        <div class="title_spread"></div>
        <div class="title_spread"></div>
        <div class="title_spread"></div>
        <div class="title_spread"></div>
        <div class="func_title"> Parental Control Configuration</div>
        <table>
            <tr>
                <td width="5%" class="TagTitle1"><a id="ParentalctrlAllInfo" href="#" name="ParentalctrlAllInfo" onClick="ClickAllInfo();"><span class="TagTitle"><script> document.write(parentalctrl_language['bbsp_all']); </script></span></a></td>
                <td class="TagLineSpace"></td>
                <td class="TagLine">|</td>
                <td class="TagLineSpace"></td>
                <td width="5%"><a id="ParentalctrlTemplate" href="#" name="ParentalctrlTemplate" onClick="ClickTemplate();"><span class="TagTitle"><script> document.write(parentalctrl_language['bbsp_template']); </script></span></a></td>
                <td class="TagLineSpace"></td>
                <td class="TagLine">|</td>
                <td class="TagLineSpace"></td>
                <td width="5%" id="tdCategory" style="display:none;"><a id="ParentalctrlCategory" href="#" name="ParentalctrlCategory" onClick="ClickCategory();"><span class="TagTitle"><script> document.write(parentalctrl_language['bbsp_category']); </script></span></a></td>
                <td class="TagLineSpace" id="tdCategorySpace" style="display:none;"></td>
                <td class="TagLine" id="tdCategoryLine" style="display:none;">|</td>
                <td class="TagLineSpace" id="tdCategoryEndSpace" style="display:none;"></td>
                <td width="5%"><a id="ParentalctrlStatistics" href="#" name="ParentalctrlStatistics" onClick="ClickStatistics();"><span class="TagTitle"><script> document.write(parentalctrl_language['bbsp_stat']); </script></span></a></td>
                <td width="75%" id="middleSpace"></td>
                <td width="10%"><a id="Parentalctrlhelp" href="#" name="Parentalctrlhelp" onClick="showdiag();"><script> document.write(parentalctrl_language['bbsp_help']); </script></a></td>
            </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr ><td height="10">
            <div id="tagclick" class="TagTitleClick"></div>
            <div id="tagnoclick" class="TagTitleNoClick"></div>
            </td></tr>
        </table>
        <div id="diag" width="100%" class = "diaghelp" onClick="closeDiag();">
                <table  id="TableHelp"   width="100%" border="0" cellpadding="0" cellspacing="0">
                <script language="JavaScript" type="text/javascript">
                    document.write('<tr class="head_helptitle">');
                </script>
                    <td class='align_left' colspan="2" BindText ='bbsp_pcchelptitle'></td>
                </tr>
                <tr>
                    <td class="table_helptitle" BindText ='bbsp_pcchelpinfo'> </td>
                </tr>
                <script language="JavaScript" type="text/javascript">
                    document.write('<tr class="head_helptitle">');
                </script>
                    <td class='align_left' colspan="2" BindText ='bbsp_template'></td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2"  BindText ='bbsp_pcchelptempalteinfo1'> </td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2" BindText ='bbsp_pcchelpexplain'> </td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2" BindText ='bbsp_pcchelptempalteinfo2'> </td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2" BindText ='bbsp_pcchelptempalteinfo3'> </td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2" BindText ='bbsp_pcchelptempalteinfo4'> </td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2" BindText ='bbsp_pcchelptempalteinfo5'> </td>
                </tr>
                <script language="JavaScript" type="text/javascript">
                    document.write('<tr class="head_helptitle">');
                </script>
                    <td class='align_left' colspan="2" BindText ='bbsp_all'></td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2"  BindText ='bbsp_pcchelpallinfo1'> </td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2" BindText ='bbsp_pcchelpexplain'> </td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2" BindText ='bbsp_pcchelpallinfo2'> </td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2" BindText ='bbsp_pcchelpallinfo3'> </td>
                </tr>
                <script language="JavaScript" type="text/javascript">
                    document.write('<tr class="head_helptitle">');
                </script>
                    <td class='align_left' colspan="2" BindText ='bbsp_stattitle'></td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2"  BindText ='bbsp_statinfo1'> </td>
                </tr>
                <script language="JavaScript" type="text/javascript">
                    document.write('<tr class="head_helptitle">');
                </script>
                    <td class='align_left' colspan="2" BindText ='bbsp_FAQtitle'></td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2"  BindText ='bbsp_FAQQ1info'> </td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2"  BindText ='bbsp_FAQA1info1'> </td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2"  BindText ='bbsp_FAQA1info2'> </td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2"  BindText ='bbsp_FAQA1info3'> </td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2"  BindText ='bbsp_FAQQ2info'> </td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2"  BindText ='bbsp_FAQA2info1'> </td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2"  BindText ='bbsp_FAQA2info2'> </td>
                </tr>
                <tr>
                    <td class="table_helptitle"  colspan="2"  BindText ='bbsp_FAQA2info3'> </td>
                </tr>
            </table>
        </div>
        <div id="pccframeWarpContent">
            <iframe id="pccframeContent" frameborder="0" marginheight="0" marginwidth="0" scrolling="no" width="100%" height="100%" />
        </div>
    </div>
</body>
</html>