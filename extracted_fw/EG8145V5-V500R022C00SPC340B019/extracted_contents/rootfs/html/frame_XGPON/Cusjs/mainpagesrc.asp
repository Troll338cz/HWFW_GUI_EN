var menuArray = null;

var IGMPEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_IPTV.IGMPEnable);%>';
var var_singtel = '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>';
var var_singtel_hg8244hs = '<%HW_WEB_GetFeatureSupport(VOICE_FT_WEB_SINGTEL_HG8244HS);%>';
var CfgMode = '<%HW_WEB_GetCfgMode();%>';
var isMainpageCut = '<%HW_WEB_GetFeatureSupport(FT_WEB_MAINPAGE_CUT);%>';
var totalplay = '<%HW_WEB_GetFeatureSupport(FT_SSMP_TOTALPLAY);%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var isDnzvdf = '<%HW_WEB_GetFeatureSupport(FT_MNGT_DNZVDF);%>';

function IsSupportSamba()
{
	var IsSupportSamba = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_USBPRINTER);%>';
	return parseInt(IsSupportSamba,10);
}

function IsSupportWifi()
{
	var IsSupportWifi = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
	return parseInt(IsSupportWifi,10);
}

function IsWorkInAPBridged()
{
	var APMode = '<%HW_WEB_GetAPChangeModeValue();%>'; 
	return (APMode == '2') || (APMode == '3');
}

function IsSupportVoice()
{
	var IsSupportVoice = '<%HW_WEB_GetFeatureSupport(HW_VSPA_FEATURE_VOIP);%>';
	return parseInt(IsSupportVoice,10);
}

/* 设置div显示和影藏 */
function setDivShowHide(OptType,DivId)
{
	if(null == DivId)
	{
		return;
	}
	var Type = OptType == "hide" ? "none" : "block";
	try{
		document.getElementById(DivId).style.display=Type;
	}catch(e)
	{
		parent.document.getElementById(DivId).style.display=Type;
	}
}

function setHtmlValue(id, value)
{
	document.getElementById(id).innerHTML = value;
}

function RouterChangeSt(internet, internetnowifi, wifi, ont, usb, wifidev, linedev, teldev, wifima, changecode)
{
	this.internet 	= internet;
	this.internetnowifi 	= internetnowifi;
	this.wifi = wifi;
	this.ont = ont;
	this.usb 	= usb;
	this.wifidev = wifidev;
	this.linedev = linedev;
	this.teldev = teldev;
	this.wifima = wifima;
    this.changecode = changecode;
}

var gstClickFlag = new RouterChangeSt(0,0,0,0,0,0,0,0,0,0);
function CondetailInfo(clicktType,flag, divid, pointerid, iframeid, frameurl,clickfuncstr)
{
	this.clicktType = clicktType;
	this.flag = flag;
	this.divid = divid;
	this.pointerid = pointerid;
	this.iframeid = iframeid;
	this.frameurl = frameurl;
	this.clickfuncstr = clickfuncstr;
}

function SpecialDealFunc(flag)
{
	var positionvalue = flag == "hide" ? "-10px" : "0px";
	$("#Contectdevlineinfo").css("top", positionvalue);
	return;
}

function ShowCenterFunc(flag, id)
{
	if("hide" == flag)
	{
		return;
	}

	var newid="#"+id;
	$("#showcenter").attr("href", newid);
	document.getElementById("showcenter").click();
}

function shouldInitRouterClickDiv()
{
    if ((CfgMode.toUpperCase() == 'TEDATA2') || (CfgMode.toUpperCase() == 'TEDATA')) {
        return false;
    }
    return true;
}

function shouldInitRestartDiv()
{
    if ((CfgMode.toUpperCase() == 'TEDATA2') || (CfgMode.toUpperCase() == 'TEDATA')) {
        return false;
    }
    return true;
}

