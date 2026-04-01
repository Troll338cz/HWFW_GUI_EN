function QosBasicInfo(Domain, Enable, X_HW_Mode, X_HW_Bandwidth, X_HW_Plan, X_HW_EnableForceWeight, X_HW_EnableDSCPMark, X_HW_Enable8021p)
{
    this.Domain = Domain;
    this.Enable = Enable;
	this.X_HW_Mode = X_HW_Mode;
	this.X_HW_Bandwidth = X_HW_Bandwidth;
	this.X_HW_Plan = X_HW_Plan;
	this.X_HW_EnableForceWeight = X_HW_EnableForceWeight;
	this.X_HW_EnableDSCPMark = X_HW_EnableDSCPMark;
	this.X_HW_Enable8021p = X_HW_Enable8021p;
}

function QosBasicInfoDown(Domain, Enable, X_HW_Bandwidth, X_HW_Plan, X_HW_EnableDSCPMark, X_HW_Enable8021p)
{
    this.Domain = Domain;
    this.Enable = Enable;
    this.X_HW_Bandwidth = X_HW_Bandwidth;
    this.X_HW_Plan = X_HW_Plan;
    this.X_HW_EnableDSCPMark = X_HW_EnableDSCPMark;
    this.X_HW_Enable8021p = X_HW_Enable8021p;
}

function PriorityQueueInfo(Domain, Enable, Priority, Weight)
{
    this.Domain = Domain;
    this.Enable = Enable;
    this.Priority = Priority;
    this.Weight = Weight;
}

function PriorityQueueInfoDown(Domain, Enable, Priority, Weight)
{
    this.Domain = Domain;
    this.Enable = Enable;
    this.Priority = Priority;
    this.Weight = Weight;
}

function AppInfo(Domain, AppName, ClassQueue)
{
    this.Domain = Domain;
    this.AppName = AppName;
    this.ClassQueue = ClassQueue;
	this.AppId = "";
}

function ClassificationInfo(Domain, ClassQueue, DSCPMarkValue, PriorityValue, ClassQueueEnable)
{
    this.Domain = Domain;
	this.ClassificationId = "";
    this.ClassQueue = ClassQueue;
	this.DSCPMarkValue = DSCPMarkValue;
	this.DSCPAndTCJoint = DSCPMarkValue;
    this.PriorityValue = PriorityValue;
    this.ClassQueueEnable = ClassQueueEnable;
}

function ClassificationInfoDown(Domain, ClassQueue, DSCPMarkValue, PriorityValue)
{
    this.Domain = Domain;
    this.ClassificationId = "";
    this.ClassQueue = ClassQueue;
    this.DSCPMarkValue = DSCPMarkValue;
    this.DSCPAndTCJoint = DSCPMarkValue;
    this.PriorityValue = PriorityValue;
}

function RemoveDomainPoint(str)
{
    if (str.charAt(str.length-1) == ".")
    {
        return str.slice(0,str.length-1);
    }
    else
    {
        return str;
    }
}

function ClassificationTypeInfo(Domain, Type, Max, Min, ProtocolList)
{
	this.Domain = Domain;
	this.ClassificationId = "";
	this.ClassificationTypeId = "";
	this.Type = Type;
	this.Max = RemoveDomainPoint(Max);
	this.Min = RemoveDomainPoint(Min);
	this.ProtocolList = ProtocolList;
	this.MaxShow = "";
	this.MinShow = "";
}

function ClassificationTypeInfoDown(Domain, Type, Max, Min, ProtocolList)
{
    this.Domain = Domain;
    this.ClassificationId = "";
    this.ClassificationTypeId = "";
    this.Type = Type;
    this.Max = RemoveDomainPoint(Max);
    this.Min = RemoveDomainPoint(Min);
    this.ProtocolList = ProtocolList;
    this.MaxShow = "";
    this.MinShow = "";
}

