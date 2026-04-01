<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link href='../../../Cuscss/<%HW_WEB_GetCusSource(guide.css);%>' rel="stylesheet" type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html, cfg_wlanupmode_db_language);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
</head>
<script type="text/javascript">
var guideIndex = '<%HW_WEB_GetGuideChl();%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var DirectGuideFlag = '<%HW_WEB_GetFeatureSupport(FT_CHANGE_GUIDE_LEVEL);%>';
var TriBandFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_TRIBAND_AP);%>';
var CaseBandFre  = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.WANDevice.1.WANCommonInterfaceConfig.X_HW_UpmodeConfig.1.UpAccessMode);%>';

var percent = 1;
var gNeighbourAP = [];
var lastresult = [];
var neighBour2g = new Array();
var neighBour5g = new Array();
var times;
var pageSize = 10;
var selectpage= 1;
var manualinput = false;
guideIndex = guideIndex - 48;
function stNeighbourAP(domain,SSID,BSSID,NetworkType,Channel,RSSI,Noise,DtimPeriod,BeaconPeriod,Security,Standard,MaxBitRate,HilinkState)
{
    this.domain = domain;
    this.SSID = SSID;
    this.BSSID = BSSID;
    this.NetworkType = NetworkType;
    this.Channel = Channel;
    this.RSSI = RSSI;
    this.Noise = Noise;
    this.DtimPeriod = DtimPeriod;
    this.BeaconPeriod = BeaconPeriod;
    this.Security = Security;
    this.Standard = Standard;
    this.MaxBitRate = MaxBitRate;
	this.HilinkState = HilinkState;
}

function setPrograss()
{
	setDisplay("progress_bar",1);

    var progvalue = percent*(5.36);

    $("#bssResProgPer").css("margin-left", progvalue + "px");

    $(".ampResProgBarPer").css('width', progvalue + "px");

    if (percent > 90)
    {
        document.getElementById('percent').innerHTML = "90%";
    }
    else
    {
        document.getElementById('percent').innerHTML = htmlencode(percent) + "%";
    }

    if (percent > 90)
    {
		clearInterval(times);

		return;
    }

    percent++;
}

function SetProgresstoAll()
{
	clearInterval(times);
    $("#bssResProgPer").css("margin-left","508px");
    $(".ampResProgBarPer").css('width', "536px");
    document.getElementById('percent').innerHTML = "100%";
    percent = 100;  
    setTimeout("HiddenProgress()",200);
}

function HiddenProgress()
{
    
    if (gNeighbourAP)
    {
        setDisplay("progress_bar",0);
        setDisplay("Tab",1);      
    }

    if (percent == 100)
    {
    	InitScanResule(1);

    }
}

function SignalIntensity(record)
{
    var rssivalue = "";
    if (!record)
    {
        rssivalue = "nosignal.png";
    }
    
    if (record < -80 )
    {
        rssivalue = "onesignal.png";  
    }
    if ((record >= -80 )&&(record <= -75 ))
    {
        rssivalue = "twosignal.png";  
    }
    if ((record > -75 )&&(record <= -69 ))
    {
        rssivalue = "threesignal.png";  
    }
    if ((record > -69 )&&(record <= -63 ))
    {
        rssivalue = "foursignal.png"; 
    }
    if (record > -63 )
    {
        rssivalue = "fivesignal.png";  
    }
    return  rssivalue;
}

function IsLock(record)
{
    var security = "";
    if (!record)
    {
        return security;
    }
    if (record.toUpperCase() != "OPEN-NONE")
    {
        security = "lock.png";
    }
    else
    {
        security = "unlock.png";
    }
    return security;    
}

function AgoPage(cur)
{        
    var begin = (cur - 1) * pageSize;
    var end = cur * pageSize;
    return lastresult.slice(begin, end);
}  

