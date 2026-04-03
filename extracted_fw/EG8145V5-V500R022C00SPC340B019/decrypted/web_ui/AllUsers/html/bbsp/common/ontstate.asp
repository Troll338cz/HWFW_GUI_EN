function OntStateInfo(domain,ONTID,Status)
{
this.domain = domain;
this.OntId= ONTID;
this.Status= Status;
}

var GponOntStateInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.ONT,Ontid|State,OntStateInfo);%>;
var EponOntStateInfo = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.OAM.ONT,Ontid|State,OntStateInfo);%>;
var PonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.AccessMode);%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var WanEthInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.1.WANEthernetInterfaceConfig,Status, UpEthInfo);%>;
var BJUNICOM = "<%HW_WEB_GetFeatureSupport(BBSP_FT_BJUNICOM);%>";

function UpEthInfo(domain,Status)
{
	this.domain	= domain;
    this.Status = Status;     
    
    if(Status == "Up")
    {    
		this.Status = "ONLINE";
    }
    else
    {
		this.Status = "OFFLINE";
    }
}

var OntState = "";
if ("GPON" == PonMode.toUpperCase())
{
    OntState = ((GponOntStateInfo[0].Status.toUpperCase() == "O5") || (OntState = GponOntStateInfo[0].Status.toUpperCase() == "O5AUTH")) ? "ONLINE":"OFFLINE"; 
}
else if ("EPON" == PonMode.toUpperCase())
{
    OntState =  EponOntStateInfo[0].Status.toUpperCase(); 
}
else if ((WanEthInfos.length > 1) && ("GE" == PonMode.toUpperCase()))
{
    OntState =  WanEthInfos[0].Status; 
}
else
{
    OntState = "ONLINE";
}


function GetOntState()
{
    return OntState;
}
function GetPonMode()
{
    return PonMode.toUpperCase();   
}

function NeedAddConnectButton(wan)
{
    if (BJUNICOM == "1")
    {
        return false;
    }

    if (wan.ServiceList != "INTERNET")
    {
        return false;
    }
    
    if (wan.IPv4AddressMode.toUpperCase() != "PPPOE")
    {
        return false;
    }

    if (wan.Mode != "IP_Routed")
    {
        return false;
    }
    
    if(wan.ConnectionTrigger != "Manual")
    {
        return false;
    }
    
    return true;
}

function OnConnectionControlButton(Control,RecordId,CtrFlag)
{
    var Form = new webSubmitForm();
    Form.addParameter('x.X_HW_ConnectionControl',CtrFlag);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
    Form.setAction('set.cgi?' +'x='+ GetWanList()[RecordId].domain + '&RequestFile=html/bbsp/waninfo/waninfowait.html');
    Form.submit();
}

function OnConnectionControlButtonGlobe(Control,RecordId,CtrFlag)
{
    var Form = new webSubmitForm();
    Form.addParameter('x.X_HW_ConnectionControl',CtrFlag);
	  Form.addParameter('x.X_HW_Token', getAuthToken());	
    Form.setAction('globeset.cgi?' +'x='+ GetWanList()[RecordId].domain + '&RequestFile=html/bbsp/waninfo/waninfowaitglobe.html');
    Form.submit();
}

function OnConnectionControlButtonCU(Control,CurWandomain,CtrFlag)
{
    var Form = new webSubmitForm();
    Form.addParameter('x.X_HW_ConnectionControl',CtrFlag);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
    Form.setAction('set.cgi?' +'x='+ CurWandomain + '&RequestFile=html/bbsp/wan/confirmwancfginfo.html');
    Form.submit();
}

function OnConnectionControlButtonE8c(Control,RecordId,CtrFlag)
{
    var Form = new webSubmitForm();
    Form.addParameter('x.X_HW_ConnectionControl',CtrFlag);
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));	
    Form.setAction('set.cgi?' +'x='+ GetWanList()[RecordId].domain + '&RequestFile=../html/bbsp/waninfo/waninfowait.html');
    Form.submit();
}
function OnConnectionControlButtonE8cTjct(Control,RecordId,CtrFlag)
{
    var Form = new webSubmitForm();
    Form.addParameter('x.X_HW_ConnectionControl',CtrFlag);
    Form.addParameter('x.X_HW_Token', getAuthToken());
    Form.setAction('globeset.cgi?' +'x='+ GetWanList()[RecordId].domain + '&RequestFile=twaninfowait.html');
    Form.submit();
}