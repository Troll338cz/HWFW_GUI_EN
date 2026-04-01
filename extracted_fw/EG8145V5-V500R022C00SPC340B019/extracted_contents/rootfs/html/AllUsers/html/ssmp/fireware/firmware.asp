<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>
<script language="JavaScript" type="text/javascript">
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var curWebFrame = '<%HW_WEB_GetWEBFramePath();%>';
var CfgModeWord ='<%HW_WEB_GetCfgMode();%>';
var isSupportV5 = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FT_V5_CMS_SUPPORT);%>';
var reqFile = "html/ssmp/fireware/firmware.asp";
var ProductType = '<%HW_WEB_GetProductType();%>';
var isSupportHoup = '<%HW_WEB_GetFeatureSupport(FT_HOUP_UPGRADE);%>';
var houpEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_Houp.Enable);%>';
var turkcellState = {upgradeStatus:0};
var ttNet = '<%HW_WEB_GetFeatureSupport(FT_CFG_TTNET2);%>';

if (CfgModeWord.toUpperCase() == "TURKCELL2") {
    reqFile = "remote/supgrade.html";
}
var HoupUpgradeInfo;
function GetHoupUpGrade() {
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "./GetUpgradeStatus.asp",
        success : function(data) {
            if (data != "") {
				HoupUpgradeInfo = dealDataWithFun(data);
            }
        }
    });
}

function SetUpgrade() {
	$.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "./SetUpgradeStatus.asp",
        success : function(data) {
			if (data == 1){
				showHoupStatus();
			}
        }
    });
}

function GetShowHoupUpGrade() {
    $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "./GetUpgradeStatus.asp",
        success : function(data) {
            if (data != "") {
				HoupUpgradeInfo = dealDataWithFun(data);
				showHoupStatus();
            }
        }
    });
}

function showHoupStatus() {
    if (HoupUpgradeInfo.status == 0) {
		$("#ProgressText").html(FirmwareLgeDes["s1137"]);
		setDisable("checkProgress", 0);
    } else if (HoupUpgradeInfo.status == 1) {
		$("#ProgressText").html(FirmwareLgeDes["s1138"]);
		setDisable("checkProgress", 0);
    } else if (HoupUpgradeInfo.status == 2){
		$("#ProgressText").html(FirmwareLgeDes["s1132"] + HoupUpgradeInfo.Progress + "%");
		setDisable("checkProgress", 1);
    } else if (HoupUpgradeInfo.status == 3) {
		$("#ProgressText").html(FirmwareLgeDes["s1136"]);
		$("#resetBut").show();
		$("#checkProgress").hide();
		setDisable("checkProgress", 0);
    } else if (HoupUpgradeInfo.status == 4) {
		$("#ProgressText").html(FirmwareLgeDes["s1139"]);
		setDisable("checkProgress", 0);
	} else if (HoupUpgradeInfo.status == 5) {
		$("#ProgressText").html("");
		setDisable("checkProgress", 0);
	} else if (HoupUpgradeInfo.status == 6) {
		$("#ProgressText").html(FirmwareLgeDes["s1152"]);

		setDisable("checkProgress", 1);
	} else if (HoupUpgradeInfo.status == 7) {
		$("#ProgressText").html(FirmwareLgeDes["s1143"]);
		setDisable("checkProgress", 1);
	}
}

function onReboot() {
    if (ConfirmEx(FirmwareLgeDes['s1140'])) {
        setDisplay("rebootButtonDiv", 0);
        setDisplay("alertExblackBackground", 1);
        $.ajax({
            type : "POST",
            async : true,
            cache : false,
            data : "&x.X_HW_Token=" + getValue('onttoken'),
            url : 'set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.SMP.DM.ResetBoard',
            success : function(data) {
            }
        });
    } else {
        turkcellState.upgradeStatus = 0;
	}
}
function setAllDisable()
{
	setDisable('f_file',    1);
	setDisable('browse',    1);
	setDisable('btnBrowse', 1);
	setDisable('btnSubmit', 1);
}

function GetLanguageDesc(Name)
{
	return FirmwareLgeDes[Name];
}