function InitScanResule(str)
{
    var htmllines = "";
    var datas = AgoPage(str);
    var datasize = lastresult.length;
    var totalPage = Math.ceil(datasize/10);
    var neigAPlen = datas.length;
	var pageindex = pageSize*(str-1);
    var currpage = parseInt(str,10);
    $(".appendtr").remove();
    $("#pagebutton").remove();
    if (neigAPlen > 0)
    {

        for (var i = 0; i < neigAPlen; i++) 
        {
            htmllines += "<tr style= \"border: 1px solid #cccccc\" id=\"selectid_" + pageindex + "\" onClick= \"selectLineScanResult(this,this.id)\" class=\"appendtr\">";
            htmllines += "<td class=\"align_center\"><input type=\"radio\" id=\"neigAP_" + i + "\" name=\"selectwlan\"></td>"
            htmllines += "<td class=\"align_center\">"+ (pageindex + 1) + "</td>";
            htmllines += "<td class=\"align_center\">"+htmlencode(datas[i].SSID)+"</td>";
            htmllines += "<td class=\"align_center\"><img src=\"../../../images/" + SignalIntensity(datas[i].RSSI) + "\"></td>";
            //htmllines += "<td class=\"align_center\">"+datas[i].Frequency+"</td>";
            htmllines += "<td class=\"align_center\">"+datas[i].BSSID+"</td>";
            htmllines += "<td class=\"align_center\"><img src=\"../../../images/" + IsLock(datas[i].Security) + "\"></td>";
            htmllines += "</tr>";
            pageindex++;
        }
    }
    else
    {
        htmllines  = "";
    }
    var pagehtml = "<tr class=\"align_left jumpbutton\" id=\"pagebutton\">";

    if (currpage == 1)
    {
    	pagehtml += "<td class=\"align_left page_jump prv\"><div class=\"prv\" id=\"prv\" onselsectstart=\"return false\"></div></td>";
    }
    else
    {
    	pagehtml += "<td class=\"align_left page_jump prv\"><div class=\"prv\" id=\"prv\" onClick=\"InitScanResule(" + (currpage - 1) + ");\" onselsectstart=\"return false\"></div></td>";
    }

    pagehtml += "<td class=\"align_center\"><select id=\"pagejump\" onChange=\"SelctPage();\"></select></td>";

    if (currpage == totalPage)
    {
    	pagehtml += "<td class=\"align_left page_jump next\"><div class=\"next\" id=\"next\" onselsectstart=\"return false\"></div></td>";
    }
    else
    {
    	pagehtml += "<td class=\"align_left page_jump next\"><div class=\"next\" id=\"next\" onselsectstart=\"return false\" onClick=\"InitScanResule(" + (currpage + 1) + ");\"></div></td>";
    }

    pagehtml += "<td style=\"width:88%\"></td></tr>"

    $("#wlanupmodescan").append(htmllines);

    $("#jumpbutton").append(pagehtml);

	InitPage();

	setSelect("pagejump",currpage);
}

function InitPage()
{
    var datasize = lastresult.length;
    var totalPage = Math.ceil(datasize/10);
    var appTempsLists = getElementById('pagejump');
    for (var i = 1; i <= totalPage; i++)
    {

        addOption("pagejump","",i,i);
    }
}

function GetAjaxResult()
{
        $.ajax({
            type : "post",
            async : true,
            url : "./getupneighbourAPinfo.asp",
            success : function(data) {    
                gNeighbourAP = dealDataWithFun(data);
                IsFrequency();
                GetResult();
				SetProgresstoAll();
            }
        }); 
        return  gNeighbourAP;        

}

function GetTriAjaxResult()
{
        $.ajax({
            type : "post",
            async : true,
            url : "./getupneighbourAPinfo.asp",
            success : function(data) {    
                gNeighbourAP = dealDataWithFun(data);
                IsFrequency();
                GetResult();
				SetProgresstoAll();

            }
        }); 
        return  gNeighbourAP;        

}

