function domainTowanname(domain) {
    if ((null != domain) && (undefined != domain)) {
        var domaina = domain.split('.');
        var type = (-1 == domain.indexOf("WANIPConnection")) ? '.ppp' : '.ip';
        return 'wan' + domaina[2]  + '.' + domaina[4] + type + domaina[6];
    }
}

var DSLWanInstance  = "";
var VDSLWanInstance = "";
var ETHWanInstance  = "";
var SFPWanInstance  = "";
var UMTSWanInstance = "";

function GetWanInstByWanAceesstype(wanAccesstype) {
    if ("DSL" == wanAccesstype) {
        return DSLWanInstance;
    } else if ("VDSL" == wanAccesstype) {
        return VDSLWanInstance;
    } else if ("Ethernet" == wanAccesstype) {
        return ETHWanInstance;
    } else if ("SFP" == wanAccesstype) {
        return SFPWanInstance;
    } else if ("UMTS" == wanAccesstype) {
        return UMTSWanInstance;
    }
    return 1;
}

function GetWanAceesstypeByWanInst(Inst) {
    if (DSLWanInstance == Inst) {
        return "DSL";
    } else if (VDSLWanInstance == Inst) {
        return "VDSL";
    } else if (ETHWanInstance == Inst) {
        return "Ethernet";
    } else if (SFPWanInstance == Inst && 1 == isSupportSFP) {
        return "SFP";
    } else if (UMTSWanInstance == Inst) {
        return "UMTS";
    }
    return null;
}

var AccessTypeList =  <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANCommonInterfaceConfig, WANAccessType, AccessType);%>;

for (var i = 0; i < AccessTypeList.length-1; i++) {
    if ("DSL" == AccessTypeList[i].WANAccessType) {
        DSLWanInstance = AccessTypeList[i].domain.split(".")[2];
    } else if ("VDSL" == AccessTypeList[i].WANAccessType) {
        VDSLWanInstance = AccessTypeList[i].domain.split(".")[2];
    } else if ("Ethernet" == AccessTypeList[i].WANAccessType) {
        ETHWanInstance = AccessTypeList[i].domain.split(".")[2];
    } else if ("SFP" == AccessTypeList[i].WANAccessType) {
        SFPWanInstance = AccessTypeList[i].domain.split(".")[2];
    } else if ("UMTS" == AccessTypeList[i].WANAccessType) {
        UMTSWanInstance = AccessTypeList[i].domain.split(".")[2];
    }
}