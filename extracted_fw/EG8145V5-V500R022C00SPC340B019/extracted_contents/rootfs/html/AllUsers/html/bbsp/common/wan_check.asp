var DisliteFeature = "<%HW_WEB_GetFeatureSupport(BBSP_FT_BTV_WAN_PROTOCOL_IGNORE);%>";
var selctIndex = -1;
var MngtGdct = '<%HW_WEB_GetFeatureSupport(BBSP_FT_GDCT);%>';
var MultiWanIpFeature = '<%HW_WEB_GetFeatureSupport(FT_WAN_MULTI_IP);%>';
var TDESME2Modeflg ='<%HW_WEB_GetFeatureSupport(FT_FEATURE_TDESME2);%>';
var TelmexFlag = '<%HW_WEB_GetFeatureSupport(FT_PRODUCT_TELMEX);%>';

var specPPPOEUsername = '<%HW_WEB_GetSPEC(BBSP_SPEC_WANPPP_NAME_REGEX.string);%>';
var specPPPOEPassword = '<%HW_WEB_GetSPEC(BBSP_SPEC_WANPPP_PWD_REGEX.string);%>';
var Custom_cmcc_rms =  '<%HW_WEB_GetFeatureSupport(BBSP_FT_CMCC_RMS);%>';
var isSupportVLAN0 = '<%HW_WEB_GetFeatureSupport(BBSP_FT_WAN_VLAN0_TAG);%>';
var isPTVDF = '<%HW_WEB_GetFeatureSupport(BBSP_FT_PTVDF);%>';
var IsTedata = '<%HW_WEB_GetFeatureSupport(HW_FT_FEATURE_DTEDATA);%>';
var vxlanfeature = <%HW_WEB_GetFeatureSupport(FT_VXLAN);%>;
var showWanName = '<%HW_WEB_GetFeatureSupport(FT_WEB_SHOW_WANNAME);%>';
var isSupportLte = '<%HW_WEB_GetFeatureSupport(FT_LTE_SUPPORT);%>';
var supportUnnumberMode = '<%HW_WEB_GetFeatureSupport(BBSP_FT_UNNUMBERD_MODE);%>';
var isSupportHybrid = '<%HW_WEB_GetFeatureSupport(BBSP_FT_HYBRID);%>';
var vlanRepeate = '<%HW_WEB_GetFeatureSupport(FT_WEB_VLAN_NOREPEATE);%>';

function LinkConfig(domain, LinkType, DestinationAddress, ATMEncapsulation, ATMQoS, ATMPeakCellRate, ATMMaximumBurstSize, ATMSustainableCellRate)
{
    this.domain      = domain;
    this.LinkType    = LinkType;
    this.DestinationAddress   = DestinationAddress;
    this.ATMEncapsulation     = ATMEncapsulation;
    this.ATMQoS               = ATMQoS;
    this.ATMPeakCellRate      = ATMPeakCellRate;
    this.ATMMaximumBurstSize  = ATMMaximumBurstSize;
    this.ATMSustainableCellRate = ATMSustainableCellRate;
}
var DSLLinkConfigList =  <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANConnectionDevice.{i}.WANDSLLinkConfig, LinkType|DestinationAddress|ATMEncapsulation|ATMQoS|ATMPeakCellRate|ATMMaximumBurstSize|ATMSustainableCellRate, LinkConfig);%>;

function trim(str)
{
   if (str.charAt(0) == " ")
   {
      str = str.substring(1, str.length);
      str = trim(str);
   }
   if (str.charAt(str.length - 1) == " ")
   {
      str = str.substring(0, str.length - 1);
      str = trim(str);
   }
   return str;
}


function IsIPv6AddressUshortValid(Short)
{
    if (Short.length > 4)
    {
        return false;
    }
    
    for (var i = 0; i < Short.length; i++)
    {
        var Char = Short.charAt(i);
        if (!((Char >= '0' && Char <= '9') || (Char >= 'a' && Char <= 'f') || (Char >= 'A' && Char <= 'F')))
        {
            return false;
        }
    }
    
    return true;
}

function IsStandardIPv6AddressValid(Address)
{
    if ((Address.charAt(0) == ':') || (Address.charAt(Address.length-1) == ':'))
    {
        return false;
    }    
    
    List = Address.split(":");
    if (List.length > 8)
    {
        return false;
    }

    for (var i = 0; i < List.length; i++)
    {
        if (false == IsIPv6AddressUshortValid(List[i]))
        {
            return false;
        }
    }    
    
    return true;   
}

function IsIPv6AddressValid(Address)
{
    if (Address == "::")
    {
        return true;
    }

    if (Address.length < 3)
    {
        return false;
    }

    var List = Address.split("::");
    if (List.length > 2)
    {
        return false;
    }
    
    if (List.length == 1)
    if (Address.split(":").length != 8)
    {
        return false;
    }
    
    if (List.length > 1)
    if (Address.split(":").length > 8)
    {
        return false;
    }

    List = Address.split("::");
    for (var i = 0; i < List.length; i++)
    {
        if (false == IsStandardIPv6AddressValid(List[i]))
        {
            return false;
        }
    }
    return true;
}


function IsIPv6ZeroAddress(Address)
{
    for (var i = 0; i < Address.length; i++)
    {
        if (Address.charAt(i) != '0' && Address.charAt(i) != ':')
        {
            return false;
        }
    }
    
    return true;
}


function IsIPv6LoopBackAddress(Address)
{
    if (Address.substr(Address.length-1,1) == "1")
    {
        if (IsIPv6ZeroAddress(Address.substr(0, Address.length-1)+"0") == true)
        {
            return true;
        }
    }
    return false;
}

function IsIPv6LinkLocalAddress(Address)
{
    var IntAddress = parseInt(Address.toUpperCase().substr(0, 4), 16);
    var StartAddress = parseInt("FE80", 16);
    var EndAddress = parseInt("FEBF", 16);
    return (IntAddress >= StartAddress && IntAddress <= EndAddress) ? true : false; 
}

function IsIPv6SiteLocalAddress(Address)
{
    var IntAddress = parseInt(Address.toUpperCase().substr(0, 4), 16);
    var StartAddress = parseInt("FEC0", 16);
    var EndAddress = parseInt("FEFF", 16);
    return (IntAddress >= StartAddress && IntAddress <= EndAddress) ? true : false; 
}

function IsIPv6MulticastAddress(Address)
{
    return (parseInt(Address.split(":")[0], 16) >= parseInt("0xFF00", 16)) ? true : false;
}

function IsIPv6UlaAddress(Address)
{
    var firstAddress = Address.split(":")[0];
    
    if(firstAddress.length != 4)
    {
        return false;
    }

    if ((parseInt(firstAddress.substr(0, 2), 16) == parseInt("0xFD", 16))
        || (parseInt(firstAddress.substr(0, 2), 16) == parseInt("0xFC", 16)))
    {
        return true;
    }
    
    return false;
}

function CheckIpv6Parameter(IPv6Address)
{
    if (IsIPv6AddressValid(IPv6Address) == false)
    {
        return false;
    }

    if (IsIPv6MulticastAddress(IPv6Address) == true)
    {
        return false;  
    } 

    if (IsIPv6ZeroAddress(IPv6Address) == true) 
    {
        return false;
    }

    if (IsIPv6LoopBackAddress(IPv6Address) == true)
    {
        return false;  
    }
    return true; 
}

function isValidVenderClassID(val)
{
    for ( var i = 0 ; i < val.length ; i++ )
    {
        var ch = val.charAt(i);
        if (ch == '&' || ch == '*' || ch == '(' || ch == ')'
            || ch == '`' || ch == ';' || ch == '\"' || ch == '\'' 
            || ch == '<' || ch == '>' || ch == '#' || ch == '|')
        {
            return ch;
        }
    }
    return '';
}

function isTTValidVenderClassID(val)
{
    for ( var i = 0 ; i < val.length ; i++ )
    {
        var ch = val.charAt(i);
        if (ch == '&' || ch == '*' || ch == '(' || ch == ')'
            || ch == '`' || ch == ';' || ch == '\"' || ch == '\'' 
            || ch == '#' || ch == '|')
        {
            return ch;
        }
    }
    return '';
}
function SearchTr069WanInstanceId(curwan)
{
    var CurWanService = '';
    var Wan = GetWanList();
    
    for(var i = 0; i < Wan.length; i++)
    {
        CurWanService = Wan[i].ServiceList;
        if (CurWanService.indexOf("TR069") >=0 )
        {
            if( curwan.domain != Wan[i].domain)
            {
                return Wan[i].domain;
            } else {
                break;
            }
        }
    }
    
    return "";
}