function  IsFrequency()
{
	for (var i = 0; i < gNeighbourAP.length-1; i++)
	{
        if (!isVaildeSecurity(gNeighbourAP[i]))
        {
            continue;
        }

        if (1 == TriBandFlag)
        {
            gNeighbourAP[i].Frequency = "5G";
            neighBour5g.push(gNeighbourAP[i]);
        }
        else
        {
            if(CaseBandFre == 4)
            {
                if (gNeighbourAP[i].domain.indexOf(node2G) != 0)
                {
					gNeighbourAP[i].Frequency = "5G";
					neighBour5g.push(gNeighbourAP[i]);
				}
				if (gNeighbourAP[i].domain.indexOf(node5G) != 0)
				{
					gNeighbourAP[i].Frequency = "2.4G";
					neighBour2g.push(gNeighbourAP[i]);
				}
            } else if(CaseBandFre == 2) {
				if (gNeighbourAP[i].domain.indexOf(node2G) != 0) {
					gNeighbourAP[i].Frequency = "5G";
					neighBour5g.push(gNeighbourAP[i]);
				}
			} else if(CaseBandFre == 1) {
				if (gNeighbourAP[i].domain.indexOf(node5G) != 0) {
					gNeighbourAP[i].Frequency = "2.4G";
					neighBour2g.push(gNeighbourAP[i]);
				}
			}
        }
    }
}

function check(SecurityMode, value)
{
    if ( null == value )
    {
        return false;
    }

    if(SecurityMode == 'OPEN-WEP' || SecurityMode == 'SHARED-WEP' || SecurityMode == 'OPEN/SHARED-WEP')
    {
       if ( value != '' && value != null)
       { 
           if (isValidKey(value, 13) == false && isValidKey(value, 5) == false)
           {
               AlertEx(cfg_wlanupmode_db_language['amp_wlanupmode_invalidkey']);
               return false;
           }
       }
       else
       {
           AlertEx(cfg_wlanupmode_db_language['amp_wlanupmode_invalidkey2']);
           return false;
       }    
    }

    var AuthMode =  getAuth(SecurityMode);  
    if(AuthMode == 'WPA-PSK' || AuthMode == 'WPA2-PSK' || AuthMode == 'WPA/WPA2-PSK')
    {
        if (value == '')
        {
            AlertEx(cfg_wlanupmode_db_language['amp_wlanupmode_emptypara']);
            return false;
        }

         if (isValidWPAPskKey(value) == false)
        {
            AlertEx(cfg_wlanupmode_db_language['amp_wlanupmode_wpskeyinvalid']);
            return false;
        }
    }
        
    return true;
}

function getAuth(SecurityMode)
{
    return  SecurityMode.substr(0, SecurityMode.lastIndexOf('-'));
}

function isVaildeSecurity(item)
{
    var Security = item.Security;
    var auth = getAuth(Security);
    var tmp = Security.split('-');
    var encrpt = tmp[tmp.length-1];
    if ('WEP' == encrpt)
	{
		return false;
	}
    if('OPEN' == auth && ('NONE' == encrpt || 'WEP' == encrpt))
    {
        return true;
    }
	if ('OPEN/SHARED' == auth && 'WEP' == encrpt)
	{
		return true;
	}
    if('SHARED' == auth && 'WEP' == encrpt)
    {
        return true;
    }
    if(('WPA-PSK' == auth || 'WPA2-PSK' == auth || 'WPA/WPA2-PSK' == auth) && ('AES' == encrpt || 'TKIP' == encrpt || 'TKIP/AES' == encrpt))
    {
        return true;
    }
}

function compare(str)
{
    return function(a,b)
    {
        var value1 = a[str];
        var value2 = b[str];
        return value2 - value1;
    }
}

function GetResult()
{
	var neighBour2glen = neighBour2g.length;
	var neighBour5glen = neighBour5g.length;
	neighBour2g.sort(compare('RSSI'));
	neighBour5g.sort(compare("RSSI"));

	var newlen = neighBour5glen > neighBour2glen ?neighBour5glen:neighBour2glen;
	for (var i = 0; i < newlen;  i += 5)
    {
		var first2g,first5g;
		first5g = neighBour2g.slice(i, (i+5));
		first2g = neighBour5g.slice(i, (i+5));
		lastresult = lastresult.concat(first2g).concat(first5g);
    }
}



