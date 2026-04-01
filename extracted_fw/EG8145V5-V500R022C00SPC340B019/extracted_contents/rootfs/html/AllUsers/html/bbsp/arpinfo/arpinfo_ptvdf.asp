<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  id="Page" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" >
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../Cusjs/<%HW_WEB_CleanCache_Resource(ptvdfjs.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(bbspdes.html);%>"></script>
<script language="javascript" src="../common/<%HW_WEB_DeepCleanCache_Resource(wan_list_ptvdf.asp);%>"></script>
<script language="javascript" src="../../amp/common/wlan_list.asp"></script>
<script>
function GetMatchDevName(Interface) {
    var _Interface = "";
    var _Name = "";

    if (Interface.charAt(Interface.length - 1) == '.') {
        _Interface = Interface.substr(0, Interface.length - 1);
    } else {
        _Interface = Interface;
    }
    
    if (_Interface.indexOf("WANConnectionDevice") != -1) {
        var Wans = GetWanList();
        
        for (var i in Wans) {
            if(_Interface.toUpperCase() == Wans[i].domain.toUpperCase()) {
                _Name = Wans[i].Description;
                break;
            }
        }
    } else if (_Interface.indexOf("LANEthernetInterfaceConfig") != -1) {
        _Name = "LAN" + _Interface.charAt(_Interface.length - 1);
    } else if (_Interface.indexOf("WLANConfiguration") != -1) {
        _Name = GetSSIDNameByDomain(_Interface);
    } else if (_Interface.indexOf("PON") != -1) {
        _Name = "PON";
    } else {
        _Name = "";
    }
    
    return (_Name.length == 0)?"--":_Name;
}
function NeighInfo(Domain, IPAddress, MACAddress, Interface, Status) {
    this.Domain = Domain;
    this.IPAddress = IPAddress.toLowerCase();
    this.MACAddress = (MACAddress.length == 0) ? "--" : MACAddress.toLowerCase();
    this.Interface = GetMatchDevName(Interface);
    this.Status = Status.toLowerCase();
}
var NeighInfo = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_FilterARPinfo, InternetGatewayDevice.X_HW_NeighborDiscovery.ARPTable.{i}, IPAddress|MACAddress|Interface|Status,NeighInfo);%>;

var arpinfotableArr = [[neigh_lang["neigh_ip"], neigh_lang["neigh_mac"], neigh_lang["neigh_interface"], neigh_lang["neigh_status"]]];
for (var i = 0; i < NeighInfo.length - 1; i++) {
    arpinfotableArr.push([NeighInfo[i].IPAddress, NeighInfo[i].MACAddress, NeighInfo[i].Interface, NeighInfo[i].Status])
}
if (NeighInfo.length == 1) {
    arpinfotableArr.push("--", "--", "--", "--");
}
</script>
</head>
<body id="wanbody">
<div id="content">
<script>
    CreatHeaderTitle(neigh_lang["bbsp_title"], neigh_lang["neigh_tips"]);

    CreatDisplayInfoTable("", "arpinfotable", arpinfotableArr);
</script>
</div>

</body>
</html>