function CheckIPv6AddrMaskLenE8c(wan)
{
    if (isNaN(wan.IPv6AddrMaskLenE8c) == true || parseInt(wan.IPv6AddrMaskLenE8c,10) < 10 
    || parseInt(wan.IPv6AddrMaskLenE8c,10) > 128 || isNaN(wan.IPv6AddrMaskLenE8c.replace(' ', 'a')) == true)
    {
        return false;     
    }
    return true;
}


function CheckDstIPForwardingCfg(Wan)
{
  var DstIPForwardingList = Wan.DstIPForwardingList;
  var ipStart;
  var ipEnd;
  var ipList;

  if(!DstIPForwardingList.length)
  {
      return true;
  }

  DstIPForwardingList = DstIPForwardingList.split(",");
    var checkflag = false;
    for (var i = 0; i < DstIPForwardingList.length; i++)
    {    
        if(DstIPForwardingList[i] == "")
        {
            AlertEx(dst_ip_forwarding_cfg_ctc_language['bbsp_dst_ip_forwarding_invalid_formate']);
            return false;
        }
        checkflag = false;
        for(var j = 0; j < DstIPForwardingList[i].length; j++ )
        {
            var ch = DstIPForwardingList[i].charAt(j);
            if(ch == '-')
            {
                checkflag = true;
                break;
            }
        }
        if(checkflag)
        {
            ipList = DstIPForwardingList[i].split("-");

            if (ipList.length != 2)
            {
                AlertEx(dst_ip_forwarding_cfg_ctc_language['bbsp_dst_ip_forwarding_invalid_formate']);
                return false;
            }
        

            ipStart = ipList[0];
            ipEnd   = ipList[1];
            
            if(("" == ipStart) || ("" == ipEnd))
            {
                AlertEx(dst_ip_forwarding_cfg_ctc_language['bbsp_dst_ip_forwarding_invalid_formate']);
                return false;
            }
            
            if (false == (CheckIpAddressValid(ipStart)))
            {
                AlertEx(dst_ip_forwarding_cfg_ctc_language['bbsp_dst_ip_forwarding_ip_error']+"("+ipStart+")");
                return false;
            }
            if (false == (CheckIpAddressValid(ipEnd)))
            {
                AlertEx(dst_ip_forwarding_cfg_ctc_language['bbsp_dst_ip_forwarding_ip_error']+"("+ipEnd+")");
                return false;
            }
            
            if (ipEnd != "" && ipStart != "" 
                && (IpAddress2DecNum(ipStart) > IpAddress2DecNum(ipEnd)))
            {
                AlertEx(ipStart+ dst_ip_forwarding_cfg_ctc_language['bbsp_dst_ip_forwarding_ip_error2'] +ipEnd);
                return false;         
            }
            
            
        }
        else
        {
            ipStart = DstIPForwardingList[i];
            ipEnd = DstIPForwardingList[i];
        }
        
        
        if (false == (CheckIpAddressValid(ipStart)))
        {
            AlertEx(dst_ip_forwarding_cfg_ctc_language['bbsp_dst_ip_forwarding_ip_error']+"("+ipStart+")");
            return false;
        }

        if (false == (CheckIpAddressValid(ipEnd)))
        {
            AlertEx(dst_ip_forwarding_cfg_ctc_language['bbsp_dst_ip_forwarding_ip_error']+"("+ipEnd+")");
            return false;
        }
        
    }

    return true;
}

function isSameIPv6SubNet(Ip1,Ip2,IPv6MaskLen) 
{
    var count = 0;
    var i = 0;
    var j = 0;
    var strMask = "";
    var Ip1_str = ":0:";
    var Ip2_str = ":0:";
    var Ip1_list = Ip1.split('::');
    var Ip2_list = Ip2.split('::');
    
    if(Ip1_list.length == 1)
    {
        Ip1_list = Ip1;
    }
    if(Ip2_list.length == 1)
    {
        Ip2_list = Ip2;
    }
   
    if(Ip1_list.length == 2)
    {
        if(Ip1_list[0] == "")
        {
            Ip1_list[0] = "0";
        }
        if(Ip1_list[1] == "")
        {
            Ip1_list[1] = "0";
        }
        Ip1_list1 = Ip1.split(':');
        for(i = 0; i < 8 - Ip1_list1.length; i++ )
        {
            Ip1_str += "0:";
        }
        Ip1_list = Ip1_list[0] + Ip1_str +  Ip1_list[1];
    }
    
    if(Ip2_list.length == 2)
    {
        if(Ip2_list[0] == "")
        {
            Ip2_list[0] = "0";
        }
        if(Ip2_list[1] == "")
        {
            Ip2_list[1] = "0";
        }
        Ip2_list2 = Ip2.split(':');
        for(j = 0; j < 8 - Ip2_list2.length; j++ )
        {
            Ip2_str += "0:";
        }
        Ip2_list = Ip2_list[0] + Ip2_str +  Ip2_list[1];
    }

    if(IPv6MaskLen == "")
    {
        IPv6MaskLen = 64;
    }
    for(i = 0; i< 128 ;i++)
    {
        if(i < IPv6MaskLen)
        {
            strMask += "1";
        }
        else
        {
            strMask += "0";
        }
        if((i+1)%16 == 0)
        {
            strMask += ":";
        }
    }
    strMask = strMask.substring(0,strMask.lastIndexOf(':'));
   
    lanm = strMask.split(':');
    lan1a = Ip1_list.split(':');
    lan2a = Ip2_list.split(':');
    
    for(i = 0; i < 8; i++)
    {
        l1a_n = parseInt(lan1a[i],16);
        l2a_n = parseInt(lan2a[i],16);
        lm_n = parseInt(lanm[i],2);
        if ((l1a_n & lm_n) == (l2a_n & lm_n))
        count++;
    }
   
    if (count == 8)
        return true;
    else
        return false;
}


function GetRouteWanCount()
{
    var WanList = GetWanList();
    var Count = 0; 
    for (var i = 0; i < WanList.length; i++)
    {
        if (WanList[i].Mode == "IP_Routed")
        {
            Count++;
        }
    }
    
    return Count;
}

function isNum(str)
{
    var valid=/[0-9]/;
    var i;
    for(i=0; i<str.length; i++)
    {
        if(false == valid.test(str.charAt(i)))
        {
            return false;
        }
    }
    return true;
}

var errmsg="";
var ERR_MUST_INPUT=1;
var ERR_First_CHAR_NOT_ZERO=ERR_MUST_INPUT+1;
var ERR_MUST_NUM=ERR_First_CHAR_NOT_ZERO+1;
var ERR_NOT_IN_RANGE=ERR_MUST_NUM+1;
var ERR_NOT_IN_RANGE_MVLAN=ERR_NOT_IN_RANGE+1;
var ERR_NOT_IN_MVLAN_NOT_EQUAL=ERR_NOT_IN_RANGE_MVLAN+1;
var INFO_MODIFIED_CONFIRM=ERR_NOT_IN_MVLAN_NOT_EQUAL+1;

function getErrorMsg(fieldPrompt,errcode)
{

    var error=new Array("","MustBeInput","IsNumFirstChar","IsNum","VlanIDRange","MVlanIDRange","MVlanIDEuqal","ModifiedConfirmInfo");

    var errorCN=new Array("","VLAN必须输入","VLAN ID第一个字符不能为0","VLAN ID不合法，它只能是数字","VLAN ID 范围1~4094","VLAN ID 范围0~4094","IPv4和IPv6组播VLAN必须相等","更改可能会影响绑定。是否继续？");
    
  if(fieldPrompt!="")
  {
    return GetLanguage(fieldPrompt)+GetLanguage(error[errcode]);   
  }else 
  {
     return errorCN[errcode];
  }
}

function stBondingInfo(domain,Enable, BondingInterface)
{  
    this.domain = domain;
    this.Enable = Enable;
    this.BondingInterface = BondingInterface;
}

var defaultWanDomain = ["InternetGatewayDevice.WANDevice.2.WANConnectionDevice.1.WANPPPConnection.1",
                        "InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANPPPConnection.1",
                        "InternetGatewayDevice.WANDevice.2.WANConnectionDevice.1.WANIPConnection.1",
                        "InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1"];

var bondingInfoArray = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecParaBondingInfoPara, InternetGatewayDevice.Services.X_HW_Bonding, Enable|BondingInterface,stBondingInfo);%>;
var CfgModeWord = '<%HW_WEB_GetCfgMode();%>';