var gCondetailInfo = new Array( new CondetailInfo("internet",0,"internetstatusinfo",null,"InternetSrc", "../html/ssmp/smartontinfo/smatontinfo.asp"),
							    new CondetailInfo("internetnowifi",0,"nowifiinternetstatusinfo",null,"nowifiInternetSrc", "../html/ssmp/smartontinfo/smatontinfo.asp"),
								new CondetailInfo("wifi",0,"ConfigWifiInfo",null, "ConfigWifiPageSrc", "../../html/amp/wlanbasic/simplewificfg.asp"),
								new CondetailInfo("ont",0,"routermngt",null, "routermngtpageSrc", "../html/ssmp/accoutcfg/ontmngt.asp", SpecialDealFunc),
								new CondetailInfo("usb",0,"usbsamba",null, "usbsambapageSrc", "../html/ssmp/samba/sambasmart.asp", SpecialDealFunc),
								new CondetailInfo("wifidev",0,"Contectdevmngt","wifidevCntPointer", "ContectdevmngtPageSrc", "../html/bbsp/userdevinfo/userdevinfosmart.asp?type=wifidev"),
								new CondetailInfo("linedev",0,"Contectdevmngt","linedevCntPointer", "ContectdevmngtPageSrc", "../html/bbsp/userdevinfo/userdevinfosmart.asp?type=linedev"),
								new CondetailInfo("teldev",0,"Contectdevmngt","phonedevCntPointer", "ContectdevmngtPageSrc", "../../html/voip/status/smartvoipmaintain.asp"),
								new CondetailInfo("wifima",0,"D2CodeDivInfo",null, null, null),
								new CondetailInfo("changecode", 0, "routermngt",null, "routermngtpageSrc", "../html/ssmp/accoutcfg/totalplaywebcode.asp", SpecialDealFunc),
								null);

//ShowFlag为true则需要隐藏，ShowFlag为false则需要显示，并切换gCondetailInfo.flag状态
function ChangeClickConfigDiv(ShowFlag, PageIdType, PointerId)
{
	setDivShowHide("hide", "D2CodeDivInfo"); /*隐藏二维码区域*/

	for(var index = 0; index < gCondetailInfo.length - 1; index++)
	{
		//隐藏其他配置框
		var OptPageId = gCondetailInfo[index].divid;
		var Optpointerid = gCondetailInfo[index].pointerid;
		var clicktType = gCondetailInfo[index].clicktType;
		var clickfuncstr = gCondetailInfo[index].clickfuncstr;
		gstClickFlag[clicktType] = false;
		setDivShowHide("hide", OptPageId);
		setDivShowHide("hide", Optpointerid);
		if(undefined !=  clickfuncstr)
		{
			clickfuncstr("hide");
		}
	}

	$("#mainpage").css("height", "auto"); /*恢复页面高度*/

	//再显示，否则会出现闪烁的情况
	for(var index = 0; index < gCondetailInfo.length - 1; index++)
	{
		//ID匹配上,通过ShowFlag区分显示还是隐藏
		if(PageIdType == gCondetailInfo[index].clicktType)
		{
			//ShowFlag为true则需要隐藏，ShowFlag为false则需要显示，
			var ShowType = ShowFlag == true ? "hide" : "block";
			var clicktTypestr = gCondetailInfo[index].clicktType
			var ClickPageId = gCondetailInfo[index].divid;
			var Clickpointerid = gCondetailInfo[index].pointerid;
			var clickfuncstr = gCondetailInfo[index].clickfuncstr;
			gstClickFlag[clicktTypestr] = !ShowFlag;
			if(undefined != gCondetailInfo[index].iframeid
			   && undefined != gCondetailInfo[index].frameurl)
			{
				var iframeId = "iframe#" + gCondetailInfo[index].iframeid;
				if("block" == ShowType)
				{
					$(iframeId).attr("src", gCondetailInfo[index].frameurl);
				}
				else
				{
					$(iframeId).attr("src", "");
				}

			}

			setDivShowHide(ShowType, ClickPageId);
			setDivShowHide(ShowType, Clickpointerid);

			if(undefined !=  clickfuncstr)
			{
				clickfuncstr(ShowType);
			}

			if("Contectdevmngt" == ClickPageId)
			{
				ShowCenterFunc(ShowType, ClickPageId);
			}
			break;
		}
	}
}