var AutoUpdateEnable = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_AutoUpdate.Enable);%>';
function Check_SWM_Status()
{
	var xmlHttp = null;

	if(window.XMLHttpRequest) {
		xmlHttp = new XMLHttpRequest();
	} else if(window.ActiveXObject) {
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}

	xmlHttp.open("GET", "/html/get_swm_status.asp", false);
	xmlHttp.send(null);

	var swm_status = xmlHttp.responseText;
	if (swm_status.substr(1, 1) == "0") {
		return true;
	} else {
		return false;
	}
}

function LoadFrame()
{
	top.UpgradeFlag = 0;

	if("IPONLY" == CfgModeWord.toUpperCase() || "FORANET" == CfgModeWord.toUpperCase() || "TELIA" == CfgModeWord.toUpperCase())
	{
		setDisplay("tableautoupgrade", 1);
		setDisplay("localtext", 1);
		setCheck("autoupgrade", AutoUpdateEnable);
	}
	if ((isSupportHoup == "1")) {
		GetHoupUpGrade()
		$("#HoupGrade").show();
		if (HoupUpgradeInfo.status == "2") {
			top.houpGradeFlag = setInterval("GetShowHoupUpGrade();", 2000);
		}
	}

	Object.defineProperty(turkcellState, "upgradeStatus", {
		set: function(satus) {
			if (satus == 1) {
				setDisplay("rebootButtonDiv", 1);
				if (ttNet == "1") {
					setDisplay("restartONT", 0);
				}
			}
		}
	});

	if (CfgModeWord.toUpperCase() == "ELISAAP") {
		$("#rebootButton").removeClass("ApplyButtoncss buttonwidth_150px").addClass("ApplyButtoncss buttonwidth_180px");
	}

	if (CfgModeWord.toUpperCase() == "DINFOTEK2") {
        document.getElementById("rebootButton").style.width = "140px";
    }
}

function VerifyFile(FileName)
{
	var File = document.getElementsByName(FileName)[0].value;
	if (File.length == 0)
	{
		AlertEx(GetLanguageDesc("s0901"));
		return false;
	}
	if (File.length > 128)
	{
		AlertEx(GetLanguageDesc("s0902"));
		return false;
	}

	return true;
}

function uploadImage()
{
	var uploadForm = document.getElementById("fr_uploadImage");

	if (Check_SWM_Status() == false)
	{
		AlertEx(GetLanguageDesc("s0905"));
		return;
	}

	if (VerifyFile('browse') == false)
	{
	   return;
	}
	
	setDisable('btnSubmit', 1);
	ajaxSubmitForm();
	setDisplay('informblackBackground', 1);
	setDisplay("errorText", 0)
	top.UpgradeFlag = 1;
	setDisable('browse', 1);
	setDisable('btnBrowse',1);
}

function ajaxSubmitForm() {
    var formData = new FormData($("#fr_uploadImage")[0]);
    var result = null;
    var uploadPart = 0.7;
	var percent = 0;
    top.ajaxInfo = $.ajax({
        url : "Firmwareupload.cgi?RequestFile=/html/ssmp/fireware/firmware_vdf.asp&FileType=image",
        type : "POST",
        data : formData,
        cache : false,
        contentType : false,
        processData : false,
        xhr:xhrOnProgress(function(data) {
			percent = data.loaded / data.total;
            if (percent > uploadPart) {
                percent = (percent - uploadPart) / (1 - uploadPart);
				setDisplay("informblackBackground", 0);
				setDisplay("errorText", 0)
				setDisplay("progressblackBackground", 1);
				var widthTemp = $('#progress-bar-box').width();
    			widthTemp = parseInt(widthTemp * percent);
    			$('#progress-bar-image').width(widthTemp);
            }
        }),
        success: function (data) {
            result = hexDecode(data);
            GetAjaxRet(result);
		}
	});

}
var xhrOnProgress = function(fun) {
    xhrOnProgress.onprogress = fun;

    return function() {
        var xhr = $.ajaxSettings.xhr();
        if (typeof xhrOnProgress.onprogress !== 'function') {
            return xhr;
        }

        if (xhrOnProgress.onprogress && xhr.upload) {
            xhr.upload.onprogress = xhrOnProgress.onprogress;
        }

        return xhr;
    }
}