function checkVlanID(VlanID,fieldPrompt)
{
    if ((CfgModeWord.toUpperCase() == "HT") || (CfgModeWord.toUpperCase() == "OTE")) {
        var VlanIDInDatebase = 0;
        var wan = GetPageData();
        var wanInDatebase = GetWanList();

        for (var i = 0; i < wanInDatebase.length; i++) {
            if (wanInDatebase[i].domain == wan.domain) {
                VlanIDInDatebase = wanInDatebase[i].VlanId;
            }
        }
        if ((bondingInfoArray[0].Enable == 1) && (VlanIDInDatebase != VlanID)) {
            if (bondingInfoArray[0].BondingInterface != "") {
                if (bondingInfoArray[0].BondingInterface == wan.domain) {
                    return getErrorMsg(fieldPrompt,INFO_MODIFIED_CONFIRM);
                }
            } else {
                for (var i = 0;i < defaultWanDomain.length; i++) {
                    if (wan.domain == defaultWanDomain[i]) {
                        return getErrorMsg(fieldPrompt,INFO_MODIFIED_CONFIRM);
                    }
                }
            }
        }
    }

    if('' == VlanID)
    {
        return getErrorMsg(fieldPrompt,ERR_MUST_INPUT);
    }
    if ( VlanID.length > 1 && VlanID.charAt(0) == '0' )
    {
        return getErrorMsg(fieldPrompt,ERR_First_CHAR_NOT_ZERO);
    }
    if( false == isInteger(VlanID) )
    {
        return getErrorMsg(fieldPrompt,ERR_MUST_NUM);
    }
    if ( false == CheckNumber(VlanID,1, 4094) )
    {
        return getErrorMsg(fieldPrompt,ERR_NOT_IN_RANGE);
    }

    return "";
}

function checkMVlanID(VlanID,fieldPrompt)
{
    if('' == VlanID)
    {
        return getErrorMsg(fieldPrompt,ERR_MUST_INPUT);
    }
    if ( VlanID.length > 1 && VlanID.charAt(0) == '0' )
    {
        return getErrorMsg(fieldPrompt,ERR_First_CHAR_NOT_ZERO);
    }
    if( false == isInteger(VlanID) )
    {
        return getErrorMsg(fieldPrompt,ERR_MUST_NUM);
    }
    if ( false == CheckNumber(VlanID,0, 4094) )
    {
        return getErrorMsg(fieldPrompt,ERR_NOT_IN_RANGE_MVLAN);
    }

    return "";
}

function CheckRouteBridgeCoexist(newWan, existWan)
{
    if (('PPPoE_Bridged' == newWan.Mode) || ('IP_Bridged' == newWan.Mode))
    {
        if ('IP_Routed' == existWan.Mode)
        {
            return true;
        }
    }
    else if ('IP_Routed' == newWan.Mode)
    {
        if (('PPPoE_Bridged' == existWan.Mode) || ('IP_Bridged' == existWan.Mode))
        {
            return true;
        }
    }
    return false;
}

function CheckForSession(Wan, AddFlag)
{
    if (AddFlag != 2)
    {
        return true;
    }
    
    var SessionVlanLimit  = "<% HW_WEB_GetFeatureSupport(BBSP_FT_MULT_SESSION_VLAN_LIMIT);%>";
    if (SessionVlanLimit == 0)
    {
        return true;
    }
    var wanConInst = GetWanInfoSelected().domain.split(".")[4];
    var domainTmp = 'InternetGatewayDevice.WANDevice.1.WANConnectionDevice.' + wanConInst + '.';
    var wanListTmp = GetWanList();
    var maxCnt = 1;
    var tmpCnt = 0;
    
    for (var  index1=0; index1 < wanListTmp.length; index1++ )
    {
      
        if (wanListTmp[index1].domain.indexOf(domainTmp) >= 0)
        {
            tmpCnt++;
        }
        
        if (tmpCnt > maxCnt)
        {
            AlertMsg("SessionIsFull");
            return false;
        }
    }

    return true;
}

function CheckMtu(Wan)
{
    
    var maxMtuCfg = getMtuMaxAllowCfg(Wan);
    var specIPoEMTUMax = '<%HW_WEB_GetSPEC(SPEC_LOWER_LAYER_MAX_MTU.UINT32);%>'

    if(Wan.IPv6Enable == 0)
    {
        if ((false == isNum(Wan.IPv4MXU)) || isNaN(Wan.IPv4MXU) || parseInt(Wan.IPv4MXU,10) > maxMtuCfg || parseInt(Wan.IPv4MXU,10) < 1)
        {
           if ('1500' == specIPoEMTUMax)
            {
                if (Custom_cmcc_rms == '1') {
                    AlertMsg("IPv4MxuAlertCMCC");
                } else {
                    AlertMsg("IPv4MxuAlert");
                }
                return false;
            }
            else
            {
                Wan.EncapMode.toUpperCase() == "PPPOE"? AlertMsg("MRUInvalid"):AlertMsg("MTUInvalid");            
            }
            return false;
        }
        
        if ( Wan.IPv4MXU.length > 1 && Wan.IPv4MXU.charAt(0) == '0' )
        {
              AlertMsg("IPv4MxuAlert1");
             return false;
        }
    }
    else
    {
        if (false == isNum(Wan.IPv4MXU) || isNaN(Wan.IPv4MXU) || parseInt(Wan.IPv4MXU,10) > maxMtuCfg || parseInt(Wan.IPv4MXU,10) < 1280)
        {
                if ('1500' == specIPoEMTUMax)
                {
                    if (Custom_cmcc_rms == '1') {
                        AlertMsg("IPv6MxuAlertCMCC");
                    } else {
                        AlertMsg("IPv6MxuAlert");
                    }
                    return false;
                }
                else
                {
                        Wan.EncapMode.toUpperCase() == "PPPOE"? AlertMsg("MRUInvalid"):AlertMsg("MTUInvalid");        
                }
            return false;
        }
        
        if ( Wan.IPv4MXU.length > 1 && Wan.IPv4MXU.charAt(0) == '0' )
        {
             AlertMsg("IPv4MxuAlert1");
             return false;
        }
    }

    return true;
}

function CheckAtmWanPvc(pvc)
{
    var TempList = pvc.split("/");

    if ((CfgModeWord.toUpperCase() == "HT") || (CfgModeWord.toUpperCase() == "OTE")) {
        var VPIVCIInDatebase = 0;
        var wan = GetPageData();
        var wanInDatebase = GetWanList();

        for (var i = 0; i < wanInDatebase.length; i++) {
            if (wanInDatebase[i].domain == wan.domain) {
                VPIVCIInDatebase = wanInDatebase[i].DestinationAddress;
            }
        }
        if ((bondingInfoArray[0].Enable == 1) && (VPIVCIInDatebase != pvc)) {
            if (bondingInfoArray[0].BondingInterface != "") {
                if (bondingInfoArray[0].BondingInterface == wan.domain) {
                    if (ConfirmEx(Languages['ModifiedConfirmInfo']) == false) {	
                        return false;
                    }
                }
            } else {
                for (var i = 0;i < defaultWanDomain.length; i++) {
                    if (wan.domain == defaultWanDomain[i] ) {
                        if (ConfirmEx(Languages['ModifiedConfirmInfo']) == false) {	
                             return false;
                        }
                    }
                }
            }
        }
    }

    if (TempList.length != 2)
    {
        AlertMsg("PVCInvalid");
        return false;
    }
    
    if ((!isNum(TempList[0])) || (!isNum(TempList[1])))
    {
        AlertMsg("PVCInvalid");
        return false;                
    }
    
    if (!(parseInt(TempList[0],10) >= 0 && parseInt(TempList[0],10) <= 255))
    {
        AlertMsg("VPIInvalid");
        return false;
    }
    
    if (!(parseInt(TempList[1],10) >= 32 && parseInt(TempList[1],10) <= 65535))
    {
        AlertMsg("VCIInvalid");
        return false;
    }

    return true;
}