var FrameMainPage = {
    /*  页面初始化方法 */
    init : function() {
        this.initData();
        this.initElement();
	    this.getRemoteData();
        this.menuItems = menuArray;
    },

    /* 初始化数据，包含MENU元素的索引、页面元素的引用。*/
    initData : function() {
    	var frame = this;
    },

    /* 获取远程数据，方式为AJAX同步调用 */
    getRemoteData : function() {
	  /* 添加其他数据的查询 */
    },


    /*  初始化页面元素 */
    initElement : function() {

		this.InitMainpageDesInfo();

		//初始化点击ONT的操作
		this.InitONTInfo();

		//初始化点击USB的操作
		if (isDnzvdf != 1) {
			this.InitUSBInfo();
		}
    },

	InitMainpageDesInfo:function(){
		var frame = this;
		if(true == IsSupportWifi() && true == IsSupportVoice())
		{
			//support wifi voip
			if (false ==IsWorkInAPBridged())
			{
				setDivShowHide("block", "WIFIIconInfo");
				this.initInitStatus();
			}
			else
			{
				setDivShowHide("hide", "WIFIIconInfo");
				this.initInitStatusNowifi();
			}
			setDivShowHide("block", "wifidevline");
			setDivShowHide("block", "wifidevCnt");


			//初始化点击WIFI连接设备
			this.InitWIFIDevInfo();

			//初始化点击LAN连接设备
			this.InitLineDevInfo();

			//init  connect voip device
			this.InitPhoneDevInfo();

			$("#WIFIIconInfo").mouseover(function() {
				$("#WIFIIcon").css("background", "url( ../images/wifiseticonmove.jpg) no-repeat center");
       		 });

			$("#WIFIIconInfo").mouseout(function() {
				$("#WIFIIcon").css("background", "url( ../images/wifiseticon.jpg) no-repeat center");
			});

		   $("#WIFIIconInfo").click(function() {
				frame.clickconfigwifi();
			});

			return;
		}
		else if(true == IsSupportWifi() && false == IsSupportVoice())
		{
			//support wifi , not support voip
			if (false ==IsWorkInAPBridged())
			{
				setDivShowHide("block", "WIFIIconInfo");
				this.initInitStatus();
			}
			else
			{
				setDivShowHide("hide", "WIFIIconInfo");
				this.initInitStatusNowifi();
			}
			setDivShowHide("block", "wifidevline");
			setDivShowHide("block", "wifidevCnt");

			

			//初始化点击WIFI连接设备
			this.InitWIFIDevInfo();

			//初始化点击LAN连接设备
			this.InitLineDevInfowithoutvoip();

			$("#WIFIIconInfo").mouseover(function() {
				$("#WIFIIcon").css("background", "url( ../images/wifiseticonmove.jpg) no-repeat center");
       		 });

			$("#WIFIIconInfo").mouseout(function() {
				$("#WIFIIcon").css("background", "url( ../images/wifiseticon.jpg) no-repeat center");
			});

		   $("#WIFIIconInfo").click(function() {
				frame.clickconfigwifi();
			});

		}
		else if(false == IsSupportWifi() && true == IsSupportVoice())
		{
			//support voip , not support wifi
			this.initInitStatusNowifi();

			//修改有线连接设备的位置
			frame.InitLineDevCntInfoWithoutWIFI();

			//init  connect voip device
			this.InitPhoneDevInfo();
			return;
		}
		else if(false == IsSupportWifi() && false == IsSupportVoice())
		{
			//not support voip and wifi
			this.initInitStatusNowifi();

            if (isMainpageCut != '1') {
                if (IsSupportBridgeWan == 0) {
                    //初始化点击LAN连接设备
                    $("#linedevline").css("margin-left", "350px");
                    $("#linedevCnt").css("margin-left", "335px");
                    $("#linedevCntSpan").css("margin-left", "300px");
                    this.InitLineDevInfo();
                }
            }
        }
    },

	//网络状态点击
	initInitStatus: function() {
    	var frame = this;
		setDivShowHide("block", "Internet");
		setDivShowHide("block", "InternetLineBottom");
        $("#InternetIcon").mouseover(function() {
			$("#InternetIcon").css("background", "url( ../images/interneticonmove.jpg) no-repeat center");
        });

        $("#InternetIcon").mouseout(function() {
			$("#InternetIcon").css("background", "url( ../images/interneticon.jpg) no-repeat center");
        });

	   $("#InternetIcon").click(function() {
			frame.clickInternet();
        });
    },

	initInitStatusNowifi:function() {
		var frame = this;
		setDivShowHide("none", "middiv");
		setDivShowHide("block", "NowifiInternet");
		$("#NowifiInternetIcon").mouseover(function() {
			$("#NowifiInternetIcon").css("background", "url( ../images/interneticonmove.jpg) no-repeat center");
        });

        $("#NowifiInternetIcon").mouseout(function() {
			$("#NowifiInternetIcon").css("background", "url( ../images/interneticon.jpg) no-repeat center");
        });

	   $("#NowifiInternetIcon").click(function() {
			frame.clickInternetnowifi();
        });
	},

	//互联网图标点击函数，显示网关信息
	clickInternet:function(){
		InternetWanDiagnose();
		ChangeClickConfigDiv(gstClickFlag.internet,"internet",null);
	},

	clickInternetnowifi:function(){
		InternetWanDiagnose();
		if ((CfgMode.toUpperCase() == 'TI') || (isMainpageCut != "1")) {
            ChangeClickConfigDiv(gstClickFlag.internetnowifi,"internetnowifi",null);
        }
	},

	InitLineDevCntInfoWithoutWIFI:function(){
		var frame = this;
		$("#wifidevline").css("background", "url( ../images/CntLeftLine.jpg) no-repeat center");
		$("#wifidevIcon").css("background", "url( ../images/linedev.jpg) no-repeat center");
		setDivShowHide("block", "wifidevline");
		setDivShowHide("block", "wifidevCnt");
		setDivShowHide("block", "wifidevCntSpan");

		//修改绑定事件
		$("#wifidevCnt").mouseover(function() {
			$("#wifidevIcon").css("background", "url( ../images/linedevmove.jpg) no-repeat center");
        });

        $("#wifidevCnt").mouseout(function() {
			$("#wifidevIcon").css("background", "url( ../images/linedev.jpg) no-repeat center");
        });

		var wifiIndex = 0;
		var LineIndex = 0;
		for(var index = 0; index < gCondetailInfo.length - 1; index++)
		{
			if("wifidev" == gCondetailInfo[index].clicktType)
			{
				wifiIndex = index;
			}

			if("linedev" == gCondetailInfo[index].clicktType)
			{
				LineIndex = index;
			}
		}

		gCondetailInfo[wifiIndex].frameurl = gCondetailInfo[LineIndex].frameurl;

		 $("#wifidevCnt").click(function() {
			frame.ClickWifiDevInfo();
        });
	},

    InitLineDevInfowithoutvoip:function(){
        var frame = this;

        if ((var_singtel == true) && (var_singtel_hg8244hs == false)) {
            setDivShowHide("hide", "phonedevline");
            setDivShowHide("hide", "linedevCnt");
            setDivShowHide("hide", "linedevCntSpan");
        } else {
            setDivShowHide("block", "phonedevline");
            setDivShowHide("block", "linedevCnt");
            setDivShowHide("block", "linedevCntSpan");
        }

        $("#linedevCnt").css("margin-left", "318px");
        $("#linedevCntSpan").css("margin-left", "220px");

        $("#linedevCnt").mouseover(function() {
            $("#linedevIcon").css("background", "url( ../images/linedevmove.jpg) no-repeat center");
        });

        $("#linedevCnt").mouseout(function() {
            $("#linedevIcon").css("background", "url( ../images/linedev.jpg) no-repeat center");
        });

        var TelIndex = 0;
        var LineIndex = 0;
        for(var index = 0; index < gCondetailInfo.length - 1; index++)
        {
            if("teldev" == gCondetailInfo[index].clicktType)
            {
                TelIndex = index;
            }

            if("linedev" == gCondetailInfo[index].clicktType)
            {
                LineIndex = index;
            }
        }

        gCondetailInfo[TelIndex].frameurl = gCondetailInfo[LineIndex].frameurl;
        $("#linedevCnt").click(function() {
            frame.ClickPhoneDevInfo();
        });
    },

	clickconfigwifi:function(){
		if(1 == gstClickFlag.wifi)
		{
			$("#WIFIIcon").css("background", "url( ../images/wifiseticon.jpg) no-repeat center");

		}
		else
		{
			$("#WIFIIcon").css("background", "url( ../images/wifiseticonmove.jpg) no-repeat center");
		}
		ChangeClickConfigDiv(gstClickFlag.wifi,"wifi",null);
	},

	clickShowwifima:function(){
		ChangeClickConfigDiv(gstClickFlag.wifima,"wifima",null);
	},

	//网络状态点击
	InitONTInfo: function() {
        var frame = this;
        if (shouldInitRouterClickDiv()) {
            $("#routerclick").mouseover(function() {
                $("#routericon").css("background", "url( ../images/routerpress.jpg) no-repeat center");
            });
    
            $("#routerclick").mouseout(function() {
                $("#routericon").css("background", "url( ../images/router.jpg) no-repeat center");
            });
    
           $("#routerclick").click(function() {
                frame.ClickONTInfo();
            });
        }

        if (shouldInitRestartDiv()) {
            $("#RestartDiv").mouseover(function() {
                $("#RestartIcon").css("background", "url( ../images/reseticonpress.jpg) no-repeat center");
            });
    
            $("#RestartDiv").mouseout(function() {
                $("#RestartIcon").css("background", "url( ../images/reseticon.jpg) no-repeat center");
            });
    
           $("#RestartDiv").click(function() {
                frame.ClickONTInfo();
            });
        } else {
            setDivShowHide("hide", "RestartDiv");
        }
    },

	ClickONTInfo:function(){
		if(1 == gstClickFlag.ont)
		{
			$("#routericon").css("background", "url( ../images/router.jpg) no-repeat center");

		}
		else
		{
			$("#routericon").css("background", "url( ../images/routerpress.jpg) no-repeat center");
		}

		if ((totalplay == '1') && (curUserType == '0')) {
			ChangeClickConfigDiv(gstClickFlag.changecode,"changecode",null);
		} else {
			ChangeClickConfigDiv(gstClickFlag.ont,"ont",null);
		}
	},

	InitUSBInfo:function(){
		var frame = this;
		if(IsSupportSamba())
		{	
			if (IGMPEnable == 0 && 1 == parseInt(var_singtel))
			{
				setDivShowHide("hide", "usbport");
			}
			else
			{
				setDivShowHide("block", "usbport");
			}
		}
		else
		{
			return;
		}

		 $("#usbport").mouseover(function() {
			$("#usbportIcon").css("background", "url( ../images/usbiconpress.jpg) no-repeat center");
        });

        $("#usbport").mouseout(function() {
			$("#usbportIcon").css("background", "url( ../images/usbicon.jpg) no-repeat center");
        });

		$("#usbport").click(function() {
			frame.ClickUsbInfo();
        });
	},

	ClickUsbInfo:function()
	{
		ChangeClickConfigDiv(gstClickFlag.usb,"usb",null);
	},

	//WIFIdev
	InitWIFIDevInfo:function(){
		var frame = this;
		$("#wifidevCnt").mouseover(function() {
			$("#wifidevIcon").css("background", "url( ../images/wifiiconmove.jpg) no-repeat center");
        });

        $("#wifidevCnt").mouseout(function() {
			$("#wifidevIcon").css("background", "url( ../images/wifiicon.jpg) no-repeat center");
        });

		 $("#wifidevCnt").click(function() {
			frame.ClickWifiDevInfo();
        });
	},

	ClickWifiDevInfo:function(){
		SetDeviceNum();
		ChangeClickConfigDiv(gstClickFlag.wifidev,"wifidev",null);
	},

	//LineDev
	InitLineDevInfo:function(){
		var frame = this;

		if ((true == var_singtel) && (false == var_singtel_hg8244hs))
		{
			setDivShowHide("hide", "linedevline");
			setDivShowHide("hide", "linedevCnt");
			setDivShowHide("hide", "linedevCntSpan");
		}
		else
		{
			setDivShowHide("block", "linedevline");
			setDivShowHide("block", "linedevCnt");
			setDivShowHide("block", "linedevCntSpan");
		}
		$("#linedevCnt").mouseover(function() {
			$("#linedevIcon").css("background", "url( ../images/linedevmove.jpg) no-repeat center");
        });

        $("#linedevCnt").mouseout(function() {
			$("#linedevIcon").css("background", "url( ../images/linedev.jpg) no-repeat center");
        });

		$("#linedevCnt").click(function() {
			frame.ClickLineDevInfo();
        });
	},

	ClickLineDevInfo:function(){
		SetDeviceNum();
		ChangeClickConfigDiv(gstClickFlag.linedev,"linedev",null);
	},

	//PhoneDev
	InitPhoneDevInfo:function(){
		var frame = this;
		if ((true == var_singtel) && (false == var_singtel_hg8244hs))
		{
			setDivShowHide("hide", "phonedevline");
			setDivShowHide("hide", "phonedevCnt");
			setDivShowHide("hide", "phonedevCntSpan");
		}
		else
		{
			setDivShowHide("block", "phonedevline");
			setDivShowHide("block", "phonedevCnt");
			setDivShowHide("block", "phonedevCntSpan");
		}
		$("#phonedevCnt").mouseover(function() {
			$("#phonedevIcon").css("background", "url( ../images/phoneiconmove.jpg) no-repeat center");
        });

        $("#phonedevCnt").mouseout(function() {
			$("#phonedevIcon").css("background", "url( ../images/phoneicon.jpg) no-repeat center");
        });

		$("#phonedevCnt").click(function() {
			frame.ClickPhoneDevInfo();
        });
	},

	ClickPhoneDevInfo:function(){
		SetDeviceNum();
		ChangeClickConfigDiv(gstClickFlag.teldev,"teldev",null);
	},

	showmainpage : function() {
        var frame = this;
        $(document).ready(function() {
            frame.init();
        });
    }
};

FrameMainPage.showmainpage();
