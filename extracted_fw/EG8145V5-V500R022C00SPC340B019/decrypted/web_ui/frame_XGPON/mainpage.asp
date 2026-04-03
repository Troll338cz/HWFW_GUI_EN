<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Pragma" content="no-cache" />
<link href="/Cuscss/<%HW_WEB_GetCusSource(frame.css);%>" rel="stylesheet" type="text/css" />
<link href="/Cuscss/<%HW_WEB_GetCusSource(index.css);%>" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="../images/singtel.ico" />
<link rel="Bookmark" href="../images/singtel.ico" />
<script src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script src="/resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>" type="text/javascript" ></script>
<script src="/frameaspdes/<%HW_WEB_Resource(ssmpdes.js);%>" language="JavaScript"></script>
<script src="/Cusjs/<%HW_WEB_CleanCache_Resource(frame.asp);%>" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var IsSupportWifi = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
var UserName = '<%HW_WEB_GetCurUserName();%>';
var ConfigFlag = '<%HW_WEB_GetGuideFlag();%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var mngttype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var logo_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var mngtpccwtype = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_PCCW);%>';
var ProductName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var IsSmartDev = "<%HW_WEB_GetFeatureSupport(HW_OSGI_FT_BUNDLEINFOWEB);%>";
var appUrl = '<%HW_WEB_GetSPEC(SPEC_STC_APP_URL.STRING);%>';
var HostingQRcodeEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_AppRemoteManage.HostingQRcodeEnable);%>';
document.title = ProductName;

var menuJsonData;
var UpgradeFlag = 0;  //0--normal, 1--updating, 2--diagnosing

$.ajax({
	type : "POST",
	async : false,
	cache : false,
	url : "asp/getMenuArray.asp",
	success : function(data) {
		 menuJsonData  = dealDataWithFun(data);
	}
});

/*re-direct to user-guide page when user login for the first time*/
if(curUserType == sysUserType
	&& !parseInt(ConfigFlag.split("#")[0], 10))
{
	if (true == logo_singtel)
	{
		window.location="/html/ssmp/cfgguide/guideindex_singtel.asp";
	}
	else
	{
		window.location="/html/ssmp/cfgguide/guideindex.asp";
	}
}
else if(curUserType == sptUserType
	&& !parseInt(ConfigFlag.split("#")[1], 10)
	&& 1 != parseInt(mngtpccwtype, 10))
{
	if (true == logo_singtel)
	{
		window.location="CustomApp/userguideframe_singtel.asp";
	}
	else
	{
		window.location="CustomApp/userguideframe.asp";
	}
}

function GetIdByUrl(Type, BaseUrl)
{	
	var NewId = Type+"_";
	var MarkEnd="";
	try{
		var lastindex = BaseUrl.lastIndexOf('/');
		if( lastindex > -1 )
		{
			NewId += BaseUrl.substring(lastindex+1, BaseUrl.length);
		}
		else
		{
			NewId += BaseUrl;
		}
		
		if(NewId.indexOf("?") > -1)
		{
			MarkEnd = NewId.split("?")[1];
		}
		
		NewId = NewId.split(".")[0]+MarkEnd;
		
	}catch(e){
		NewId += Math.round(Math.random() * 10000);
	}
	return NewId;
}

function loadframe()
{
	if("1" != HostingQRcodeEnable)
	{
		$("#AppDiv").css("display", "none");
		$("#guidespacetwo").css("display", "none");
	}
	else
	{
		$("#AppDiv").css("display", "block");
		$("#guidespacetwo").css("display", "block");
	}
	
	if(  ( parseInt(mngttype, 10) == 1 || parseInt(mngtpccwtype, 10) == 1 ) && curUserType != sysUserType  )
	{
		$("#configguide").css("display", "none");
		$("#guidespaceone").css("display", "none");
	}
	else
	{
		$("#configguide").css("display", "block");
		$("#guidespaceone").css("display", "block");
	}
	
	if(parseInt(mngttype, 10) != 1)
	{
		if(parseInt(logo_singtel, 10) != 1)
		{
		    $("#headerbrandlog").css("display", "block");   
		}
		else
		{		    
		    $("#headerbrandlogSingtel").css("display", "block");
		}		
	}
}