function CheckAtmWanLinkConifg(Wan)
{
    var XTM_MAX_PEAK_CELL_RATE = 2600;
    var XTM_MIN_PEAK_CELL_RATE = 50;

    var XTM_MAX_SUSTAINABLE_CELL_RATE = 2600;
    var XTM_MIN_SUSTAINABLE_CELL_RATE = 50;

    var XTM_MAX_MAX_BURST_SIZE = 32767;
    var XTM_MIN_MAX_BURST_SIZE = 1;
            
    if( 'UBR' != Wan.ATMQoS )
    {    
        if( Wan.ATMPeakCellRate > XTM_MAX_PEAK_CELL_RATE || Wan.ATMPeakCellRate < XTM_MIN_PEAK_CELL_RATE)
        {
            AlertMsg("PeakInvalid");
            return false;
        }
    }
    
    if ( 'VBR-nrt' == Wan.ATMQoS || 'VBR-rt' == Wan.ATMQoS)
    {
        if (Wan.ATMSustainableCellRate > XTM_MAX_SUSTAINABLE_CELL_RATE || Wan.ATMSustainableCellRate < XTM_MIN_SUSTAINABLE_CELL_RATE)
        {
            AlertMsg("SustainableInvalid");
            return false;
        }    

        if (Wan.ATMMaximumBurstSize > XTM_MAX_MAX_BURST_SIZE || Wan.ATMMaximumBurstSize < XTM_MIN_MAX_BURST_SIZE)
        {
            AlertMsg("MaxBurstInvalid");
            return false;
        }                       
            
        if (parseInt(Wan.ATMSustainableCellRate) > parseInt(Wan.ATMPeakCellRate) )
        {
            AlertMsg("SustainablePeakInvalid");
            return false;
        }
    }
    
    return true;
}

function CheckATMWanPVCAndLinkType(Wan)
{

    if(EditFlag  == "ADD")
    {
        if(Wan.LinkType.indexOf("PPPoA") >= 0 ||  Wan.LinkType.indexOf("IPoA") >= 0 )
        {
            for( var i = 0 ; i < DSLLinkConfigList.length - 1 ; i++ )
            {
                if( DSLLinkConfigList[i].DestinationAddress.replace("PVC:","") == Wan.DestinationAddress)
                {
                    AlertMsg("PVCUsederror");
                    return false;
                }
            }
        }
        else
        {
            for( var i = 0 ; i < DSLLinkConfigList.length - 1 ; i++ )
            {
                if(DSLLinkConfigList[i].LinkType.indexOf("PPPoA") >= 0 ||  DSLLinkConfigList[i].LinkType.indexOf("IPoA") >= 0)
                {
                    if( DSLLinkConfigList[i].DestinationAddress.replace("PVC:","") == Wan.DestinationAddress)
                    {
                        AlertMsg("PVCUsederror");
                        return false;
                    }
                }
            }
        }
    }
    else
    {
        if(Wan.LinkType.indexOf("PPPoA") >= 0 ||  Wan.LinkType.indexOf("IPoA") >= 0 )
        {
            for( var i = 0 ; i < DSLLinkConfigList.length - 1 ; i++ )
            {
                if(DSLLinkConfigList[i].domain.split('.')[4] == Wan.domain.split('.')[4])
                {
                    continue;
                }
                    
                if( DSLLinkConfigList[i].DestinationAddress.replace("PVC:","") == Wan.DestinationAddress)
                {
                    AlertMsg("PVCUsederror");
                    return false;
                }
                    
            }
                
            for( var i = 0 ; i < GetWanList().length; i++ )
            {
                if( Wan.domain != GetWanList()[i].domain  && Wan.DestinationAddress ==  GetWanList()[i].DestinationAddress)
                {
                    AlertMsg("PVCUsederror");
                    return false;
                }
            }
                
        }
        else
        {
            for( var i = 0 ; i < DSLLinkConfigList.length - 1 ; i++ )
            {
                if(DSLLinkConfigList[i].domain.split('.')[4] == Wan.domain.split('.')[4])
                {
                    continue;
                }
                if(DSLLinkConfigList[i].LinkType.indexOf("PPPoA") >= 0 ||  DSLLinkConfigList[i].LinkType.indexOf("IPoA") >= 0)
                {
                    if( DSLLinkConfigList[i].DestinationAddress.replace("PVC:","") == Wan.DestinationAddress)
                    {
                        AlertMsg("PVCUsederror");
                        return false;
                    }
                }
            }
        }
    }    

    return true;
    
}

function CheckIPV4DNS()
{
    if (isPTVDF == "0")
    {
        return;
    }
    if ('1' == Wan.IPv4Enable && Wan.IPv4PrimaryDNS != '' && (isValidIpAddress(Wan.IPv4PrimaryDNS) == false || isAbcIpAddress(Wan.IPv4PrimaryDNS) == false))
    {
        AlertMsg("FirstDnsInvalid");
        return false;        
    }

    if ('1' == Wan.IPv4Enable &&  Wan.IPv4SecondaryDNS != '' && (isValidIpAddress(Wan.IPv4SecondaryDNS) == false || isAbcIpAddress(Wan.IPv4SecondaryDNS) == false))
    {
        AlertMsg("SecondDnsInvalid");
        return false;         
    }
}

function CheckAtmWan(Wan)
{
    if( 'DSL' != Wan.WanAccessType )
    {
        return true;
    }
    
    if(false == CheckAtmWanPvc(Wan.DestinationAddress))
    {
        return false;
    }
    
    if(false == CheckAtmWanLinkConifg(Wan))
    {
        return false;
    }
    
    if(false == CheckATMWanPVCAndLinkType(Wan))
    {
        return false;
    }
    
    return true;    
}

function shouldCheckMutilTr069Wan() {
    if (IsXdProduct()) {
        return false;
    }

    if ((CfgModeWord.toUpperCase() == "FIDNADESKAP") || (CfgModeWord.toUpperCase() == "PLVECTRAEBG")) {
        return false;
    }

    return true;
}