function GetAjaxRet(result) {
	top.UpgradeFlag = 0;
	var retData = result.toLowerCase();
	var ret = JSON.parse(retData);
    if (ret.result == 0) {
        setDisplay("progressblackBackground", 0);
        turkcellState.upgradeStatus = 1;
    } else {
		setDisplay("progressblackBackground", 0);
		setDisplay("errorText", 1)
        setDisable('browse', 0);
        setDisable('btnBrowse',0);
		setDisable('btnSubmit', 0);
		$("#t_file").val("");
    	$("#f_file").val("");
    }
}


</script>
<script language="JavaScript" type="text/javascript">
function fchange()
{
	var ffile = document.getElementById("f_file");

	var tfile = document.getElementById("t_file");
	ffile.value = tfile.value;

	var buttonstart = document.getElementById('btnSubmit');
	buttonstart.focus();
	return ;
}

function StartFileOpt()
{
	XmlHttpSendAspFlieWithoutResponse("/html/ssmp/common/StartFileLoad.asp");
}

function ApplayAutoUpgrade()
{
	var Form = new webSubmitForm();
	Form.addParameter('x.Enable',getCheckVal('autoupgrade'));
	Form.addParameter('x.X_HW_Token', getValue('onttoken'));
	Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_AutoUpdate'
                         + '&RequestFile=' + reqFile);
	Form.submit();
}
    function isTEData() {
        if (isSupportV5 == 1) {
            return (CfgModeWord == 'TEDATA') || (CfgModeWord == 'TEDATA2');
        } else {
            return false;
        }
    }
    function ResetONT() {
        if (isTEData() == false) {
            return;
        }
        var Title = ResetLgeDes["s0601"];
        if (ConfirmEx(Title)) {
            setDisable('btnReboot', 1);
            var Form = new webSubmitForm();
            Form.setAction('set.cgi?x=InternetGatewayDevice.X_HW_DEBUG.SMP.DM.ResetBoard'
                + '&RequestFile=html/ssmp/fireware/firmware.asp');
            Form.addParameter('x.X_HW_Token', getValue('onttoken'));
            Form.submit();
        }
    }
    function RestoreONT() {
        if (isTEData() == false) {
            return;
        }
        var Title = RestoreLgeDes["s0a01"];

        if (ConfirmEx(Title)) {
            var Form = new webSubmitForm();
            setDisable('btnRestoreDftCfg', 1);
            Form.setAction('restoredefaultcfg.cgi?RequestFile=html/ssmp/fireware/firmware.asp');
            Form.addParameter('x.X_HW_Token', getValue('onttoken'));
            Form.submit();
        }
	}
	
	function checkProgressFun() {
		setDisable("checkProgress", 1);
		$("#ProgressText").html("");
		clearInterval(top.houpGradeFlag);
		top.houpGradeFlag = setInterval("GetShowHoupUpGrade();", 3000);
		if (HoupUpgradeInfo.status != 2 || HoupUpgradeInfo.status != 6) {
			SetUpgrade();
		}
	}
</script>
</head>