function goToGuidePage()
{
	if (!ifCanChangeMenu())
	{
		return ;
	}

	if (curUserType == sysUserType)
	{
		if (true == logo_singtel)
		{
			window.location="/html/ssmp/cfgguide/guideindex_singtel.asp";
		}
		else
		{
			window.location="/html/ssmp/cfgguide/guideindex.asp";
		}
	}
	else
	{
		if (true == logo_singtel)
		{
			window.location="CustomApp/userguideframe_singtel.asp";
		}
		else
		{
			window.location="CustomApp/userguideframe.asp";
		}
	}
}

function ifCanChangeMenu()
{
	if (UpgradeFlag == 1)
	{
		if(confirm(framedesinfo["mainpage016"]))
		{
			UpgradeFlag = 0;
			return true;
		}
		else
		{
			return false;
		}
	}
	else if (UpgradeFlag == 2)
	{
		if(confirm(framedesinfo["mainpage017"]))
		{
			UpgradeFlag = 0;
			return true;
		}
		else
		{
			return false;
		}
	}

	return true;
}

function toggleQRCodeDisplay(flag)
{
	var Type = flag;
	if (flag == 'auto')
	{
		var displayflag = document.getElementById("D2CodeDivInfo").style.display;
		Type = "block" == displayflag ? "none" : "block";
	}
	$('#D2CodeDivInfo').css("display", Type);
}

function adjustParentHeight()
{
	var menuBar = $("#SecondMenuInfo");
	adjustFrameHeight("maincenter", "menuIframe", 280, (menuBar != null ? menuBar.innerHeight() + 100 : null));
}
</script>
</head>
<body onload="loadframe();">
<div id="indexpage">
<div id="headerbg">
<div id="header">

<script>
if(true == logo_singtel)
{
	document.write('<div id="headerbrandlogSingtel"></div>');				
}
else
{
	document.write('<div id="headerbrandlog"></div>');
}
</script>    
    
<script>
if(true != logo_singtel)
{
	document.write('<div id="headerProductName">' + ProductName + '</div>');
}
</script>
<div id="HeaderRightMenu">
<div id="headerLogout"><span id="headerLogoutText" class="HeaderSpanTextGuide" onclick="logoutfunc();"  BindText="mainpage009"></span></div>
<div id="headeruser"><span id="username" class="HeaderSpanTextGuide" ></span></div>
<div id="guidespaceone" class="guidespace"><div class="guidespacebar"></div></div>
<div id="configguide"><span id="configguidetext" class="HeaderSpanTextGuide" onclick="goToGuidePage();" BindText="mainpage008"></span></div>
<div id="guidespacetwo" class="guidespace"><div class="guidespacebar"></div></div>

<div id="AppDiv">
<div id="MaPoniterText"><span class="HeaderSpanTextGuide" BindText="mainpage013"></span></div>
<div id="MaPoniterIcon"></div>
<div id="D2CodeDivInfo">
<div id="FirstLineIcon">
<div id="phoneicon"><img src="images/D2CodePhone.jpg"></div>
<div id="phonetext"><span BindText="mainpage007"></span></div>
</div><!-- end of FirstLineIcon -->
<div id="D2CodeTop">
<div class="D2CodeCornerLeft"></div>
<div class="D2CodeCornerRigth"></div>
</div>
<div id="D2CodeIcon"></div>
<div id="D2CodeBottom">
<div class="D2CodeCornerLeft"></div>
<div class="D2CodeCornerRigth"></div>
</div>
</div><!--end of D2CodeDivInfo -->
</div><!--end of AppDiv -->
<script>
if(true == logo_singtel)
{
	document.write('<div id="headerRightProductName"><span class="HeaderSpanProduct">' + ProductName + '</span></div>');
}
</script>
</div><!-- end of HeaderRightMenu -->
</div>
</div>
<div id="maincenter">
<div id="MenuInfo"></div>
<div id="SecondMenuInfo" class="Menuhide"></div>
<div id="content">
<iframe id="menuIframe" frameborder="0" width="100%" height="100%" marginheight="0" marginwidth="0" class="AspWidth" scrolling="no" overflow="hidden"></iframe>
</div> <!-- end of content-->
</div><!-- end of maincenter-->