function DataClassInfo(ClassificationId, Queue, DSCPMarkValue, PriorityValue, Type, Max, Min, ProtocolList)
{
	this.ClassificationId = ClassificationId;
	this.Queue = Queue;
	this.DSCPMarkValue = DSCPMarkValue;
	this.PriorityValue = PriorityValue;
	this.Type = Type;
	this.Max = Max;
	this.Min = Min;
	this.ProtocolList = ProtocolList;
}

var QosBasicInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UplinkQos, Enable|X_HW_Mode|X_HW_Bandwidth|X_HW_Plan|X_HW_EnableForceWeight|X_HW_EnableDSCPMark|X_HW_Enable8021p, QosBasicInfo);%>;
var QosBasicInfoListDown = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DownlinkQos, Enable|X_HW_Bandwidth|X_HW_Plan|X_HW_EnableDSCPMark|X_HW_Enable8021p, QosBasicInfoDown);%>;
var PQInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UplinkQos.PriorityQueue.{i}, Enable|Priority|Weight, PriorityQueueInfo);%>; 
var PQInfoListDown = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DownlinkQos.PriorityQueue.{i}, Enable|Priority|Weight, PriorityQueueInfoDown);%>; 

var DefaultPQList = new Array(new PriorityQueueInfo("","0","1","0"),new PriorityQueueInfo("","0","2","0"),new PriorityQueueInfo("","0","3","0"),new PriorityQueueInfo("","0","4","0"),
								new PriorityQueueInfo("","0","5","0"),new PriorityQueueInfo("","0","6","0"),new PriorityQueueInfo("","0","7","0"),new PriorityQueueInfo("","0","8","0"),null);
var DefaultPQListDown = new Array(new PriorityQueueInfoDown("","0","1","0"),new PriorityQueueInfoDown("","0","2","0"),new PriorityQueueInfoDown("","0","3","0"),new PriorityQueueInfoDown("","0","4","0"),
						new PriorityQueueInfoDown("","0","5","0"), new PriorityQueueInfoDown("","0","6","0"), new PriorityQueueInfoDown("","0","7","0"), new PriorityQueueInfoDown("","0","8","0"), null);
var PriorityQueueInfoList = new Array();
var PriorityQueueInfoListDown = new Array();

var AppInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UplinkQos.App.{i}, AppName|ClassQueue, AppInfo);%>; 
var ClassificationInfoList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UplinkQos.Classification.{i}, ClassQueue|DSCPMarkValue|PriorityValue|ClassQueueEnable, ClassificationInfo);%>;
var ClassificationInfoListDown = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DownlinkQos.Classification.{i}, ClassQueue|DSCPMarkValue|8021pValue, ClassificationInfoDown);%>;

var ClsTypeList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UplinkQos.Classification.{i}.type.{i}, Type|Max|Min|ProtocolList, ClassificationTypeInfo);%>;
var ClsTypeListDown = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DownlinkQos.Classification.{i}.type.{i}, Type|Max|Min|ProtocolList, ClassificationTypeInfoDown);%>;

var SortAppId = new Array();
var SortClassId = new Array();
var SortClassIdDown = new Array();
var TianYiFlag = "<%HW_WEB_GetFeatureSupport(FT_AMP_ETH_INFO_TIANYI);%>";
function isPortInAttrName()
{
    if((1 == TianYiFlag) && ('E8C' == CurrentBin.toUpperCase()))
	{
		return true;
	}
	return false;
}
if (ClassificationInfoList.length - 1 > 0)
{
	for (var i = 0; i < ClassificationInfoList.length - 1; i++)
	{
		var id = ClassificationInfoList[i].Domain.split("."); 
		ClassificationInfoList[i].ClassificationId = id[id.length -1];
		SortClassId[i] = ClassificationInfoList[i].ClassificationId;
	}
}

if (ClassificationInfoListDown.length - 1 > 0) {
    for (var i = 0; i < ClassificationInfoListDown.length - 1; i++) {
        var id = ClassificationInfoListDown[i].Domain.split(".");
        ClassificationInfoListDown[i].ClassificationId = id[id.length -1];
        SortClassIdDown[i] = ClassificationInfoListDown[i].ClassificationId;
    }
}