var FtBin5Enhanced = "<%HW_WEB_GetFeatureSupport(BBSP_FT_BIN5_ENHANCED);%>";
function CheckWan(Wan)
{    
    var RouteWanNum = GetRouteWanMax();

    if ((Wan.domain == null || (Wan.domain != null && Wan.domain.length < 10)) && GetRouteWanCount() >= RouteWanNum && Wan.Mode == "IP_Routed")
    {
        if (vxlanfeature == 0) {
            AlertMsg("RouteWanIsFull");
            return false;
        }
    }

    if ((CfgModeWord.toUpperCase() == "TS2WIFI") && (Wan.ServiceList.toUpperCase().indexOf("TR069") >= 0) && (EditFlag  == "ADD")) {
        AlertMsg("RouteWanIsFull");
        return false;
    }

    if ((BirdgetoRoute() == true) && GetRouteWanCount() >= RouteWanNum)
    {
        if (vxlanfeature == 0) {
            AlertMsg("RouteWanIsFull");
            return false;
        }
    }
    if ((vxlanfeature == 1) && (Wan.Mode != "IP_Routed")) {
        for (var i=0; i < GetWanList().length; i++) {
            if ((GetWanList()[i].domain != Wan.domain) && (GetWanList()[i].Mode != "IP_Routed") && (GetWanList()[i].VlanId == Wan.VlanId) && (Wan.VlanId != 0)) {
                if (getCheckVal('Vxlan_Enable') == 1) {
                    AlertMsg("NoRepeatBridgeVxlanWan");
                    return false;
                } else if ('<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>' != 1){
                    AlertMsg("NoRepeatVxlanBridgWan");
                    return false;
                } else if (GetWanList()[i].X_HW_VXLAN_Enable == 1) {
                    AlertMsg("NoRepeatVxlanBridgWan");
                    return false;
                }
            }
        } 
    }
     
     if((Wan.Mode.toUpperCase().indexOf("BRIDGE") >= 0) && 
     (Wan.ServiceList != 'INTERNET') &&
     (Wan.ServiceList != 'IPTV') && 
     (Wan.ServiceList != 'OTT') && 
     (Wan.ServiceList != 'OTHER') && 
     (Wan.ServiceList.toUpperCase().indexOf("SPECIAL_SERVICE") < 0))
     {
        if ("1" == GetCfgMode().TELMEX || 1 == TelmexFlag)
        {
            if(Wan.ServiceList.indexOf("INTERNET") == -1)
            {
                AlertMsg("Wanlisterror");
                return false;
            }
        }
        else if(GetCfgMode().TRUE == "1")
        {
            return true;
        }
        else
        {
            if(!(('TDE2' == CfgModeWord.toUpperCase() || '1' == "<%HW_WEB_GetFeatureSupport(FT_TDE_BRAZIL);%>") 
                && (Wan.ServiceList.toUpperCase().indexOf("INTERNET") >= 0) 
                && (Wan.EncapMode.toUpperCase() == "PPPOE")))
            {
                AlertMsg("Wanlisterror");
                return false;
            }
        }
     }
     if((Wan.Mode.toUpperCase().indexOf("ROUTE") >= 0) && (Wan.ServiceList != 'TR069') && (Wan.ServiceList != 'VOIP') && (Wan.ServiceList != 'TR069_VOIP') && (Wan.ServiceList.toUpperCase().indexOf("SPECIAL_SERVICE") < 0)){
             if ("1" == FtBin5Enhanced){
                 AlertMsg("Wanlisterror2");
                return false;
         }
     }
    
    if("TELMEXACCESS" == CfgModeWord.toUpperCase() || "TELMEXACCESSNV" == CfgModeWord.toUpperCase())
    {
        if((Wan.Mode.toUpperCase().indexOf("ROUTE") >= 0) && (Wan.ServiceList != 'TR069_VOIP_INTERNET'))
        {
            AlertMsg("Wanlisterror2");
            return false;
        }
    }
    if("TELMEXRESALE" == CfgModeWord.toUpperCase())
    {
        if((Wan.Mode.toUpperCase().indexOf("ROUTE") >= 0) && (Wan.ServiceList != 'TR069_VOIP_INTERNET'))
        {
            AlertMsg("Wanlisterror2");
            return false;
        }
    }

    if (vlanRepeate == "1") {
        for (var i=0; i < GetWanList().length; i++) {
            if (((GetWanList()[i].VlanId == Wan.VlanId) || (GetWanList()[i].VlanId == "0" && Wan.VlanId == "") )
                && (Wan.domain != GetWanList()[i].domain)) {
                AlertMsg("VlanIdIsUsed");
                return false;
            }
        }
    }

    if ((CfgModeWord.toUpperCase() == "TTNET2" || CfgModeWord.toUpperCase() == "DINFOTEK2") && (EditFlag  == "ADD")) {
        for (var i=0; i < GetWanList().length; i++) {
            if ((GetWanList()[i].VlanId == Wan.VlanId) && (Wan.VlanId != 0)) {
                AlertMsg("VlanDuplicate");
                return false;
            }
        }
    }

    if (false == CheckMtu(Wan))
    {
        return false;
    }
    
    var VlanID = Wan.VlanId;
    
    if (Wan.EnableVlan == "1")
    {
        errmsg = "";
        if ((isSupportVLAN0 != 1) || (VlanID != 0))
        {
            errmsg=checkVlanID(VlanID,"VlanId");
            if (errmsg == (Languages['VlanId'] + Languages['ModifiedConfirmInfo'])) {
                if (ConfirmEx(Languages['ModifiedConfirmInfo']) == false) {	
                    return false;
                }
            }
            else if (errmsg != "") {
                AlertEx(errmsg);
                return false;
            }
        }
    }
   
    var IPv4MultiVlanID = Wan.IPv4WanMVlanId;
      if("" != IPv4MultiVlanID && '1' == Wan.IPv4Enable)
    {
        errmsg="";

        errmsg=checkMVlanID(IPv4MultiVlanID,"WanMVlanId");

        if(""!=errmsg)

    
        {
             AlertEx(errmsg);
        
            return false;
        }
    }
    
    if(('GLOBE' == CfgModeWord.toUpperCase() || 'GLOBE2' == CfgModeWord.toUpperCase()) && (!IsAdminUser()))
    {    
        var IPv4MultiVlanIDForGoble  = getValue("IPv4WanMVlanIdGlobeUser");
        errmsg=checkMVlanID(IPv4MultiVlanIDForGoble,"WanMVlanId");    
        if(""!=errmsg)
        {
            AlertEx(errmsg);
            return false;
        }
    }
    
     if(('0' == Wan.IPv4Enable)
        &&('0' == DisliteFeature))
     {
         Wan.IPv4WanMVlanId =0 ;
     }
     
     if('0' == Wan.IPv6Enable)
     {
         Wan.IPv6WanMVlanId =0;
     }
    
    if (false == CheckDstIPForwardingCfg(Wan))
    {
        return false;
    }
    
    if((Wan.ProtocolType.toString() == "IPv6") 
    &&(Wan.IPv6DSLite.toString() != "Off")
    &&('COMMON' != CfgModeWord.toUpperCase())
    &&('COMMON2' != CfgModeWord.toUpperCase())
    &&('AWASR' != CfgModeWord.toUpperCase())
    &&(GetCfgMode().OSK != "1"))
    {
        Wan.IPv6WanMVlanId = 0;
    }
     
    if (Wan.IPv6Enable == "1" && Wan.IPv6WanMVlanId !="" )
    {
        errmsg="";

        errmsg=checkMVlanID(Wan.IPv6WanMVlanId,"WanMVlanId");
          
        if(""!=errmsg)
        {
             AlertEx(errmsg);
        
            return false;
        }
    }
	
	if (Is3TMode())
	{
	    if (Wan.IPv6Enable == "1" && Wan.IPv4Enable == "1")
		{
			if (Wan.IPv4v6WanMVlanId != "")
			{
				errmsg="";

				errmsg=checkMVlanID(Wan.IPv4v6WanMVlanId,"WanMVlanId");
				  
				if(""!=errmsg)
				{
					 AlertEx(errmsg);
				
					return false;
				}
			}
		}
	}

    var addWanService = Wan.ServiceList;

    if(shouldCheckMutilTr069Wan())
    {
        var currInstanceId = "";
        if(CfgModeWord.toUpperCase() != 'SPAINEBG2') {
            currInstanceId = SearchTr069WanInstanceId(Wan);
        }
        if(currInstanceId != "" && currInstanceId != Wan.domain && addWanService.indexOf("TR069") >= 0)
        {
            AlertMsg("OnlyOneTr069Wan");
            return false;
        }
    }

    if('IP_Bridged' == Wan.Mode || 'PPPoE_Bridged' == Wan.Mode)
    {
        if ((MngtGdct == 1) && (false == CheckMtu(Wan)))
        {
            return false;
        }
        if( 'DSL' == Wan.WanAccessType )
        {
            if(false == CheckAtmWanPvc(Wan.DestinationAddress))
            {
                return false;
            }
        }
        return true;
    }

    if(('1' == Wan.IPv4Enable)&&('Static' == Wan.IPv4AddressMode)&&(Wan.IPv4SubnetMask == ''))
    {
        AlertMsg("SubMaskInput");
        return false;
    }

    if ('1' == Wan.IPv4Enable && Wan.IPv4AddressMode == 'Static' && (isValidIpAddress(Wan.IPv4IPAddress) == false || isAbcIpAddress(Wan.IPv4IPAddress) == false))
    {
         AlertMsg("IPAddressInvalid");
         return false;
    }

    if ('1' == Wan.IPv4Enable && Wan.IPv4AddressMode == 'Static' && isValidSubnetMask(Wan.IPv4SubnetMask) == false )
    {
        AlertMsg("SubMaskInvalid");
        return false;
    }

    if ('1' == Wan.IPv4Enable && Wan.IPv4AddressMode == 'Static' && Wan.IPv4PrimaryDNS != '' && (isValidIpAddress(Wan.IPv4PrimaryDNS) == false || isAbcIpAddress(Wan.IPv4PrimaryDNS) == false))
    {
        if (isPTVDF =="0")
        {
            AlertMsg("FirstDnsInvalid");
            return false;        
        }
    }

    if ('1' == Wan.IPv4Enable && Wan.IPv4AddressMode == 'Static' && Wan.IPv4SecondaryDNS != '' && (isValidIpAddress(Wan.IPv4SecondaryDNS) == false || isAbcIpAddress(Wan.IPv4SecondaryDNS) == false))
    {
        if (isPTVDF =="0")
        {
            AlertMsg("SecondDnsInvalid");
            return false;     
        }    
    }
    CheckIPV4DNS();
    if ('1' == Wan.IPv4Enable && Wan.IPv4AddressMode == 'Static' && (Wan.IPv4Gateway != '') && (isValidIpAddress(Wan.IPv4Gateway) == false || isAbcIpAddress(Wan.IPv4Gateway) == false))
    {
         AlertMsg("WanGateWayInvalid");
         return false;
    }
    if('TDE2' != CfgModeWord.toUpperCase())
    {
        if ('1' == Wan.IPv4Enable && Wan.IPv4AddressMode == 'Static' && (Wan.IPv4Gateway != '') && (Wan.IPv4Gateway == Wan.IPv4IPAddress))
         {
             AlertMsg("IPAddressSameAsGateWay");
             return false;
         }
    }

    if('1' == Wan.IPv4Enable && Wan.IPv4AddressMode == 'Static' && (Wan.IPv4Gateway != '') && false==isSameSubNet(Wan.IPv4IPAddress, Wan.IPv4SubnetMask, Wan.IPv4Gateway, Wan.IPv4SubnetMask))
    {
        if( '1' == TDESME2Modeflg )
        {
            AlertMsg("IPAddressNotInGateWay_1");
        }
        else
        {
        AlertMsg("IPAddressNotInGateWay");
        }
        return false;
    }

    if('TDE2' != CfgModeWord.toUpperCase())
    {
        if('1' == Wan.IPv4Enable && Wan.IPv4AddressMode == 'Static')
        {
            var addr = IpAddress2DecNum(Wan.IPv4IPAddress);
            var mask = SubnetAddress2DecNum(Wan.IPv4SubnetMask);
            
			if(mask != SubnetAddress2DecNum('255.255.255.254'))
			{
				if ( (addr & (~mask)) == (~mask) )
				{
					AlertMsg("WANIPAddressInvalid");
					return false;
				}
				if ( (addr & (~mask)) == 0 )
				{
					AlertMsg("WANIPAddressInvalid");
					return false;
				}
			}
            
            if(Wan.IPv4Gateway != '')
            {
                var gwaddr = IpAddress2DecNum(Wan.IPv4Gateway);
                if ( (gwaddr & (~mask)) == (~mask) )
                {
                    AlertMsg("WANGateWayIPAddressInvalid");
                    return false;
                }
                if ( (gwaddr & (~mask)) == 0 )
                {
                     AlertMsg("WANGateWayIPAddressInvalid");
                    return false;
                }
            }
        }
    }
    
    if ('1' == Wan.IPv4Enable && 'Static' == Wan.IPv4AddressMode)
    {
        for (var iIP=0; iIP < GetWanList().length; iIP++)
        {
            if (GetWanList()[iIP].domain != Wan.domain && GetWanList()[iIP].IPv4IPAddress == Wan.IPv4IPAddress)
            {
                if(IsXdProduct())
                {
                    var AccessFlag = GetWanList()[iIP].domain.split('.');
                    if((AccessFlag.length >= 3) && (Instance_AccessType.GetWanAceesstypeByWanInst(AccessFlag[2]) != Wan.WanAccessType))
                    {
                        continue;
                    }
                }
                AlertMsg("IPAddressIsUserd");
                return false;
            }
        } 
    }

    if ((Wan.IPv4Enable == '1') && (Wan.EncapMode == 'PPPoE'))
    {
        var usr = Wan.UserName;
        var psw = Wan.Password;
        var DiaMode = Wan.IPv4DialMode;
        var Idletime = Wan.IPv4DialIdleTime;
                 
        if (DiaMode == "OnDemand")
        {
            if (false == isNum(Idletime))
            {
                AlertMsg("DiaIdleTime1");
                return false;
            }
            
            if(isNaN(Idletime) || parseInt(Idletime,10) > 86400 || parseInt(Idletime,10) < 0)
            {
                AlertMsg("DiaIdleTime1");
                return false;
            }
            
            if ( -1  !=  Idletime.indexOf("."))
            {
                AlertMsg("DiaIdleTime1");
                return false;
            }
        }
    }
	
    
    if("TALKTALK2WIFI" ==CfgModeWord.toUpperCase())
    {
        var username_reg = new RegExp(specPPPOEUsername);        
        var passworld_reg = new RegExp(specPPPOEPassword);
        var currentpsd = "";
        for (var iIP=0; iIP < GetWanList().length; iIP++)
        {
            if (GetWanList()[iIP].domain == Wan.domain)
            {
                currentpsd = GetWanList()[iIP].Password;
            }
        }
        if(!Wan.UserName.match(username_reg))
        {
            AlertEx(Languages['wan_user_error']);          
            return false;   
        }
        
        if(!Wan.Password.match(passworld_reg) && currentpsd != Wan.Password)
        {
            AlertEx(Languages['IPv4Password1'] + Languages['Hasvalidch'] + isValidAscii(Wan.Password) + '".');         
            return false; 
        }
    }
	else if(IsTedata == 1 && Wan.EncapMode.toString().toUpperCase() == "PPPOE")
	{
		if (Wan.UserName.length > 15)
		{
			AlertEx(Languages['UserNameTedata1']);         
            return false;
		}
		else if (!isNum(Wan.UserName))
		{
			AlertEx(Languages['UserNameTedata2']);         
            return false; 
		} 
		if ((Wan.Password != '') && (isValidAscii(Wan.Password) != ''))         
        {  
            AlertEx(Languages['IPv4Password1'] + Languages['Hasvalidch'] + isValidAscii(Wan.Password) + '".');         
            return false;       
        }
	} else if ((CfgModeWord.toUpperCase() == "TURKCELL2") && (Wan.EncapMode.toString().toUpperCase() == "PPPOE")) {
        if (Wan.UserName == '') {
            AlertEx(Languages['PPPUserNameInput']);
            return false;
        }
        if (Wan.Password == '') {
            AlertEx(Languages['PPPPasswordInput']);
            return false;
        }
        if (isValidAscii(Wan.UserName) != '') {
            AlertEx(Languages['IPv4UserName1'] + Languages['Hasvalidch'] + isValidAscii(Wan.UserName) + '".');
            return false;
        }
        if (isValidAscii(Wan.Password) != '') {
            AlertEx(Languages['IPv4Password1'] + Languages['Hasvalidch'] + isValidAscii(Wan.Password) + '".');
            return false;
        }
    } else if ((CfgModeWord.toUpperCase() == "TELECOM2") && (Wan.EncapMode.toString().toUpperCase() == "PPPOE")) {
        if ((Wan.Password != '') && (isValidAscii(Wan.Password) != ''))         
        {  
            AlertEx(Languages['IPv4Password1'] + Languages['Hasvalidch'] + isValidAscii(Wan.Password) + '".');         
            return false;       
        }
    }
    else
    {
        if ((Wan.UserName != '') && (isValidAscii(Wan.UserName) != ''))        
        {  
            AlertEx(Languages['IPv4UserName1'] + Languages['Hasvalidch'] + isValidAscii(Wan.UserName) + '".');          
            return false;       
        }
        
        if ((Wan.Password != '') && (isValidAscii(Wan.Password) != ''))         
        {  
            AlertEx(Languages['IPv4Password1'] + Languages['Hasvalidch'] + isValidAscii(Wan.Password) + '".');         
            return false;       
        }
    }

    if ('1' == Wan.IPv4Enable && "DHCP" == Wan.IPv4AddressMode)
    {
        if(Wan.IPv4VendorId.length > 64)
        {
            AlertMsg("VendorIdError");
            return false;
        }
        if ("TALKTALK2WIFI" ==CfgModeWord.toUpperCase())
        {
            if ('' != isTTValidVenderClassID(Wan.IPv4VendorId) || '' != isValidAscii(Wan.IPv4VendorId))
            {
                AlertMsg("VendorIdInvalid");
                return false;
            }                
        }
        else
        {
            if ('' != isValidVenderClassID(Wan.IPv4VendorId) || '' != isValidAscii(Wan.IPv4VendorId))
            {
                AlertMsg("VendorIdInvalid");
                return false;
            }        
        }
        
        if(Wan.IPv4ClientId.length > 64)
        {
            AlertMsg("ClientIdError");
            return false;
        }

        if ('' != isValidVenderClassID(Wan.IPv4ClientId) || '' != isValidAscii(Wan.IPv4ClientId))
        {
            AlertMsg("ClientIdInvalid");
            return false;
        }
    }

    if ('1' == Wan.IPv4DNSOverrideSwitch && '1' == Wan.IPv4Enable && ('PPPoE' == Wan.EncapMode || 'DHCP' == Wan.IPv4AddressMode))
    {
        if (Wan.IPv4PrimaryDNS != '' && (isValidIpAddress(Wan.IPv4PrimaryDNS) == false || isAbcIpAddress(Wan.IPv4PrimaryDNS) == false))
        {
            AlertMsg("FirstDnsInvalid");
            return false;
        }
    
        if (Wan.IPv4SecondaryDNS != '' && (isValidIpAddress(Wan.IPv4SecondaryDNS) == false || isAbcIpAddress(Wan.IPv4SecondaryDNS) == false))
        {   
            AlertMsg("SecondDnsInvalid");
            return false;
        }
    }
    
    if (Wan.IPv6Enable == "1" && Wan.IPv6PrefixMode == "Static")
    {
        if (Wan.IPv6StaticPrefix.length == 0)
        {
            AlertMsg("IPv6PrefixEmpty");
            return false;
        }

        var List = Wan.IPv6StaticPrefix.split("/");
        if (List.length != 2)
        {
            AlertMsg("IPv6PrefixInvalid");
            return false;
        }
        if ('' == List[1])
        {
            AlertMsg("IPv6PrefixInvalid");
            return false;
        }

        if ( List[1].length > 1 && List[1].charAt(0) == '0' )
      {
         AlertMsg("IPv6PrefixInvalid");
         return false;  
      }
        if (parseInt(List[1],10) < 1 || isNaN(List[1].replace(' ', 'a')) == true || parseInt(List[1],10) > 64)
        {
                AlertMsg("IPv6PrefixInvalid");
                return false;    
        }

        if (IsIPv6AddressValid(List[0]) == false)
        {
                AlertMsg("IPv6PrefixInvalid");
                return false;  
        }

        if ( IsIPv6ZeroAddress(List[0]) == true)
        {
                AlertMsg("IPv6PrefixInvalid");
                return false;  
        } 

        if (parseInt(List[0].split(":")[0], 16) >= parseInt("0xFF00", 16))
            {
                AlertMsg("IPv6PrefixInvalid");
                return false;   
            } 
    }
    
    if (Wan.IPv6Enable == "1" && Wan.IPv6AddressMode == "AutoConfigured" && Wan.IPv6AddressStuff.length > 0)
    {
        var List = Wan.IPv6AddressStuff.split("/");
        if (List.length != 2)
        {
            AlertMsg("IPv6PrefixMaskInvalid");
            return false;   
        }
        if ( List[1].length > 1 && List[1].charAt(0) == '0' )
     {
         AlertMsg("IPv6PrefixMaskInvalid");
         return false;  
     }
        if (parseInt(List[1],10) < 1  || isNaN(List[1].replace(' ', 'a')) == true || parseInt(List[1],10) != 64)
        {
                AlertMsg("IPv6PrefixMaskInvalid");
                return false;    
        }
        if (IsIPv6AddressValid(List[0]) == false)
        {
                AlertMsg("IPv6PrefixMaskInvalid");
                return false;  
        } 

    }

    if (Wan.IPv6Enable == "1" && Wan.IPv6AddressMode == "Static")
    {
        if (false == CheckNumber(Wan.IPv6AddrMaskLenE8c, 10, 128) && (Wan.IPv6AddrMaskLenE8c != ""))
        {
            AlertMsg("IPv6AddrMaskLenE8cError");
            return false;
        }
        
        if (Wan.IPv6IPAddress.length == 0)
        {
            AlertMsg("IPv6AddressEmpty");
            return false;
        }

        if (IsIPv6AddressValid(Wan.IPv6IPAddress) == false)
        {
            AlertMsg("IPv6AddressInvalid");
            return false;  
        }

        if (parseInt(Wan.IPv6IPAddress.split(":")[0], 16) >= parseInt("0xFF00", 16))
        {
            AlertMsg("IPv6AddressInvalid");
            return false;   
        } 

        if (IsIPv6ZeroAddress(Wan.IPv6IPAddress) == true)
        {
           AlertMsg("IPv6AddressInvalid");
           return false;  
        }

        if (IsIPv6LoopBackAddress(Wan.IPv6IPAddress) == true)
        {
            AlertMsg("IPv6AddressInvalid");
            return false;    
        }
        
        if(Wan.IPv6GatewayE8c.length > 0)
        {
            if (IsIPv6AddressValid(Wan.IPv6GatewayE8c) == false)
            {
              AlertMsg("IPv6AddressInvalid2");
              return false;  
            }

            if (parseInt(Wan.IPv6GatewayE8c.split(":")[0], 16) >= parseInt("0xFF00", 16))
            {
              AlertMsg("IPv6AddressInvalid2");
              return false;   
            }
             
            if (IsIPv6ZeroAddress(Wan.IPv6GatewayE8c) == true)
            {
               AlertMsg("IPv6AddressInvalid2");
               return false;  
            }

            if (IsIPv6LoopBackAddress(Wan.IPv6GatewayE8c) == true)
            {
              AlertMsg("IPv6AddressInvalid2");
              return false;    
            }
            
            if(Wan.IPv6GatewayE8c == Wan.IPv6IPAddress)
            {
                AlertMsg("IPAddressSameAsGateWay2");
                return false;
            }
            if(false == IsIPv6LinkLocalAddress(Wan.IPv6GatewayE8c) && false == isSameIPv6SubNet(Wan.IPv6IPAddress,Wan.IPv6GatewayE8c,Wan.IPv6AddrMaskLenE8c))
            {
                AlertMsg("IPAddressNotInGateWay2");
                return false;
            }
        }
        

        if (Wan.IPv6PrimaryDNS.length)
        {
            if ( IsIPv6AddressValid(Wan.IPv6PrimaryDNS) == false)
            {
                AlertMsg("IPv6FirstDnsInvalid");
                return false;
                        }
            
            if (parseInt(Wan.IPv6PrimaryDNS.split(":")[0], 16) >= parseInt("0xFF00", 16))
            {
                AlertMsg("IPv6FirstDnsInvalid");
                return false;   
            } 

            if (IsIPv6ZeroAddress(Wan.IPv6PrimaryDNS) == true)
            {
               AlertMsg("IPv6FirstDnsInvalid");
               return false;  
            }

            if (IsIPv6LoopBackAddress(Wan.IPv6PrimaryDNS) == true)
            {
                AlertMsg("IPv6FirstDnsInvalid");
                return false;    
            }

            if (IsIPv6LinkLocalAddress(Wan.IPv6PrimaryDNS) == true || IsIPv6SiteLocalAddress(Wan.IPv6PrimaryDNS) == true)
            {
                AlertMsg("IPv6FirstDnsInvalid");
                return false;    
            }             
            
        }

        if (Wan.IPv6SecondaryDNS.length > 0)
        {
            if ( IsIPv6AddressValid(Wan.IPv6SecondaryDNS) == false)
            {
                AlertMsg("IPv6SecondDnsInvalid");
                return false;
                        }
            
            if (parseInt(Wan.IPv6SecondaryDNS.split(":")[0], 16) >= parseInt("0xFF00", 16))
            {
                AlertMsg("IPv6SecondDnsInvalid");
                return false;   
            } 

            if (IsIPv6ZeroAddress(Wan.IPv6SecondaryDNS) == true)
            {
               AlertMsg("IPv6SecondDnsInvalid");
               return false;  
            }

            if (IsIPv6LoopBackAddress(Wan.IPv6SecondaryDNS) == true)
            {
                AlertMsg("IPv6SecondDnsInvalid");
                return false;    
            } 

            if (IsIPv6LinkLocalAddress(Wan.IPv6SecondaryDNS) == true || IsIPv6SiteLocalAddress(Wan.IPv6SecondaryDNS) == true)
            {
                AlertMsg("IPv6SecondDnsInvalid");
                return false;    
            }        
            
        }
    }
    
    if ((Wan.IPv6Enable == "1") && (Wan.EncapMode.toString().toUpperCase() == "IPOE") && (Wan.IPv6AddressMode == "None"))
    {
        if (Wan.IPv6ReserveAddress.length > 0)
        {
            if (IsIPv6AddressValid(Wan.IPv6ReserveAddress) == false)
            {
                AlertMsg("IPv6AddressInvalid");
                return false;  
            }
    
        }
    }

    if ('1' == Wan.IPv4Enable && Wan.IPv4AddressMode != 'PPPOE' && MultiWanIpFeature == "1")
    {
        if (CheckMultiIP(Wan.IPv4IPAddressSecond) == false)
        {
            AlertMsg("IPAddressInvalid");
            return false;
        }
        if (CheckMultiSubnetMask(Wan.IPv4SubnetMaskSecond) == false)
        {
            AlertMsg("SubMaskInvalid");
            return false;
        }        
        if (CheckMultiIP(Wan.IPv4IPAddressThird) == false)
        {
            AlertMsg("IPAddressInvalid");
            return false;
        }
        if (CheckMultiSubnetMask(Wan.IPv4SubnetMaskThird) == false)
        {
            AlertMsg("SubMaskInvalid");
            return false;
        }                               
    }
    
    if (false == CheckDSLite(Wan))
    {
        return false;
    }
    
    if (false == Check6rd(Wan))
    {
        return false;
    }
    
    if(false == CheckAtmWan(Wan))
    {
        return false;
    }
    
    if (CheckUnnumberdIp(Wan) == false) {
        return false;
    }
    if ((showWanName == '1') && (Wan.Name == '')) {
        AlertMsg("WanNameInvalid");
        return false;
    }
    return true;
}