<div id="fresh">
<iframe frameborder="0" width="100%" height="100%" marginheight="0" marginwidth="0" scrolling="no" src="refresh.asp"></iframe>
</div>
</div>
</body>
<script type="text/javascript">
var Firststr = '<div id="MenuFirstLineSpace"><div id="MenuFirstLineIcon"></div><div id="MenuFirstLineMid"></div><div id="MenuFirstLineSpaceborder"></div></div>';

var menulist = [];
var activeMenuId = null;

function stMenuData(id, path, level, defico, clickico, url, defchild)
{
	this.id         = id;
	this.path       = ((path == '') ? '' : (path + '.')) + id;
	this.level      = level;
	this.defico     = defico;
	this.clickico   = clickico;
	this.url        = url;
	this.defchild   = defchild;
	this.hasChild	= false;
}

function setLv1MenuStyle(id, flag, ifOnlyChangeStyle)
{
	var menu = menulist[id];

	if (flag)
	{
		//change menu style
		$("#"         + id).addClass("menuContentActive");
		$("#name_"    + id).addClass("menuContTitleActive");
		$("#pointer_" + id).addClass("menuContPointerActive");
		$("#icon_"    + id).css("background", "url( " + menu.clickico + ") no-repeat center");

		if ((ifOnlyChangeStyle != null) && (ifOnlyChangeStyle == "onlyshow"))
			return menu;

		//show default sub-menu
		if ((menu.defchild != menu.id) //default menu is not menu its self, activate sub-menu
			&& menu.hasChild)
		{
			return setLv2MenuStyle(menu.defchild, flag); //activate default sub-menu;
		}
	}
	else
	{
		//change menu style
		$("#"		  + id).removeClass("menuContentActive");
		$("#name_"	  + id).removeClass("menuContTitleActive");
		$("#pointer_" + id).removeClass("menuContPointerActive");
		$("#icon_"	  + id).css("background", "url( " + menu.defico + ") no-repeat center");
	}
	return menu;
}

function setLv2MenuStyle(id, flag, ifOnlyChangeStyle)
{
	var menu = menulist[id];
	var parentId = menu.path.split('.')[0];

	if (flag)
	{
		//change parent menu style
		setLv1MenuStyle(parentId, flag, "onlyshow");
		//change menu style of itself
		if (!menu.hasChild) $("#name_" + id).addClass("SecondMenuTitleActive");

		if ((ifOnlyChangeStyle != null) && (ifOnlyChangeStyle == "onlyshow"))
			return menu;

		//show default sub-menu
		if ((menu.defchild != menu.id) //default menu is not menu its self, activate sub-menu
			&& menu.hasChild)
		{
			//change menu pointer style
			$("#pointer_" + id).removeClass("SecondMenuPointer");
			$("#pointer_" + id).addClass("SecondMenuPointerBlock");
			return setLv3MenuStyle(menu.defchild, flag); //activate default sub-menu;
		}
		else
		{
			//change menu pointer style
			$("#pointer_" + id).removeClass("SecondMenuPointerBlock");
			if (menu.hasChild)
				$("#pointer_" + id).addClass("SecondMenuPointer");
			else
				$("#pointer_" + id).addClass("SecondMenuNullPointer");
		}
	}
	else
	{
		//change menu style
		$("#name_" + id).removeClass("SecondMenuTitleActive");
		//change menu pointer style
		$("#pointer_" + id).removeClass("SecondMenuPointerBlock");
		if (menu.hasChild)
			$("#pointer_" + id).addClass("SecondMenuPointer");
		else
			$("#pointer_" + id).addClass("SecondMenuNullPointer");
	}
	return menu;
}

function setLv3MenuStyle(id, flag)
{
	var menu = menulist[id];

    if (id == "")
    {
        id="menuid_3";
	}

	if (flag)
	{
		var parentId = menu.path.split('.')[1];
		//change parent menu style
		setLv2MenuStyle(parentId, flag, "onlyshow");
		//change menu style
		$("#"+id).addClass("ThirdMenuTitleActive")
	}
	else
	{
		//change menu style
		$("#"+id).removeClass("ThirdMenuTitleActive")
	}
	return menu;
}