function LoadFrame()
{		
	if (1 == TriBandFlag)
	{
		times = setInterval("setPrograss()",110);
	
		setTimeout("GetTriAjaxResult()",200);
	}
	else
	{
		times = setInterval("setPrograss()",50);
		setTimeout("GetAjaxResult()",200);
	}

    window.parent.adjustParentHeight();
}

function DisableRFband()
{
    var TribandFlag = '<%HW_WEB_GetFeatureSupport(FT_WLAN_TRIBAND_AP);%>';
	
	if (1 != TribandFlag)
	{
		return;
	}
}

function setTab(name,cursel,n){

    for (var i=1; i <= n;i++){

        var menu=document.getElementById(name+i);

        var con=document.getElementById("con_"+name+"_"+i);

        menu.className=((i==cursel)?"hover":"");

        con.style.display=((i==cursel)?"block":"none");

    }
    if (cursel ==1)
    {
        manualinput = false;
    }
    else
    {
		DisableRFband();
        DisplaySSID();
        manualinput = true;
    }
}

function DisplaySSID()
{
    var encryptvalue = getSelectVal("importencrypt");

    if (encryptvalue == "OPEN-NONE")
    {
        setDisplay("importpasswordRow",0);
    }
    else
    {
        setDisplay("importpasswordRow",1);
    }    
}

function OnChangeEncrypt()
{

    DisplaySSID();

}

function selectLineScanResult(str,id)
{

    var TableId = id.split('_')[1];

    var index = parseInt(TableId);

    var objTR = getElement(id);

    setLineHighLight(objTR);
    
    SetDivValue("wlanupmodessid", htmlencode(lastresult[index].SSID));

    setText("Bssid",lastresult[index].BSSID);

    SetDivValue("wlanupmodeencrypt", lastresult[index].Security);

    if (lastresult[index].Security == "OPEN-NONE")
    {
        setDisplay("wlanupmodepasswordRow",0);
    }
    else
    {
        setDisplay("wlanupmodepasswordRow",1);
    }

    var radiovalue = $(str).find("input[type=radio]");
    var flag = radiovalue.is(":checked");
    if (!flag){
        radiovalue.prop('checked', true);
    }
}

function getDivValue(sId)
{
    var item;
    if (null == (item = getElement(sId)))
    {
        debug(sId + " is not existed" );
        return -1;
    }

    return item.innerHTML;
}

function SelctPage()
{
    selectpage = getSelectVal("pagejump");

    InitScanResule(selectpage);
}

function ReScanWlan()
{
    window.location.reload();
}

function ExitGuide(val)
{
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : '/smartguide.cgi?1=1&RequestFile=index.asp',
		data: getDataWithToken('Parainfo=0', true),
		success : function(data)
		{
		}
	});

    window.top.location.href="/index.asp";
}

function NextGuide(val)
{
    var ParaList = "";

    if (manualinput)
    {
    
        if (false == check(getSelectVal('importencrypt'), getValue("importpassword")))
        {
            return;
        }

        ParaList = "&y.SSID=" + FormatSSIDEncode((getValue("importssid"))) + '&y.SecurityMode=' + getSelectVal('importencrypt') + '&y.Key=' + FormatUrlEncode(getValue("importpassword")) + "&y.BSSID=0";   

		ParaList += "&z.SSID=" + FormatSSIDEncode((getValue("importssid"))) + '&z.SecurityMode=' + getSelectVal('importencrypt') + '&z.Key=' + FormatUrlEncode(getValue("importpassword")) + "&z.BSSID=0"; 
    }
    else
    {
		var encryptDiv = getDivValue('wlanupmodeencrypt');
		var passwordValue = getValue("wlanupmodepassword");
        if (false == check(encryptDiv, passwordValue))
        {
            return;
        }  

		if ('OPEN/SHARED-WEP' == encryptDiv)
		{
			encryptDiv = 'OPEN-WEP';
		}
		
        ParaList = "&y.SSID=" + FormatSSIDEncode($("#wlanupmodessid").text()) + '&y.SecurityMode=' + encryptDiv + '&y.Key=' + FormatUrlEncode(passwordValue) + "&y.BSSID=" + getValue("Bssid");
		
		ParaList += "&z.SSID=" + FormatSSIDEncode($("#wlanupmodessid").text()) + '&z.SecurityMode=' + encryptDiv + '&z.Key=' + FormatUrlEncode(passwordValue) + "&z.BSSID=" + getValue("Bssid");
    }

	top.selectrepwlan = ParaList;

	if (curUserType == 0)
	{
		if(1 == DirectGuideFlag)
		{
			val.id= "guidesyscfg";
			val.name= "/html/ssmp/accoutcfg/guideaccountcfgAP.asp";
		}
		else
		{
			val.id= "guidecfgdone";
			val.name= "/html/ssmp/cfgguide/userguidecfgdone.asp?cfgguide=1";
		}

    }
	else
	{
		val.id= "guidesyscfg";
		val.name= "/html/ssmp/accoutcfg/guideaccountcfg.asp";
	}
	window.parent.onchangestep(val);

}