function CheckMultiIP(obj)
{
    if(obj != "")
    {
        if (isValidIpAddress(obj) == false || isAbcIpAddress(obj) == false)
        {
            return false;
        }            
    }                                   
}

function CheckMultiSubnetMask(obj)
{
    if(obj != "")
    {
        if (isValidSubnetMask(obj) == false)
        {
            return false;
        }          
    }
    return true;        
}
function CheckDSLite(Wan)
{
    DomainElement = Wan.domain.split(".");
    wanCurrentInst = DomainElement[4];
    if (Wan.ProtocolType.toString() != "IPv6" )
    {
        return true;
    }
    if (Wan.Mode.toString().toUpperCase() != "IP_ROUTED" )
    {
        return true;
    }

    if (Wan.IPv6DSLite.toString() == "Static" )
    {
        if (trim(Wan.IPv6AFTRName).length == 0)
        {
            AlertMsg("AFTRNameErr2");
            return false;
        }
        
        if (isValidAscii(Wan.IPv6AFTRName) != '')         
        {  
            AlertEx(Languages['AFTRName1'] + Languages['Hasvalidch'] + isValidAscii(Wan.IPv6AFTRName) + '".');          
            return false;       
        }
        
        if(!((Wan.IPv6AFTRName.length > 0) && (Wan.IPv6AFTRName.length < 257)))
        {
            AlertMsg("AFTRNameErr");
            return false;
        }
    }

    return true;
}