function activeMenuStyle(id)
{
	var menu = menulist[id];

	if (menu == null)
		return null;

	var ids = menu.path.split('.');
	switch(menu.level)
	{
		case 3:
			menu = setLv3MenuStyle(ids[2], true); //set style of lv3 menu and parent lv2 & lv1 menu
			break;
		case 2:
			menu = setLv2MenuStyle(ids[1], true); //set style of lv2 menu and parent lv1 menu, active default lv3 menu
			break;
		default:
			menu = setLv1MenuStyle(ids[0], true); //set style of lv1 menu style, active default lv2 or lv3 menu
			break;
	}
	return menu;
}

function deactiveMenuStyle(id)
{
	var menu = menulist[id];

	if (menu == null)
		return ;

	var ids = menu.path.split('.');
	switch(menu.level)
	{
		case 3:
			setLv3MenuStyle(ids[2], false); //reset lv3 menu style
		case 2:
			setLv2MenuStyle(ids[1], false); //reset lv2 menu style
		default:
			setLv1MenuStyle(ids[0], false); //reset lv1 menu style
	}
}

function changeCrossLvMenuStyle(oldId, newId)
{
	var oldMenu = menulist[oldId];
	var newMenu = menulist[newId];

	if ((oldMenu == null) || (newMenu == null)) //page loaded for the first time
		return;

	if (oldMenu.level == newMenu.level) //check whether its parent menu is the same or not
	{
		switch(oldMenu.level)
		{
			case 3:
				var lv2id_o = oldMenu.path.split('.')[1];
				var lv2id_n = newMenu.path.split('.')[1];
				if (lv2id_o != lv2id_n) //different parent, change lv3 menu list
				{
					$("#" + lv2id_o + "_menu").addClass("Menuhide");
					$("#" + lv2id_n + "_menu").removeClass("Menuhide");
				}
				else //same parent, change lv2 parent pointer style, because it has been deactivated
				{
					$("#pointer_" + lv2id_n).removeClass("SecondMenuPointer");
					$("#pointer_" + lv2id_n).addClass("SecondMenuPointerBlock");
				}
			case 2:
				var lv1id_o = oldMenu.path.split('.')[0];
				var lv1id_n = newMenu.path.split('.')[0];
				if (lv1id_o != lv1id_n)
				{
					$("#" + lv1id_o + "_subMenus").addClass("Menuhide");
					$("#" + lv1id_n + "_subMenus").removeClass("Menuhide");
				}
			default:
				break;
		}
	}
	else if (oldMenu.level < newMenu.level)
	{
		//change from upper level to lower level
		var lv1id_n = newMenu.path.split('.')[0];
		var lv1id_o = oldMenu.path.split('.')[0];

		//show lv2 menu list
		if (lv1id_o != lv1id_n)
			$("#" + lv1id_o + "_subMenus").addClass("Menuhide");
		$("#" + lv1id_n + "_subMenus").removeClass("Menuhide");
		$("#SecondMenuInfo").removeClass("Menuhide");
		$("#SecondMenuInfo").addClass("Menushow");
		if (newMenu.level > 2)
		{
			var lv2id = newMenu.path.split('.')[1];
			//show lv3 menu list
			$("#" + lv2id + "_menu").removeClass("Menuhide");
		}
		if (oldMenu.level < 2)
		{
			//collapse lv1 menu list
			expandFirstMenuTitle(false);
		}
	}
	else
	{
		//change from lower level to upper level
		if (oldMenu.level > 2)
		{
			var lv2id = oldMenu.path.split('.')[1];
			//hide lv3 menu list
			$("#"+lv2id+"_menu").addClass("Menuhide");
		}

		if (newMenu.level < 2)
		{
			var lv1id = oldMenu.path.split('.')[0];
			//hide lv2 menu list
			$("#" + lv1id + "_subMenus").addClass("Menuhide");
			$("#SecondMenuInfo").removeClass("Menushow");
			$("#SecondMenuInfo").addClass("Menuhide");
			//expand lv1 menu list
			expandFirstMenuTitle(true);
		}
		else
		{
			var lv1id_o = oldMenu.path.split('.')[0];
			var lv1id_n = newMenu.path.split('.')[0];
			if (lv1id_o != lv1id_n)
			{
				$("#" + lv1id_o + "_subMenus").addClass("Menuhide");
				$("#" + lv1id_n + "_subMenus").removeClass("Menuhide");
			}
		}
	}
}
function onMenuChange1(id,url)
{
	toggleQRCodeDisplay('none');

	if (!ifCanChangeMenu())
	{
		return;
	}

	if (activeMenuId != null)
	{
		deactiveMenuStyle(activeMenuId);
	}

	var menu = activeMenuStyle(id);

	changeCrossLvMenuStyle(activeMenuId, menu.id);

	if (menu != null)
		$("iframe#menuIframe").attr("src", url);

	activeMenuId = menu.id;
}