function SkipGuide(val)
{
    if (curUserType == 0)
    {
		if(1 == DirectGuideFlag)
		{
			val.id= "guidesyscfg";
			val.name= "/html/ssmp/accoutcfg/guideaccountcfgAP.asp";
		}else{
			val.id= "guidecfgdone";
			val.name= "/html/ssmp/cfgguide/userguidecfgdone.asp?cfgguide=1";
		}

    }
    else
    {
        val.id= "guidesyscfg";
        val.name= "/html/ssmp/accoutcfg/guideaccountcfg.asp";
    }
    
    window.parent.onchangestep(val);
}

</script>
<body class="mainbody" onLoad="LoadFrame();" id="repneighguide">
<div id="progress_bar" style="display:none">
    <div id="bssResult">
        <div id="bssResProg">
            <div id="bssResProgPer" style="margin-left:8px;"><span id="percent">0%</span></div>
            <div id="bssResProgBar">
                <div class="bssResProgBarHead"></div>
                <div id="bssResProgBarTotal">
                    <div id="progress"   class="bssResProgBarPerBg"><div class="ampResProgBarPer"></div></div>
                </div>
            </div>
        </div>
        <div id="bssPrompt" style="width: 200px;">
            <span id="regResult" BindText="amp_wlanupmode_scaning"></span>
        </div>
    </div>
