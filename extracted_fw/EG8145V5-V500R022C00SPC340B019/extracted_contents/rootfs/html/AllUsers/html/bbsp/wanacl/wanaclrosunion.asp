<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" />
<title>Wan Access Configuration</title>
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/userinfo.asp"></script>
<script language="javascript" src="../common/topoinfo.asp"></script>
<script language="javascript" src="../common/managemode.asp"></script>
<script language="javascript" src="../common/wan_list_info.asp"></script>
<script language="javascript" src="../common/wan_list.asp"></script>
<script language="javascript" src="../common/lanmodelist.asp"></script>
<script language="javascript" src="../common/<%HW_WEB_CleanCache_Resource(page.html);%>"></script>
<script language="javascript" src="../common/wan_check.asp"></script>
<script language="javascript" src="../common/wanaccesslist.asp"></script>    
<script>
	var CfgModeWord ='<%HW_WEB_GetCfgMode();%>'; 
    var FltsecLevel = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>'.toUpperCase();
    var CurSrcIpList;
    
    var appName = navigator.appName;
	var CfgMode ='<%HW_WEB_GetCfgMode();%>';
	var isRos = (CfgMode.toUpperCase() == "ROSUNION");
	var curUserType = '<%HW_WEB_GetUserType();%>';

	function wanwhitelist(domain,Enable,Port,SupportedProtocols,Protocol,IP,Mask,Interface)
	{
		this.domain = domain;
		this.Enable = Enable;
		if( '0' == Port)
		{
			Port = '';
		}
		this.Port = Port;
		this.SupportedProtocols = SupportedProtocols;
		this.Protocol = Protocol.toUpperCase();
		this.IP = IP;
		this.Mask = Mask;
		this.Interface = Interface;
	}
	
	var WANSrcWhiteList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.UserInterface.RemoteAccess.{i}, Enable|Port|SupportedProtocols|Protocol|IP|Mask|Interface, wanwhitelist);%>;

    function stipaddr(domain,enable) {
        this.domain = domain;
        this.enable = enable;
    }
    var LanIpInfos = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterSlaveLanHostIp, InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.{i},Enable,stipaddr);%>;
    var br00Enable = 0;
    if (LanIpInfos[1] == null) {
        br00Enable = 0;
    } else {
        br00Enable = LanIpInfos[1].enable;
    }
    

	function FilterAclList(list)
	{
		if (!isRos || '1' != curUserType)
			return;
		
		for (var i = list.length - 1; i >= 0; i--) {
			if (!list[i])
				continue;

			if (IsWanInternetCapable(list[i].Interface)) {
				if (list[i].Protocol.toUpperCase() != 'ICMP' 
				    && list[i].Protocol.toUpperCase() != 'HTTP'
					&& list[i].Protocol.toUpperCase() != 'HTTPS') {
					list.splice(i, 1);
				}
			}
			else {
				if (list[i].Protocol.toUpperCase() != 'ICMP') {
					list.splice(i, 1);
				}
			}
		}
	}
	
	FilterAclList(WANSrcWhiteList);

	function GetWanName(Domain)
	{
        if (Domain.indexOf("WANDevice") > -1) {
            for (var i = 0; i < GetWanList().length;i++) {
                if (GetWanList()[i].domain == Domain) {
                    return MakeWanName(WanList[i]);
                }
            }
        } else if (Domain.indexOf("LANDevice") > -1) {
            if (Domain.indexOf("2") > -1) {
                return "br0:0";
            } else {
                return "br0";
            }
        } else {
            return Domain;
        } 
    }
	
	function CreateWanAclList()
    { 
		var WanAclList = WANSrcWhiteList;
		var HtmlCode = "";
		var RecordCount = WanAclList.length - 1 ;
		var i = 0;
 
		if (FltsecLevel != 'CUSTOM')
		{
			RecordCount = 0;
		}

        if (RecordCount == 0)
        {
            HtmlCode += '<TR id="record_no" class="tabal_01 align_center " onclick="selectLine(this.id);">';
			HtmlCode += '<TD ' + bottomBorderClass(true) + '>--</TD>';
			HtmlCode += '<TD ' + bottomBorderClass(true) + '>--</TD>';
			HtmlCode += '<TD ' + bottomBorderClass(true) + '>--</TD>';
			HtmlCode += '<TD ' + bottomBorderClass(true) + '>--</TD>';
			HtmlCode += '<TD ' + bottomBorderClass(true) + '>--</TD>';
			HtmlCode += '<TD ' + bottomBorderClass(true) + '>--</TD>';
			HtmlCode += '<TD ' + bottomBorderClass(true) + '>--</TD>';
    	    HtmlCode += '</TR>';
    	    return HtmlCode;
        }
        
		for (i = 0; i < RecordCount; i++) {     
			HtmlCode += '<TR id="record_' + i + '" class="tabal_01 align_center "  onclick="selectLine(this.id);">';
			HtmlCode += '<TD' + bottomBorderClass(true) + '>' + '<input type="checkbox" name="rml" id = \"Recordrml_'+i+'\"'  + ' value=' + WanAclList[i].domain  + '>' + '</TD>';
			HtmlCode += '<TD class=\"restrict_dir_ltr' + bottomBorderClass(false) + '\" id = \"RecordWanName'+i+'\">' + GetWanName(WanAclList[i].Interface) + '</TD>';
			HtmlCode += '<TD ' + bottomBorderClass(true) + 'id = \"RecordProtocol'+i+'\">' + WanAclList[i].Protocol.toUpperCase() + '</TD>';
			HtmlCode += '<TD ' + bottomBorderClass(true) + 'id = \"RecordPort'+i+'\">' + WanAclList[i].Port.toUpperCase() + '</TD>';

			HtmlCode += '<TD ' + bottomBorderClass(true) + 'id = \"RecordSrcIp'+i+'\">' + WanAclList[i].IP.toUpperCase() + '</TD>';
			
			HtmlCode += '<TD ' + bottomBorderClass(true) + 'id = \"RecordMask'+i+'\">' + WanAclList[i].Mask.toUpperCase() + '</TD>';
			
			var enable = (WanAclList[i].Enable == 1) ? wan_acl_language['bbsp_td_enable']:wan_acl_language['bbsp_td_disable'];
			HtmlCode += '<TD ' + bottomBorderClass(true) + 'id = \"AclEnable' + i+ '\">' + enable   + '</TD>';

			HtmlCode += '</TR>';
		}

        return HtmlCode;

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
			b.innerHTML = wan_acl_language[b.getAttribute("BindText")];
        }
    }

	function IsWanInternetCapable(wanPath)
	{
		for (var i = 0; i < WanList.length; i++) {
			var w = WanList[i];
			if (w && w.domain == wanPath) {
				if (w.ServiceList.toUpperCase().indexOf("INTERNET") >= 0){
					return true;
				}
			}
		}
		return false;
	}
	
    function BindPageData(WanAclInfo)
    {
        setText("domain", WanAclInfo.domain);
   
        setCheck('WanAclEnable', WanAclInfo.Enable);
        setSelect("WanNameList", WanAclInfo.Interface);
		InitProtocolOption(InitProtocolOptionList(isRos, IsWanInternetCapable(WanAclInfo.Interface)));
		setSelect("ProtocolList", WanAclInfo.Protocol.toUpperCase());
		setText("destport", WanAclInfo.Port);
		setText("srcip", WanAclInfo.IP);
		setText("srcipmask", WanAclInfo.Mask);		 	
    }

    function GetWanAclData()
    {
        return new wanwhitelist(getValue("domain"),getCheckVal("WanAclEnable"), getValue("destport"),"TELNET,HTTP,ICMP,FTP,SSH,HTTPS", getSelectVal("ProtocolList"), getValue("srcip"),getValue("srcipmask"),getSelectVal("WanNameList"));
    }

	function setCtrlConfigPanel(iDisable)
	{
		setDisable("WanNameList", iDisable);
		setDisable("ProtocolList", iDisable);
		setDisable("destport", iDisable);
		setDisable("srcip", iDisable);
		setDisable("srcipmask", iDisable);
	}
	
    function OnPageLoad()
    {
        loadlanguage();
        return true;
    }    

    function clickRemove() 
    {
        return OnRemoveButtonClick();
    }
    
    
    function setControl(Index)
    {
        if (Index < -1)
        {
            return;
        }
        if (Index == -1)
        {
            SetAddMode();
            if (WANSrcWhiteList.length > 32)
            {
                AlertEx(wan_acl_language['bbsp_alert_recfull']);
                OnCancelButtonClick();
                return false;
            }
            return OnAddButtonClick();  
        }
        else
        {   
            SetEditMode();
            return OnEditButtonClick(Index);
        }
    }
    

    function OnAddButtonClick()
    {
		
        BindPageData(new wanwhitelist("","","","","","","",""));
        setDisplay("TableConfigInfo", "1");
		setCtrlConfigPanel(0);
        return false;   
    }
    

    function OnEditButtonClick(Index)
    {	    
        BindPageData(WANSrcWhiteList[Index]);
        setDisplay("TableConfigInfo", "1");
		setCtrlConfigPanel(0);
    	return false;           
    }  

    function OnRemoveButtonClick()
    {        
       
        var CheckBoxList = document.getElementsByName("rml");
        var Form = new webSubmitForm();
        var Count = 0;
      
        for (var i = 0; i < CheckBoxList.length; i++)
        {
            if (CheckBoxList[i].checked != true)
            {
                continue;
            }
            
            Count++;
            Form.addParameter(CheckBoxList[i].value,'');
        }
        if (Count <= 0)
        {
            return false;
        }
		setDisable("DeleteButton","1");
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        Form.setAction('del.cgi?' +'x=InternetGatewayDevice.UserInterface.RemoteAccess' + '&RequestFile=html/bbsp/wanacl/wanaclrosunion.asp');
        Form.submit();
        setDisable('ButtonApply',1);
    	setDisable('ButtonCancel',1);
        return false;        
    }
    
    function num2binstr(num, outputstrlen)
    {
        var outputstr = num.toString(2);
        var len = outputstr.length;

        for (var i = 0; i < outputstrlen - len; i++)
        {
            outputstr = '0' + outputstr;
        }

        return outputstr;
    }

    function IPv4Address2binstr(address)
    {
        var addrmum = IpAddress2DecNum(address);
        var addrbinstr = num2binstr(addrmum, 32);

        return addrbinstr;
    }
	
	function filtergetmaskLength(Mask)
	{
		var ulCount = 0;
		var ulmask;
		ulmask = SubnetAddress2DecNum(Mask);
		
		if(Mask == '')
			return '';

		while (ulmask != 0)
		{
			ulmask = ulmask << 1;
			ulCount++;
		}
		return ulCount;
	}

    function isIPv4AddrMaskValid(address, mask)
    {
        
        if((isAbcIpAddress(address) == false) 
            || (isDeIpAddress(address) == true) 
            || (isLoopIpAddress(address) == true) ) 
        {
            return false;
        }
		
		if(isValidSubnetMask(mask) == false)
		{
			return false;
		}
		
		var masklen = filtergetmaskLength(mask);
        if (false == CheckNumber(masklen, 1, 32))
        {
            return false;
        }

        var addrbinstr = IPv4Address2binstr(address);

        var masklenum = parseInt(masklen, 10);
        for (var i = masklenum; i < addrbinstr.length; i++)
        {
            if ('0' != addrbinstr.charAt(i))
                return false;
        }

        return true;
    }
    
    function IPv6Address2binstr(address)
    {
        var ipv6addr_bin = "";
        var ipv6addr = standIpv6Address(address);
        for (var i = 0; i < ipv6addr.length; i++)
        {
             var tmp = parseInt(ipv6addr[i], 16);
             ipv6addr_bin += num2binstr(tmp, 16);
        }
        
        return ipv6addr_bin;
    }

    function isIPv6AddrMaskValid(address, masklen)
    {
        if (CheckIpv6Parameter(address) == false)
        {
            return false;
        }
        
        var ipv6addr_bin = IPv6Address2binstr(address);
 
        var masklenum = parseInt(masklen, 10);
        for (var j = masklenum; j < ipv6addr_bin.length; j++)
        {
            if ('0' != ipv6addr_bin.charAt(j))
                return false;
        }

        if (false == CheckNumber(masklen, 1, 128))
        {
            return false;
        }

        return true;
    }

	function IsRepeateConfig(WanAclItem)
	{
		var i = 0;
		for(i = 0; i < WANSrcWhiteList.length-1; i++)
		{	
			if ( (WANSrcWhiteList[i].domain != WanAclItem.domain)
				&& (WANSrcWhiteList[i].Port == WanAclItem.Port)
				&& (WANSrcWhiteList[i].Protocol == WanAclItem.Protocol)          
				&& (WANSrcWhiteList[i].IP == WanAclItem.IP)
				&& (WANSrcWhiteList[i].Mask == WanAclItem.Mask)
				&& (WANSrcWhiteList[i].Interface == WanAclItem.Interface))
			{
				return true;
			}        
		}
		return false;
	}
    
    function GetSelectedWan(wanname)
    {
        var WanList = GetWanList(); 
        var i = 0;

        for (i = 0; i < WanList.length; i++)
        { 
            if (wanname == WanList[i].domain)
            {
                return WanList[i];
            }
        }
    }

    function OnApplyButtonClick()
    { 	
        var WanAclItem = GetWanAclData();
		
		if( WanAclItem.Protocol =='')
		{
			AlertEx(wan_acl_language['bbsp_alert_selproto']);
			return false;
		}
				
		if( WanAclItem.Port != 0 )
		{
			if( (false == isInteger(WanAclItem.Port) ) || ( parseInt(WanAclItem.Port,10) < 0 ) || ( parseInt(WanAclItem.Port,10) > 65535 ))
			{
				AlertEx(wan_acl_language['bbsp_alert_port']);
				return false;
			}		
		}

		var address = getValue("srcip");
		var mask = getValue("srcipmask");
        if ((address != "") && (mask != "")) {
            var valid = false;
            if (WanAclItem.Interface != "") {
                var interfaceTemp = WanAclItem.Interface;
                if (interfaceTemp.indexOf("WANDevice") > -1) {
                    var WanInfo = GetSelectedWan(WanAclItem.Interface);
                    if (address.indexOf(".") > 0) {
                        if (WanInfo.IPv4Enable != "1") {
                            AlertEx(wan_acl_language['bbsp_td_srciptype_invalid']);
                            return false;
                        }
                        valid =  isIPv4AddrMaskValid(address, mask);
                    } else if (address.indexOf(":") > 0) {
                        if (WanInfo.IPv6Enable != "1") {
                            AlertEx(wan_acl_language['bbsp_td_srciptype_invalid']);
                            return false;
                        }
                        valid =  false;
                    }
                } else {
                    if (address.indexOf(".") > 0) {
                        valid =  isIPv4AddrMaskValid(address, mask);
                    }
                }
            } else {
                if (address.indexOf(".") > 0) {
                    valid = isIPv4AddrMaskValid(address, mask);
                } else if (address.indexOf(":") > 0) {
                    valid =  false;
                    }
                }

			if (false == valid)
			{
				AlertEx(wan_acl_language['bbsp_td_srcip_invalid']);
				return false;
			}
		}
		
		if ( true == IsRepeateConfig(WanAclItem) )
		{
			AlertEx(wan_acl_language['bbsp_ruleexist']);
			return false;
		}
        
        var Form = new webSubmitForm();

		if (IsAddMode() == true)
		{
			Form.addParameter('x.Enable',WanAclItem.Enable);
			Form.addParameter('x.Port',WanAclItem.Port);
			Form.addParameter('x.Protocol',WanAclItem.Protocol);
			Form.addParameter('x.IP', WanAclItem.IP);
			Form.addParameter('x.Mask', WanAclItem.Mask);
			Form.addParameter('x.Interface', WanAclItem.Interface);
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.setAction('add.cgi?' +'x=InternetGatewayDevice.UserInterface.RemoteAccess' + '&RequestFile=html/bbsp/wanacl/wanaclrosunion.asp');
		}
		else
		{
			Form.addParameter('x.Enable',WanAclItem.Enable);
			Form.addParameter('x.Port',WanAclItem.Port);
			Form.addParameter('x.Protocol',WanAclItem.Protocol);
			Form.addParameter('x.IP', WanAclItem.IP);
			Form.addParameter('x.Mask', WanAclItem.Mask);
			Form.addParameter('x.Interface', WanAclItem.Interface);		
			Form.addParameter('x.X_HW_Token', getValue('onttoken'));
			Form.setAction('set.cgi?' +'x='+WanAclItem.domain + '&RequestFile=html/bbsp/wanacl/wanaclrosunion.asp');
		}
		
        Form.submit();
        DisableRepeatSubmit();
        setDisable('ButtonApply',1);
    	setDisable('ButtonCancel',1);
        return false;
    }

    function OnCancelButtonClick()
    {
        if (WANSrcWhiteList.length > 1 && IsAddMode())
        {
            var tableRow = getElementById("xxxInst");
            tableRow.deleteRow(tableRow.rows.length-1);
        }
        setDisplay("TableConfigInfo", "0");
        return false;

    }
	
	function InitProtocolOptionList(isRos, isInetWan)
	{
		var ProtoList = new Array();
		if (isRos) {
			if ('1' == curUserType) {
				if (isInetWan) {
					ProtoList[0]= "ICMP";
					ProtoList[1]= "HTTP";
					ProtoList[2]= "HTTPS";
					return ProtoList;
				}
				else {
					ProtoList[0]= "ICMP";
					return ProtoList;
				}
			}
		}
		
		ProtoList[0]= "TELNET";
		ProtoList[1]= "HTTP";
		ProtoList[2]= "ICMP";
		ProtoList[3]= "FTP";
		ProtoList[4]= "SSH";
		ProtoList[5]= "HTTPS";
		return ProtoList;
	}

	function InitProtocolOption(ProtoList)
	{
		var ProtocolList = (ProtoList == null)?InitProtocolOptionList(false, false):ProtoList;
		var slct = getElById("ProtocolList");
		
		slct.options.length=0;		
		
		var NullOption = document.createElement("Option");
		NullOption.value = '';
		NullOption.innerText = '';
		NullOption.text = '';
		slct.appendChild(NullOption);
		
		for (i = 0; i < ProtocolList.length; i++)
		{    
			var Option = document.createElement("Option");
			Option.value = ProtocolList[i];
			Option.innerText = ProtocolList[i];
			Option.text = ProtocolList[i];
			slct.appendChild(Option);
		}
	}
	
	function InitWanListOption(WanListControlId, IsThisWanOkFunction)
	{
		var Control = getElById(WanListControlId);
		var WanList = GetWanListByFilter(IsThisWanOkFunction);
		var i = 0;
		var NullOption = document.createElement("Option");
		NullOption.value = '';
		NullOption.innerText = '';
		NullOption.text = '';
        Control.appendChild(NullOption);

        if (isRos) {
            var Option = document.createElement("Option");
            Option.value = "InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1";
            Option.innerText = "br0";
            Option.text = "br0";
            Control.appendChild(Option);

            if (br00Enable == 1) {
                var Option = document.createElement("Option");
                Option.value = "InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.2";
                Option.innerText = "br0:0";
                Option.text = "br0:0";
                Control.appendChild(Option);
            }
        }
		
		for (i = 0; i < WanList.length; i++)
		{
			var Option = document.createElement("Option");
			Option.value = WanList[i].domain;
			Option.innerText = MakeWanName1(WanList[i]);
			Option.text = MakeWanName1(WanList[i]);
			Control.appendChild(Option);
		}
	}
	
	function evtChangeProtocoList()
	{
		if (!isRos || '1' != curUserType)
			return;
		
		slct = getElementById('WanNameList');
		slctdomain = slct.options[slct.selectedIndex].value;
		
		InitProtocolOption(InitProtocolOptionList(isRos, IsWanInternetCapable(slctdomain)));
	}

