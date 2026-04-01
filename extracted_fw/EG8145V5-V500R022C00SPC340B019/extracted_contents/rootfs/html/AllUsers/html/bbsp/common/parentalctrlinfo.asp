function UserDevice(domain, MacAddr,HostName)
{
	this.domain     = domain;
	this.MacAddr    = MacAddr;
	this.HostName   = HostName;
}

function ChildListClass(domain, MACAddress,Description,TemplateInst)
{
	this.domain = domain;
	this.MACAddress = MACAddress;
	this.Description = Description;
	this.TemplateInst = TemplateInst;
}

function TemplatesListExClass(domain,Name,UrlFilterPolicy,UrlFilterRight,StartDate,EndDate,DurationPolicy,DurationRight,CategoryFiltList)
{
	this.domain = domain;
	this.TemplateId = "";
	this.Name = Name;
	this.UrlFilterPolicy = UrlFilterPolicy;
	this.UrlFilterRight = UrlFilterRight;
	this.StartDate = StartDate;
	this.EndDate = EndDate;
	this.DurationPolicy = DurationPolicy;
	this.DurationRight = DurationRight;
	this.CategoryFiltList = CategoryFiltList;
}

function TemplatesListClass(domain,Name,UrlFilterPolicy,UrlFilterRight,StartDate,EndDate,DurationPolicy,DurationRight)
{
	this.domain = domain;
	this.TemplateId = "";
	this.Name = Name;
	this.UrlFilterPolicy = UrlFilterPolicy;
	this.UrlFilterRight = UrlFilterRight;
	this.StartDate = StartDate;
	this.EndDate = EndDate;
	this.DurationPolicy = DurationPolicy;
	this.DurationRight = DurationRight;
}

function DurationListClass(domain, StartTime,EndTime,RepeatDay)
{
	this.domain     = domain;
	this.TemplateId = "";
	this.StartTime  = StartTime;
	this.EndTime    = EndTime;
	this.RepeatDay  = RepeatDay;
}

function UrlValueClass(_Domain, _Url)
{
	this.Domain = _Domain;
	this.Url = _Url;
}

function TimeShowClass(TemplateTime, TemplateRepeatDay)
{
	this.TemplateTime = TemplateTime;
	this.TemplateRepeatDay = TemplateRepeatDay;
}

function ResCategoriesShowClass(CategoryDesc, Categories) {
	this.CategoryDesc = CategoryDesc;
	this.Categories = Categories;
}

function BindShowClass(MACAddress, Description)
{
	this.MACAddress = MACAddress;
	this.Description = Description;
}

function UrlShowClass(seq, UrlAddress)
{
	this.seq = seq;
	this.UrlAddress = UrlAddress;
}

function CategoryUrlShowClass(domain, UrlAddress) {
	this.domain = domain;
	this.UrlAddress = UrlAddress;
}

function StatsListClass(domain, PacketsBlockedByTime_High,PacketsBlockedByTime_Low,PacketsBlockedByUrl_High,PacketsBlockedByUrl_Low)
{
	this.domain     = domain;
	this.TemplateId = "";
	this.PacketsBlockedByTime_High  = PacketsBlockedByTime_High;
	this.PacketsBlockedByTime_Low   = PacketsBlockedByTime_Low;
	this.PacketsBlockedByUrl_High   = PacketsBlockedByUrl_High;
	this.PacketsBlockedByUrl_Low    = PacketsBlockedByUrl_Low;
}

function CategoryListClass(domain, categoryName) {
	this.domain = domain;
	this.categoryName = categoryName;
}

function UrlAddressClass(domain, urlAddress) {
	this.domain = domain;
	this.urlAddress = urlAddress;
}

var urlFilCategoryEnable = '<%HW_WEB_GetFeatureSupport(FT_URLFIL_CATEGORY);%>';
var CategoryListArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.ParentalCtrl.URLCategory.{i}, CategoryName, CategoryListClass);%>;
var CategoryListArrayNr = CategoryListArray.length - 1;
var UrlAddressArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.ParentalCtrl.URLCategory.{i}.URLList.{i}, URLAddress, UrlAddressClass);%>;
var UrlAddressArrayNr = UrlAddressArray.length - 1;

var UserDevicesListArray = <%HW_WEB_GetSpecParaArryByDomain(HW_WEB_SpecialGetUserDevInfo,InternetGatewayDevice.LANDevice.1.X_HW_UserDev.{i},MacAddr|HostName,UserDevice);%>;
var UserDevicesListArrayNr = UserDevicesListArray.length - 1;

var ChildListArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.ParentalCtrl.MAC.{i},MACAddress|Description|TemplateInst,ChildListClass);%>;
var ChildListArrayNr = ChildListArray.length-1;

var TemplatesListArray;
if (urlFilCategoryEnable == 1) {
	TemplatesListArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.ParentalCtrl.Templates.{i},Name|UrlFilterPolicy|UrlFilterRight|StartDate|EndDate|DurationPolicy|DurationRight|URLCategoryFilterList,TemplatesListExClass);%>;
} else {
	TemplatesListArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.ParentalCtrl.Templates.{i},Name|UrlFilterPolicy|UrlFilterRight|StartDate|EndDate|DurationPolicy|DurationRight,TemplatesListClass);%>;
}