function onMenuChange(id)
{
	toggleQRCodeDisplay('none');

	if (!ifCanChangeMenu())
	{
		return;
	}

	if (activeMenuId != null)
	{
		deactiveMenuStyle(activeMenuId);
	}

	var menu = activeMenuStyle(id);

	changeCrossLvMenuStyle(activeMenuId, menu.id);

	if (menu != null)
		$("iframe#menuIframe").attr("src", menu.url);

	activeMenuId = menu.id;
}

function setParentDefchild(parentId, id)
{
	var menu = menulist[parentId];
	if ((menu != null)
		/*&& (menu.url == null)*/
		&& (menu.defchild == parentId))
	{
		menu.defchild = id;
	}
}

/*create level-3 menus*/
function CreateThirdMenu(htmlTagId, parentId, parentPath, subMenus)
{
	var m3contain = document.getElementById(htmlTagId);

	for (var i in subMenus)
	{
		var id = subMenus[i].id;

		menulist[id] = new stMenuData(id, parentPath, 3,
									  subMenus[i].deficon,
									  subMenus[i].clickicon,
									  subMenus[i].url, id);
		
		var m3namesr = GetIdByUrl("m3div",subMenus[i].url);
		var m3title = document.createElement("div");
		m3title.id = id;
		//m3title.name = m3namesr;
		m3title.setAttribute('name',m3namesr); 
		m3title.className = "ThirdMenuTitle";
		m3title.onclick   = function(){ onMenuChange(this.id); }
		GetMenuTitle(subMenus[i].name, "third", m3title);
		var str = GetMenuStr(subMenus[i].name, "second");
		var txt = document.createTextNode(str.replace(/&nbsp;/g," "));
		m3title.appendChild(txt);
		m3contain.appendChild(m3title);

		if (i == 0)
		{
			setParentDefchild(parentId, id);
		}
	}
}

/*create level-2 menus*/
function CreateSecondMenu(parentId, parentPath, subMenus)
{
	var m2list = document.getElementById("SecondMenuInfo");
	var m2contain = document.createElement("div");
	
	m2contain.id = parentId + "_subMenus";
	m2contain.className = "Menuhide";
	m2list.appendChild(m2contain);

	for (var i in subMenus)
	{
		var id = subMenus[i].id;

		menulist[id] = new stMenuData(id, parentPath, 2,
									  subMenus[i].deficon,
									  subMenus[i].clickicon,
									  subMenus[i].url, id);

		var m2namesr = GetIdByUrl("m2div",subMenus[i].url);
		var m2menu = document.createElement("div");
		//m2menu.name = m2namesr;
		m2menu.setAttribute('name',m2namesr); 
		m2menu.id = id;
		m2menu.className = "SecondmenuContent";
		m2menu.onclick   = function() { onMenuChange(this.id); }
		m2contain.appendChild(m2menu);
		var m2title = document.createElement("div");
		m2title.id = "name_"+id;
		m2title.className = "SecondMenuTitle";
		GetMenuTitle(subMenus[i].name, "second", m2title);
		var str = GetMenuStr(subMenus[i].name, "second");
		var txt = document.createTextNode(str.replace(/&nbsp;/g," "));
		m2title.appendChild(txt);
		m2menu.appendChild(m2title);
		var m2pointer = document.createElement("div");
		m2menu.appendChild(m2pointer);
		m2pointer.id = "pointer_" + id;

		if (subMenus[i].subMenus != undefined)
		{
			m2pointer.className = "SecondMenuPointer";
			m2children = document.createElement("div");
			m2children.id = id + "_menu";
			m2children.className = "Menuhide";
			m2contain.appendChild(m2children);
			CreateThirdMenu(m2children.id, id, menulist[id].path, subMenus[i].subMenus);
			menulist[id].hasChild = true;
		}
		else
		{
			m2pointer.className = "SecondMenuNullPointer";
		}

		if (i == 0)
		{
			setParentDefchild(parentId, id);
		}
	}
}