<body  class="mainbody pageBg" onLoad="LoadFrame();">
	<script language="JavaScript" type="text/javascript">
        if (isTEData()) {
            HWCreatePageHeadInfo("TEDataFirmwareTitle", GetDescFormArrayById(FirmwareLgeDes, "s0915"),
                GetDescFormArrayById(FirmwareLgeDes, "s0916"), false);
            document.write('<br/><br/>');
            HWCreatePageHeadInfo("RebootTitle", GetDescFormArrayById(FirmwareLgeDes, "s0917"), '', false);
        }
    </script>
    <div id="OntReset" style="display:none;">
        <div id="ResetIcon" class="OntResetIcon"></div>
        <div id="ResetButton" class="FloatLeftCss">
            <input type="button" class="bluebuttoncss buttonwidth_120px_140px" id="btnReboot" onClick="ResetONT(this);"
                value="" BindText="s1123" />
        </div>
        <div id="ResetDes">
            <table height="40px;">
                <tr>
                    <td class="ResetRestoreSpan" BindText="s1125"></td>
                </tr>
            </table>
        </div>
    </div>
    <script>
        if (isTEData()) {
            setDisplay("OntReset", 1);
            document.write('<br/><br/>');
            HWCreatePageHeadInfo("firmware", GetDescFormArrayById(FirmwareLgeDes, "s0918"), '', false);
        }
    </script>
    <div id="OntRestore" style="display:none;">
        <div id="RestoreIcon" class="OntRestoreIcon">
        </div>
        <div id="RestoreButton" class="FloatLeftCss">
            <input type="button" class="bluebuttoncss buttonwidth_140px_300px" id="btnRestoreDftCfg"
                onClick="RestoreONT(this);" value="" BindText="s1127" />
        </div>
        <div id="RestoreTips" style="width:420px;">
            <table height="40px;">
                <tr>
                    <td class="ResetRestoreSpan" BindText="s1126"></td>
                </tr>
            </table>
        </div>
    </div>

    <script language="JavaScript" type="text/javascript">
        if (isTEData()) {
            setDisplay("OntRestore", 1);
            document.write('<br/><br/>');
        }
	if("IPONLY" == CfgModeWord.toUpperCase() || "FORANET" == CfgModeWord.toUpperCase() || "TELIA" == CfgModeWord.toUpperCase()) 
	{																			<!-- s0900:	  "Software Upgrade" -->
		HWCreatePageHeadInfo("firmware", GetDescFormArrayById(FirmwareLgeDes, "s0900"), GetDescFormArrayById(FirmwareLgeDes, "s0906a"), false);
	}
	else{
		HWCreatePageHeadInfo("firmware", GetDescFormArrayById(FirmwareLgeDes, "s0900"), GetDescFormArrayById(FirmwareLgeDes, "s0906"), false);
	}

	</script>
	<table id="tableautoupgrade" style="display:none;" width="100%">
	<tr>
	<td colspan="2" BindText=""></td>
	</tr>
	<tr>
	<td id="autotext" colspan="2" class="func_title" BindText="s090a"></td>
	</tr>
	<tr>
	<td class="width_per15" BindText="s090c"></td>
	<td class="width_per85" align="left"><input id="autoupgrade" name="autoupgrade" type="checkbox" onclick="ApplayAutoUpgrade();"></td>
	</tr>
	</table>
	<div class="title_spread"></div>
	<form action="Firmwareupload.cgi?RequestFile=/html/ssmp/reset/reset.asp&FileType=image" method="post" enctype="multipart/form-data" name="fr_uploadImage" id="fr_uploadImage">
		<table>
		<tr>
		<td  id="localtext" colspan="3" class="func_title" BindText="s090b" style="display:none;"></td>
		</tr>
			<tr>
				<td class="filetitle" BindText="s0907"></td>
				<td>
					<div class="filewrap">
						<div class="fileupload">
							<input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>" />
							<input type="text" id="f_file" autocomplete="off" readonly="readonly" />
							<input type="file" name="browse" id="t_file" size="1"  onblur="StartFileOpt();" onchange="fchange();" />
							<input type="button" id="btnBrowse" class="CancleButtonCss filebuttonwidth_100px" BindText="s0908" />
							<script>
								if (CfgModeWord.toUpperCase() == "DINFOTEK2") {
									document.getElementById("btnBrowse").style.backgroundColor = "#0cb433";
								}
							</script>
						</div>
					</div>
				</td>
				<td>
                    <script>
                        if (CfgModeWord == "DICELANDVDF") {
                            document.write('<input class="ApplyButtoncss filebuttonwidth_100px" name="btnSubmit" id="btnSubmit" type="button" onclick="uploadImage();"  BindText="s0909" />')
                        } else {
                            document.write('<input class="CancleButtonCss filebuttonwidth_100px" name="btnSubmit" id="btnSubmit" type="button" onclick="uploadImage();"  BindText="s0909" />')
                        }
                    </script>
				</td>
			</tr>
		</table>
	</form>
	<div class="blackBackground" id="informblackBackground" style="margin-top: 20px;display: none;">
		<div id="informFrom" class="alertpopup" >
			<div style="display: flex;align-items: center;height: 40px;"><span id="informtitle" BindText="s1144"></span><img style="margin-left: 10px;" src="../../../images/icon-thinking.gif"></div>
			<div class="alerttext"><span id="informspan" BindText="s1145"></span></div>
		</div>
	</div>
	<div class="blackBackground" id="progressblackBackground" style="display: none;">
		<div id="progressFrom" class="alertpopup" >
			<p class="title"><span id="progresstitle" BindText="s1146"></span></p>
			<div class="alerttext"><span id="progressspan" BindText="s1147"></span></div>
			<div id="progress-bar-box"><div id="progress-bar-image"></div></div>
		</div>
	</div>
    <div class="blackBackground" id="rebootButtonDiv" style="display: none;">
        <p class="title"><span id="alertExtitle" BindText="s1148"></span></p>
        <button id="rebootButton" style="margin-top:10px;" type="button" onclick="onReboot();" class="ApplyButtoncss buttonwidth_150px">
            <script>document.write(PrompterDes['s1010']);</script>
        </button>
	</div>
	<div class="blackBackground" id="alertExblackBackground" style="display: none;">
		<div id="alertExFrom" class="alertpopup">
			<p class="title"><span id="alertExtitle" BindText="s1148"></span></p>
			<div class="alerttext"><span id="alertExspan" BindText="s1149"></span></div>
		</div>
	</div>
	<div class="blackBackground" id="errorText" style="display: none;">
		<div id="alertExFrom" class="alertpopup">
			<p class="title"><span id="alertExtitle" BindText="s1150"></span></p>
			<div class="alerttext"><span id="alertExspan" BindText="s1151"></span></div>
		</div>
	</div>
	<div id = "HoupGrade" style="margin-top: 60px;display: none;">
		<div class="PageTitle_title" BindText = "s1133"></div>
		<div class="PageTitle_content" BindText="s1141"></div>
		<div style="margin-top: 10px;color: #666;">
			<input style="height: 30px;width: 120px;" class="CancleButtonCss" name="checkProgress" id="checkProgress" type='button' onclick='checkProgressFun();'  BindText="s1135" />
			<input style="height: 30px;width: 70px;display: none;" class="CancleButtonCss" name="resetBut" id="resetBut" type='button' onclick='onReboot();'  BindText="s1142" />
			<div style="margin: 10px 0 0 6px;" id="ProgressText"></div>
		</div>
	</div>
	<br/>
	<br/>
	<script>
		if (isSupportHoup == '1') {
			HWCreatePageHeadInfo("houpupgrade", FirmwareLgeDes["s1155"], "", false);
		}
	</script>
	<div id="chekHoupDiv" style="display: none;margin-top: 15px;">
		<div style="position: relative;float: left;">
			<input id="chekHoup" type="checkbox" onchange="submithHoupValue()">
		</div>
        <span style="font-size: 14px;" class="PageTitle_content" BindText="s1153">
            <script>
                if (isSupportHoup == '1') {
					$("#houpupgrade_content")[0].style.display = "none";
                    $("#chekHoupDiv")[0].style.display = "block";
                    $("#chekHoup")[0].checked = (houpEnable == '1');
                }
                function submithHoupValue() {
                    var data = "x.Enable=" + (($("#chekHoup")[0].checked == true) ? "1" : "0");
                    var houpUrl = "x=InternetGatewayDevice.X_HW_Houp";
                    var Result = null;
                    $.ajax({
                        type : "POST",
                        async : true,
                        cache : false,
                        url : 'set.cgi?' + houpUrl + "&RequestFile=html/ssmp/fireware/firmware.asp",
                        data: data + '&x.X_HW_Token='+ getValue('onttoken'),
                        success : function(data) {
                            Result = data;
                            location.reload();
                        }
                    });
				}
            </script>
        </span>
        <br/>
        <br/>
    </div>
	<script>
		ParseBindTextByTagName(FirmwareLgeDes, "div",    1);
		ParseBindTextByTagName(FirmwareLgeDes, "td",     1);
		ParseBindTextByTagName(FirmwareLgeDes, "span",  1);
		ParseBindTextByTagName(FirmwareLgeDes, "input",  2);
	</script>


</body>
</html>