var TemplatesListArrayNr = TemplatesListArray.length-1;
for (var i = 0; i < TemplatesListArrayNr; i++)
{
	var id = TemplatesListArray[i].domain.split(".");
	TemplatesListArray[i].TemplateId = id[id.length -1];
}


var DurationListArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.ParentalCtrl.Templates.{i}.Duration.{i},StartTime|EndTime|RepeatDay,DurationListClass);%>;
var DurationListArrayNr = DurationListArray.length-1;
for (var i = 0; i < DurationListArrayNr; i++)
{
	var id = DurationListArray[i].domain.split(".");
	DurationListArray[i].TemplateId = id[id.length -3];
}

var StatsListArray = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.ParentalCtrl.Templates.{i}.Stats,PacketsBlockedByTime_High|PacketsBlockedByTime_Low|PacketsBlockedByUrl_High|PacketsBlockedByUrl_Low,StatsListClass);%>;
for (var i = 0; i < StatsListArray.length -1; i++)
{
	var id = StatsListArray[i].domain.split(".");
	StatsListArray[i].TemplateId = id[id.length -2];
}

function UrlFilterUrlAddress(_Domain, _UrlAddress)
{
	this.Domain = _Domain;
	this.UrlAddress = _UrlAddress;
}
var UrlValueArrayAll = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_Security.ParentalCtrl.Templates.{i}.UrlFilter.{i},UrlAddress,UrlFilterUrlAddress);%>;

var FltsecLevel = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Security.X_HW_FirewallLevel);%>';

function GetUserDevicesList()
{
	return UserDevicesListArray;
}

function GetChildList()
{
	return ChildListArray;
}

function GetFilterApplyRange()
{
	var FilterApplyRange = "";
	if (ChildListArrayNr == 0)
	{
		FilterApplyRange = "SpecifiedDevice";
		return FilterApplyRange.toUpperCase();
	}
	else
	{
		for (var i = 0; i < ChildListArrayNr; i++)
		{
			if (ChildListArray[i].MACAddress.toUpperCase() == "FF:FF:FF:FF:FF:FF")
			{
				FilterApplyRange = "AllDevice";
				return FilterApplyRange.toUpperCase();
			}
		}
		FilterApplyRange = "SpecifiedDevice";
		return FilterApplyRange.toUpperCase();
	}
}

function GetTemplatesList()
{
	return TemplatesListArray;
}

function GetDurationList()
{
	return DurationListArray;
}

function GetStatsList()
{
	return StatsListArray;
}


function GetUrlValueArray(templateId)
{
	var selectDomain = "InternetGatewayDevice.X_HW_Security.ParentalCtrl.Templates." + templateId + '.';
	var UrlValueArray = new Array();
	for(var i = 0; i < UrlValueArrayAll.length - 1; i++){
		if( UrlValueArrayAll[i].Domain.indexOf(selectDomain) >= 0 ){
			UrlValueArray.push(UrlValueArrayAll[i]);
		}
	}
	return UrlValueArray;
}

function GetUrlArrayByCategory(categoryId) {
	var UrlArray = new Array();
	var selectDomain = "InternetGatewayDevice.X_HW_Security.ParentalCtrl.URLCategory." + categoryId + '.';
	for (var i = 0; i < UrlAddressArrayNr; i++) {
		if (UrlAddressArray[i].domain.indexOf(selectDomain) >= 0) {
			UrlArray.push(UrlAddressArray[i]);
		}
	}
	return UrlArray;
}

function GetCategoryNameByDomain(domain) {
	for (var i = 0; i < CategoryListArrayNr; i++) {
		if (CategoryListArray[i].domain == domain) {
			return CategoryListArray[i].categoryName;
		}
	}
	return "";
}

function GetTemplateUrlEnable(templateId)
{
	for (var i = 0; i < TemplatesListArrayNr; i++){
		if(templateId == TemplatesListArray[i].TemplateId){
			return (TemplatesListArray[i].UrlFilterRight == '0')?false:true;
		}
	}
	return false;
}

function GetCategoryFiltList(templateId) {
	for (var i = 0; i < TemplatesListArrayNr; i++){
		if(templateId == TemplatesListArray[i].TemplateId){
			return TemplatesListArray[i].CategoryFiltList;
		}
	}
	return "";
}

function GetFltsecLevel()
{
	return FltsecLevel;
}

function getHeight(id)
{
	var item = id;
	var height;
	if (item != null)
	{
		if (item.style.display == 'none')
		{
			return 0;
		}
		if (navigator.appName.indexOf("Internet Explorer") == -1)
		{
			height = item.offsetHeight;
		}
		else
		{
			height = item.scrollHeight;
		}
		if (typeof height == 'number')
		{
			return height;
		}
		return null;
	}

	return null;
}