/*create level-1 menus*/
for(var FirstMenuindex in menuJsonData)
{
	var m1namesr = GetIdByUrl("m1div",menuJsonData[FirstMenuindex].url);
	var id = menuJsonData[FirstMenuindex].id;
	Firststr += '<div class="menuContent" id=' + id + ' onclick="onMenuChange(this.id);">';

	Firststr +='<div class="FirstMenuIcon" id="icon_' + id + '" style="background: url(' + menuJsonData[FirstMenuindex].deficon + ') no-repeat center"></div>';
	Firststr +='<div class="menuContTitle" id="name_' + id + '" name="' + m1namesr + '"'+ GetMenuTitle(menuJsonData[FirstMenuindex].name, "first") + '>'
			 + GetMenuStr(menuJsonData[FirstMenuindex].name, "first")
			 + '</div>';
	Firststr +='<div class="menuContPointer menuContPointerdef" id="pointer_' + id + '"></div>';
	Firststr +='</div>';
	menulist[id] = new stMenuData(id, '', 1,
								  menuJsonData[FirstMenuindex].deficon,
								  menuJsonData[FirstMenuindex].clickicon,
								  menuJsonData[FirstMenuindex].url, id);

	if(undefined != menuJsonData[FirstMenuindex].subMenus)
	{
		CreateSecondMenu(id, menulist[id].path, menuJsonData[FirstMenuindex].subMenus);
		menulist[id].hasChild = true;
	}
}
Firststr += '<div id="MenuBottomLineSpace"><div id="MenuBottomLineIcon"></div><div id="MenuBottomLineMid"></div><div id="MenuBottomLineSpaceborder"></div></div>';
$("#MenuInfo").append(Firststr);

ParseBindTextByTagName(framedesinfo, "span", 1);
ParseBindTextByTagName(framedesinfo, "div",  1);
document.getElementById('username').appendChild(document.createTextNode(UserName));

var UpgradeHeigthHandle = setInterval("adjustParentHeight();", 200);

var FirstclickExpansion = menuJsonData[0].id;
$("#" + FirstclickExpansion).trigger("click");

$("#AppDiv").click(function() {
	toggleQRCodeDisplay('auto');
});

$("#D2CodeIcon").click(function() {
	window.open(appUrl, "newwindow");
});

function getMenuStrDefLen(level)
{
	var length = 0;

	if (curLanguage.toUpperCase() == "CHINESE")
	{
		length = 8;
	}
	else if(curLanguage.toUpperCase() == "JAPANESE")
	{
		if (level == "first" )
		{
			length = 12;
		}
		else
		{
			length = 8;
		}
	}
	else
	{
		if (level == "first" )
		{
			length = 22;
		}
		else
		{
			length = 18;
		}
	}

	return length;
}

function GetMenuStr(datastr, level)
{
	var length = getMenuStrDefLen(level);
	var MenuName = GetStringContentForTitle(datastr, length);
	return MenuName;
}

function GetMenuTitle(datastr, level, element)
{
	var length = getMenuStrDefLen(level);
	var titlestr = "";
	if (datastr.length > length)
	{
		titlestr = ' title="' + datastr + '" ';
		if (element != null)
			element.setAttribute("title", datastr);
	}
	return titlestr;
}

function expandFirstMenuTitle(flag)
{
	var id;
	var action = ((flag == true) ? "block" : "none");

	$('#MenuFirstLineMid').css("display", action);
	$('#MenuBottomLineMid').css("display", action);

	for(var tmp in menulist)
	{
		if (menulist[tmp].level != 1) continue;
		id = "name_" + menulist[tmp].id;
		$('#' + id).css("display", action);
	}
}
</script>
</html>