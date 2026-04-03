function stLayer3Enable(domain, lay3enable)
{
	this.domain = domain;
	this.L3Enable = lay3enable;
}

var LanModeList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.{i}, X_HW_L3Enable,stLayer3Enable);%>; 
var isSupportGePortVlan = '<%HW_WEB_GetFeatureSupport(BBSP_FT_GE_PORT_VLAN);%>';

function GetLanModeList()
{
    return LanModeList;
}

function IsL3Mode(LanId)
{
    if (parseInt(LanId) >= LanModeList.length){
    	return "null";
    }
    if ((parseInt(LanId) == (LanModeList.length - 1)) && (isSupportGePortVlan == '1')) {
        return "1";
    }
    return LanModeList[parseInt(LanId)-1].L3Enable;
}