if (AppInfoList.length - 1 > 0)
{
	for (var i = 0; i < AppInfoList.length - 1; i++)
	{
		var id = AppInfoList[i].Domain.split("."); 
		AppInfoList[i].AppId = id[id.length -1];
		SortAppId[i] = AppInfoList[i].AppId;
	}
}

function IdSort(array)
{ return array.sort(function(a, b)
{ return a - b; }); 
}

var ClsTypeInfoList = new Array();
var ClsTypeInfoListDown = new Array();
if (ClsTypeList.length - 1 > 0)
{
	var ClassTypeItemNr = new Array();		
	
	for (var i = 0; i < ClsTypeList.length - 1; i++)
	{
		var id = ClsTypeList[i].Domain.split("."); 
		ClsTypeList[i].ClassificationId = id[id.length -3];
		ClsTypeList[i].ClassificationTypeId = id[id.length -1];
		if (ClsTypeList[i].Type == "LANInterface")
		{
			var lanminstr = ClsTypeList[i].Min.split("."); 
			var lanmaxstr = ClsTypeList[i].Max.split("."); 
			if (lanminstr[lanminstr.length-2] == "LANEthernetInterfaceConfig")
			{
				if(isPortInAttrName())
				{
					ClsTypeList[i].MinShow = getTianYilandesc(lanminstr[lanminstr.length-1]);	
				}
				else
				{
					ClsTypeList[i].MinShow = "LAN" + lanminstr[lanminstr.length-1];
				}
			}
			else if (lanminstr[lanminstr.length-2] == "WLANConfiguration")
			{
				ClsTypeList[i].MinShow = "SSID" + lanminstr[lanminstr.length-1];
			}
			
			if (lanmaxstr[lanmaxstr.length-2] == "LANEthernetInterfaceConfig")
			{
				if(isPortInAttrName())
				{
					ClsTypeList[i].MaxShow = getTianYilandesc(lanmaxstr[lanmaxstr.length-1]);
				}
				else
				{
					ClsTypeList[i].MaxShow = "LAN" + lanmaxstr[lanmaxstr.length-1];
				}
			}
			else if (lanmaxstr[lanmaxstr.length-2] == "WLANConfiguration")
			{
				ClsTypeList[i].MaxShow = "SSID" + lanmaxstr[lanmaxstr.length-1];
			}
		}
		if (ClsTypeList[i].Type == "WANInterface")
		{
			ClsTypeList[i].MinShow = "";
			ClsTypeList[i].MaxShow = "";

		}

		
		var InstId = ClsTypeList[i].ClassificationId;
		if(typeof(ClassTypeItemNr[InstId]) == 'undefined')
			ClassTypeItemNr[InstId] = 1;
		else
			ClassTypeItemNr[InstId] ++;	
		
		
		if(ClassTypeItemNr[InstId] > 4)
		{
			continue;
		}
		
		ClsTypeInfoList.push(ClsTypeList[i]);
	}
}
ClsTypeInfoList.push(null);