</script>

</head>
<body onLoad="OnPageLoad();" class="mainbody"> 
<form id="ConfigForm">
<div id="PromptPanel">
<script language="JavaScript" type="text/javascript">
	HWCreatePageHeadInfo("wanacltitle", GetDescFormArrayById(wan_acl_language, "bbsp_mune"), GetDescFormArrayById(wan_acl_language, "bbsp_title_prompt_ros"), false);
</script> 
<div class="title_spread"></div>
  
</div>
  <script language="JavaScript" type="text/javascript">
    ((FltsecLevel == 'CUSTOM') ? writeTabCfgHeader : writeTabInfoHeader)('wacl','100%');
</script>
  <table class="tabal_bg" id="xxxInst" width="100%" cellspacing="1">
    <tr  class="head_title">
		<script>
			document.write('<td class="width_per5' + bottomBorderClass(false) + '" >&nbsp;</td>' +
						   '<td class="width_per30' + bottomBorderClass(false) + '" >');
			if (isRos) {
				document.write(wan_acl_language["bbsp_td_interface"]);
			} else {
				document.write(wan_acl_language["bbsp_td_wanname"]);
			}
			document.write('</td>' +
						   '<td class="width_per15' + bottomBorderClass(false) + '" BindText="bbsp_td_proto" ></td>' +
						   '<td class="width_per20' + bottomBorderClass(false) + '" BindText="bbsp_td_destport" ></td>' +
						   '<td class="width_per30' + bottomBorderClass(false) + '" BindText="bbsp_td_srcip" ></td>' +
						   '<td class="width_per20' + bottomBorderClass(false) + '" BindText="bbsp_td_srcipmask" ></td>' +
						   '<td class="width_per10' + bottomBorderClass(false) + '" BindText="bbsp_td_enable" ></td>');
		</script>
    </tr>
    <script>
        document.write(CreateWanAclList());
    </script>
    
  </table>
 
  <div id="TableConfigInfo" style="display:none">
   <div class="list_table_spread"></div>
  <table class="tabal_noborder_bg" class="tabCfgArea" border="0" cellpadding="0" cellspacing="1"  width="100%">
  <tr class="trTabConfigure displaynone">
      <td  class="table_title align_left width_per15" BindText='bbsp_td_instance'></td>
      <td  class="table_right">
      <input type=text id="domain"  class='width_150px' maxlength=255  ErrorMsg="" datatype="int" minvalue="0" maxvalue="253" default="0"/>                   
      </td>
  </tr>   

  <tr class="trTabConfigure">
      <td class="table_title align_left width_per15" BindText='bbsp_td_enable1'></td>
      <td class="table_right"> <input type='checkbox' id='WanAclEnable' name='WanAclEnable'> </td> 
  </tr>

  <tr class="trTabConfigure">
      <td class="table_title align_left width_per15">
            <script language="JavaScript" type="text/javascript">
                if (isRos) {
                    document.write(wan_acl_language["bbsp_td_interface1"]);
                } else {
                    document.write(wan_acl_language["bbsp_td_wanname2"]);
                }
            </script>
        </td>
        <td class="table_right"><select id="WanNameList"  class='width_200px restrict_dir_ltr' name="D1" onchange="evtChangeProtocoList();" ErrorMsg=""></select>
       </td>
  </tr>


  <tr class="trTabConfigure">
      <td class="table_title align_left width_per15" BindText='bbsp_td_proto2'></td>
	  <td class="table_right"><select id="ProtocolList"  class='width_200px restrict_dir_ltr' name="D1" ErrorMsg=""></select>
       <font color="red">*</font>
	   </td>
	   
  </tr>
  <tr class="trTabConfigure"> 
       <td class="table_title align_left width_per15" BindText='bbsp_td_destport'></td> 
       <td class="table_right"> <input id="destport"  name="destport"  type="text"/>
       </td>
  </tr> 
  
  <tr class="trTabConfigure"> 
       <td class="table_title align_left width_per15" BindText='bbsp_td_srcip1'></td> 
       <td class="table_right"> <input id="srcip"  name="srcip"  type="text"/>
       </td>
  </tr> 
  <tr class="trTabConfigure"> 
       <td class="table_title align_left width_per15" BindText='bbsp_td_srcipmask'></td> 
       <td class="table_right"> <input id="srcipmask"  name="srcipmask"  type="text"/>
       </td>
  </tr> 

  </table>
 
<table id="ConfigPanelButtons" width="100%" cellspacing="1" class="table_button">
    <tr>
        <td class='width_per15'>
        </td>
        <td class="table_submit pad_left5p">
			<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
            <button id="ButtonApply"  type="button" onclick="javascript:return OnApplyButtonClick();" class="ApplyButtoncss buttonwidth_100px" ><script>document.write(wan_acl_language['bbsp_app']);</script></button>
            <button id="ButtonCancel" type="button" onclick="javascript:OnCancelButtonClick();" class="CancleButtonCss buttonwidth_100px" ><script>document.write(wan_acl_language['bbsp_cancel']);</script></button>
        </td>
    </tr>
</table>
  </div>
  <script>
  InitProtocolOption(null);
  function IsRouteWan(Wan)
  {
      if (Wan.Mode =="IP_Routed")
      {
        return true;
      } 
      
      return false;
  }
  InitWanListOption("WanNameList", IsRouteWan);
  </script>
</form>
</body>
</html>