function Check6rd(Wan)
{
    DomainElement = Wan.domain.split(".");
    wanCurrentInst = DomainElement[4];
    
    if (true != Is6RdSupported())
    {
        return true;
    }
    
    if (Wan.ProtocolType.toString() != "IPv4" )
    {
        return true;
    }
    if (Wan.Mode.toString().toUpperCase() != "IP_ROUTED" )
    {
        return true;
    }

    if ("STATIC" == Wan.RdMode.toString().toUpperCase())
    {
        if ((Wan.RdPrefix.length == 0) || (IsIPv6AddressValid(Wan.RdPrefix) == false)
         ||(parseInt(Wan.RdPrefix.split(":")[0], 16) >= parseInt("0xFF00", 16))
         ||(IsIPv6ZeroAddress(Wan.RdPrefix) == true)
         ||(IsIPv6LoopBackAddress(Wan.RdPrefix) == true))
        {
            AlertMsg("RdPrefixInvalid");
            return false;
        }
        
        if (false == CheckNumber(Wan.RdPrefixLen, 10, 64))
        {
            AlertMsg("RdPrefixLenthInvalid");
            return false;
        }                    
                
        if((isValidIpAddress(Wan.RdBRIPv4Address) == false) || (isAbcIpAddress(Wan.RdBRIPv4Address) == false))
        {
            AlertMsg("RdBrAddrInvalid");
            return false;
        }
        
        if (false == CheckNumber(Wan.RdIPv4MaskLen, 0, 32))
        {
            AlertMsg("RdIPv4MaskLenInvalid");
            return false;
        }
        
        if ((parseInt(Wan.RdPrefixLen,10) - parseInt(Wan.RdIPv4MaskLen,10)) > 32)
        {
            AlertMsg("RdPreLenAndV4MaskLenMismatch");
            return false;
        }        
    }
    
    return true;
}