if (ClsTypeListDown.length - 1 > 0) {
    var ClassTypeItemNr = new Array();

    for (var i = 0; i < ClsTypeListDown.length - 1; i++) {
        var id = ClsTypeListDown[i].Domain.split("."); 
        ClsTypeListDown[i].ClassificationId = id[id.length -3];
        ClsTypeListDown[i].ClassificationTypeId = id[id.length -1];
        if (ClsTypeListDown[i].Type == "LANInterface") {
            var lanminstr = ClsTypeListDown[i].Min.split("."); 
            var lanmaxstr = ClsTypeListDown[i].Max.split("."); 
            if (lanminstr[lanminstr.length-2] == "LANEthernetInterfaceConfig") {
                if (isPortInAttrName()) {
                    ClsTypeListDown[i].MinShow = getTianYilandesc(lanminstr[lanminstr.length-1]);
                } else {
                    ClsTypeListDown[i].MinShow = "LAN" + lanminstr[lanminstr.length-1];
                }
            } else if (lanminstr[lanminstr.length-2] == "WLANConfiguration") {
                ClsTypeListDown[i].MinShow = "SSID" + lanminstr[lanminstr.length-1];
            }

            if (lanmaxstr[lanmaxstr.length-2] == "LANEthernetInterfaceConfig") {
                if (isPortInAttrName()) {
                    ClsTypeListDown[i].MaxShow = getTianYilandesc(lanmaxstr[lanmaxstr.length-1]);
                } else {
                    ClsTypeListDown[i].MaxShow = "LAN" + lanmaxstr[lanmaxstr.length-1];
                }
            } else if (lanmaxstr[lanmaxstr.length-2] == "WLANConfiguration") {
                ClsTypeListDown[i].MaxShow = "SSID" + lanmaxstr[lanmaxstr.length-1];
            }
        }

        if (ClsTypeListDown[i].Type == "WANInterface") {
            ClsTypeListDown[i].MinShow = "";
            ClsTypeListDown[i].MaxShow = "";
        }

        var InstId = ClsTypeListDown[i].ClassificationId;
        if (typeof(ClassTypeItemNr[InstId]) == 'undefined') {
            ClassTypeItemNr[InstId] = 1;
        } else {
            ClassTypeItemNr[InstId] ++;
        }

        if(ClassTypeItemNr[InstId] > 4) {
            continue;
        }

        ClsTypeInfoListDown.push(ClsTypeListDown[i]);
    }
}
ClsTypeInfoListDown.push(null);

if (PQInfoList.length == 1)
{
	for (var i = 0; i < DefaultPQList.length - 1; i++)
	{
		PriorityQueueInfoList[i] = DefaultPQList[i];
	}
}
else if (PQInfoList.length > 1)
{
	var i = 0;	
	var j = 0;
	var PQId = "";
	for (i = 0; i < PQInfoList.length - 1; i++)
	{
	    PQId = PQInfoList[i].Domain.charAt(PQInfoList[i].Domain.length-1);
		PriorityQueueInfoList[PQId-1] = PQInfoList[i];
	}
	for (j = 0; j < DefaultPQList.length - 1; j++)
	{
		if (PriorityQueueInfoList[j] == null)
		{
			PriorityQueueInfoList[j] = DefaultPQList[j];
		}
	}
}

if (PQInfoListDown.length == 1) {
    for (var i = 0; i < DefaultPQListDown.length - 1; i++) {
        PriorityQueueInfoListDown[i] = DefaultPQListDown[i];
    }
} else if (PQInfoListDown.length > 1) {
    var i = 0;
    var j = 0;
    var PQId = "";
    for (i = 0; i < PQInfoListDown.length - 1; i++) {
        PQId = PQInfoListDown[i].Domain.charAt(PQInfoListDown[i].Domain.length-1);
        PriorityQueueInfoListDown[PQId-1] = PQInfoListDown[i];
    }

    for (j = 0; j < DefaultPQListDown.length - 1; j++) {
        if (PriorityQueueInfoListDown[j] == null) {
            PriorityQueueInfoListDown[j] = DefaultPQListDown[j];
        }
    }
}

function GetQosBasicInfoList()
{
	return QosBasicInfoList;
}

function GetQosBasicInfoListDown()
{
    return QosBasicInfoListDown;
}

function GetAppInfoList()
{
	return AppInfoList;
}

function GetClassificationInfoList()
{
	return ClassificationInfoList;
}

function GetClassificationInfoListDown()
{
    return ClassificationInfoListDown;
}

function GetClassificationTypeInfoList()
{
	return ClsTypeInfoList;
}

function GetClassificationTypeInfoListDown()
{
    return ClsTypeInfoListDown;
}

function GetPriorityQueueInfoList()
{
	return PriorityQueueInfoList;
}

function GetPriorityQueueInfoListDown()
{
    return PriorityQueueInfoListDown;
}

function GetSortClassInfoList()
{
	return IdSort(SortClassId);
}

function GetSortClassInfoListDown()
{
    return IdSort(SortClassIdDown);
}

function GetSortAppInfoList()
{
	return IdSort(SortAppId);
}