</div>
<div id="Tab" style="display:none">
    <div class="Menubox">
        <ul>
            <li id="menu1" onClick="setTab('menu',1,2)" class="hover" BindText="amp_scan_network"></li>
            <li id="menu2" onClick="setTab('menu',2,2)" BindText="amp_other_network"></li>
        </ul>
    </div>
    <div class="Contentbox" id="scanresult">
        <div id="con_menu_1" class="hover">
            <div style="text-align: left;margin-bottom: 5px;padding: 5px 0;" BindText="amp_wlanupmode_reptitle"></div>
            <table class='width_per100' id="wlanupmodescan" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse;border: 1px solid #cccccc;">
                <tr class="head_title" id="showScanResult" style="border: solid #efefef">
                    <td class="">&nbsp;</td>
                    <td class="align_center" BindText = "amp_wlanupmode_id"></td>
                    <td class="align_center" BindText = "amp_wlanupmode_ssid"></td>
                    <td class="align_center" BindText = "amp_wlanupmode_singal"></td>
                    <td class="align_center" BindText = "amp_wlanupmode_mac"></td>
                    <td class="align_center" BindText = "amp_wlanupmode_encrypt"></td>
                </tr>
            </table>
            <table class="width_per100 choosepage" border="0" cellspacing="0" cellpadding="0" id="jumpbutton">

            </table>
            <form id="wlanupmodesetfrom" name="wlanupmodesetfrom">
                <table>
                    <li   id="wlanupmodeset"             RealType="HorizonBar"            DescRef="amp_wlanupmode_set"             RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"     BindField=""      InitValue="Empty"/>
                    <li   id="wlanupmodessid"             RealType="HtmlText"            DescRef="amp_wlanupmode_ssidmh"             RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"     BindField=""      InitValue="Empty"/>
                    <li   id="wlanupmodepassword"             RealType="TextBox"            DescRef="amp_wlanupmode_pwdmh"             RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"     BindField=""      InitValue="Empty"    MaxLength="64"/>                      
                    <li   id="wlanupmodeencrypt"             RealType="HtmlText"            DescRef="amp_wlanupmode_encryptmh"             RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"     BindField=""      InitValue="" ClickFuncApp=""  MaxLength="63"/>                  
                </table>
                <script>
                    var TableClass = new stTableClass("width_per15", "width_per85", "ltr");
                    HWParsePageControlByID("wlanupmodesetfrom", TableClass, cfg_wlanupmode_db_language, null);
                </script>
            </form>                      
        </div> 
        <div id="con_menu_2" style="display:none">
            <form id="importsetfrom" name="importsetfrom">
                <table>
                    <li   id="importssid"             RealType="TextBox"            DescRef="amp_wlanupmode_ssidmh"             RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"     BindField=""      InitValue="Empty"/>
                    <li   id="importencrypt"             RealType="DropDownList"            DescRef="amp_wlanupmode_encryptmh"             RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"     BindField=""      InitValue="[{TextRef:'OPEN_NONE',Value:'OPEN-NONE'},{TextRef:'WPA_PSK_AES',Value:'WPA-PSK-AES'},{TextRef:'WPA2_PSK_AES',Value:'WPA2-PSK-AES'},{TextRef:'WWPA2_PSK_AES',Value:'WPA/WPA2-PSK-AES'},{TextRef:'WPA_PSK_TKIP',Value:'WPA-PSK-TKIP'},{TextRef:'WPA2_PSK_TKIP',Value:'WPA2-PSK-TKIP'},{TextRef:'WWPA2_PSK_TKIP',Value:'WPA/WPA2-PSK-TKIP'},{TextRef:'WPA_PSK_TKIPA',Value:'WPA-PSK-TKIP/AES'},{TextRef:'WPA2_PSK_TKIPA',Value:'WPA2-PSK-TKIP/AES'},{TextRef:'WWPA2_PSK_TKIPA',Value:'WPA/WPA2-PSK-TKIP/AES'}]" ClickFuncApp="onchange=OnChangeEncrypt"  MaxLength="63"/>
                    <li   id="importpassword"             RealType="TextBox"            DescRef="amp_wlanupmode_pwdmh"             RemarkRef="Empty"              ErrorMsgRef="Empty"    Require="FALSE"     BindField=""      InitValue="Empty" MaxLength="64"/>                    
                </table>
                <script>
                    var TableClass = new stTableClass("width_per30", "width_per70", "ltr");
                    HWParsePageControlByID("importsetfrom", TableClass, cfg_wlanupmode_db_language, null);
                </script>
            </form>         
        </div>               
    </div>
    <table class='width_per100' border="0" cellspacing="0" cellpadding="0" id="submitbutton">
        <tr>
            <td class="title_bright1">
                <input type="hidden" name="BSSID" id="Bssid" value="">
                <input type="button" class="NewDelbuttoncss" BindText="amp_wlanupmode_exit" onClick="ExitGuide()">
                <input type="button" class="NewDelbuttoncss" BindText="amp_wlanupmode_other" onClick="NextGuide(this)">
                <input type="button" class="NewDelbuttoncss" BindText="amp_wlanupmode_resacne" onClick="ReScanWlan()">
                <input type="button" class="NewDelbuttoncss" BindText="amp_wlanupmode_skip" onClick="SkipGuide(this)">
            </td>
        </tr>
    </table>      
    <div class="func_spread"></div>    
</div> 
</body>
<script type="text/javascript">
    ParseBindTextByTagName(cfg_wlanupmode_db_language, "div",  1);
    ParseBindTextByTagName(cfg_wlanupmode_db_language, "td",  1);
    ParseBindTextByTagName(cfg_wlanupmode_db_language, "li",  1);
    ParseBindTextByTagName(cfg_wlanupmode_db_language, "span",  1);
    ParseBindTextByTagName(cfg_wlanupmode_db_language, "input", 2);
    ParseBindTextByTagName(cfg_wlanupmode_db_language, "th", 1);
</script>
</html>