function CheckUnnumberdIp(Wan)
{
    if (supportUnnumberMode == '0') {
        return true;
    }
    if ((Wan.Mode.toString().toUpperCase() != "IP_ROUTED") || (Wan.EncapMode.toString().toUpperCase() != "PPPOE") ||
        (Wan.ServiceList.indexOf("INTERNET") < 0)) {
        return true;
    }

    if (Wan.EnableUnnumbered == '1') {
        if (Wan.UnnumberedIpAddress == '') {
            AlertMsg("UnnumberdIpEmpty");
            return false;
        }
        if (Wan.UnnumberedSubnetMask == '') {
            AlertMsg("UnnumberdMaskEmpty");
            return false;
        }
        if (isAbcIpAddress(Wan.UnnumberedIpAddress) == false) {
            AlertMsg("UnnumberdIpInvalid");
            return false;
        }
        if (isValidSubnetMask(Wan.UnnumberedSubnetMask) == false) {
            AlertMsg("UnnumberdMaskInvalid");
            return false;
        }
    }
    return true;
}

function isInvalidRadionString(val)
{
    for ( var i = 0 ; i < val.length ; i++ )
    {
        var ch = val.charAt(i);
        if ( ch == "," || ch == ";" || ch == "'" || ch == "\"" )
        {
            return ch;
        }
    }

    return '';
}

function CheckRadioString(str)
{
    var c = isValidAscii(str);
    if(c != '')
    {
        return c;
    }
    
    c = isInvalidRadionString(str);
    if(c != '')
    {
        return c;
    }     
    
    return '';
}

function IsRadioWanProfileRepeat(newApn, profileInst)
{
    try {
        if (newApn == '') {
            return false;
        }
        
        var radioWanProfile = GetRadioWanProfileArray();
        if (radioWanProfile == null || radioWanProfile.length <= 1) {
            return false;
        }
    
        var RADIO_WAN_PROFILE = "InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_MobileInterface.Profile." + profileInst;

        for (var i = 0; i < (radioWanProfile.length - 1); i++) {
            if (radioWanProfile[i] == null) {
                continue;
            }
            
            if ((radioWanProfile[i].LteAPN == newApn) && (radioWanProfile[i].domain != RADIO_WAN_PROFILE)) {
                return true;
            }
        }
        
        return false;
    } catch(e){
        return false;
    }
}

function GetRadioWanMaxNum()
{
    var RADIO_WAN_MAX = 1;
    if (isSupportLte != "1") {
        return RADIO_WAN_MAX;
    }

    var BONDING_LTE_WAN_MAX = 1;
    if ((CfgModeWord.toUpperCase() == 'DBAA1') || (CfgModeWord.toUpperCase() == 'HT') || (CfgModeWord.toUpperCase() == 'OTE') || (CfgModeWord.toUpperCase() == 'DETHMAXIS')) {
       return BONDING_LTE_WAN_MAX;
    }

    if (isSupportHybrid == 1) {
        return 1;
    }

    var LTE_WAN_MAX = 3;
    return LTE_WAN_MAX;
}

function CheckRadioWan(Wan, EditFlag)
{
    if (false == IsCurrentRadioWan())
    {
        return true;
    }
    
    if (EditFlag == "ADD")
    {
        var wanListTmp = GetWanList();
        var maxCnt = GetRadioWanMaxNum();
        var tmpCnt = 0;
        
        for (var i=0; i < wanListTmp.length; i++ )
        {
            if (true == IsRadioWanSupported(wanListTmp[i]))
            {
                tmpCnt++;
            }
            
            if (tmpCnt >= maxCnt)
            {
                AlertMsg("RadioWanIsFull");
                return false;
            }
        }
    }
    
    if (Wan.SwitchDelayTime == "")
    {
        AlertMsg("SwitchDelayTimeisreq");
        return false;
    }  

    var SwitchDelayTime = removeSpaceTrim(Wan.SwitchDelayTime);
    if(SwitchDelayTime!="")
    {
        if (isSupportAboard) {
            if (!CheckNumber(SwitchDelayTime, 5, 3600)) {
                AlertMsg("SwitchDelayTimeLTE");
                return false;
            }
         } else {
            if (!CheckNumber(SwitchDelayTime, 30, 3600)) {
                AlertMsg("invalidSwitchDelayTime");
                return false;
            }
        }
    }
    
    if ( Wan.PingIPAddress != '' && (isValidIpAddress(Wan.PingIPAddress) == false || isAbcIpAddress(Wan.PingIPAddress) == false))
    {
         AlertMsg("invalidipaddr");
         return false;
    }

    if ((Wan.RadioWanUsername != '') && (CheckRadioString(Wan.RadioWanUsername) != ''))        
    {  
        AlertEx(Languages['IPv4UserName1'] + Languages['Hasvalidch'] + CheckRadioString(Wan.RadioWanUsername) + '".');          
        return false;       
    }
    
    if ((Wan.RadioWanPassword != '') && (Wan.RadioWanPassword != radio_hidepassword) && (CheckRadioString(Wan.RadioWanPassword) != ''))         
    {  
        AlertEx(Languages['IPv4Password1'] + Languages['Hasvalidch'] + CheckRadioString(Wan.RadioWanPassword) + '".');         
        return false;       
    }
    
    if ((Wan.APN != '') && (CheckRadioString(Wan.APN) != ''))         
    {  
        AlertEx(Languages['APN1'] + Languages['Hasvalidch'] + CheckRadioString(Wan.APN) + '".');         
        return false;       
    }
    
    if (isSupportLte == "1") {    
        if (IsRadioWanProfileRepeat(Wan.APN, Wan.X_HW_LteProfile)) {
            AlertMsg("repeatApnError");
            return false;
        }
    }

    return true;
}
