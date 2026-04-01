<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1">
<script language="JavaScript" type="text/javascript">
	document.write('<title>中国移动</title>');
 </script>	
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
</head>
<script language="JavaScript" src="/../resource/common/<%HW_WEB_CleanCache_Resource(md5.js);%>"></script>
<script language="JavaScript" src="/../resource/common/<%HW_WEB_CleanCache_Resource(RndSecurityFormat.js);%>"></script>
<script language="JavaScript" src="/../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="/resource/common/<%HW_WEB_CleanCache_Resource(safelogin.js);%>"></script>

<style type="text/css">
.register-input {
	
}

.guangdong {width:430px;font-size: 14px; }
.qita {width:400px;}

.register-input tr{width:100%;}

.guangdong .register-input-title {
	width:170px;
	
}


.guangdong .register-input-content {
	width: 260px;
}

.qita .register-input-title {
	width:130px;
}
.qita .register-input-content {
	width:270px;
}

.register-input-title { text-align:right;}
.register-input-content .input { width:150px; margin-left:2em;}

.input_time {border:0px; }
 
#ChooseAreaModule .header { font-weight:bold;line-height:18px;margin:0px;padding:0px;margin-bottom:5px;text-align:center;}
 
.submit_area{
	font: 12px Arial, ËÎÌå;
	color:#0000FF;
    height: 25px;
	width:60px;
	margin-left: 2px;
	margin-bottom:4px;
	
	background-color:#E1E1E1;
	display:inline-block;
}

.disabled { color: gray;}

.goback { 
	display:inline-block;
	padding-left:4px;
	margin:0px;
	height: 25px;
	color: red;
}


.content { width:653px;height:323px;position:absolute;}
.content .prompt { position:absolute; top:0px;left:0px;width:96%;height:40px;;border:0px; }
.content .module { position:absolute; top: 55px;left: 110px;width:430px; }

#SelectedArea {color: Red;font-weight: bold; }

.progress { position:relative;left:10px; background-color:white; width:380px; height:20px;  }
.progress .progressbar { position:absolute; top:1px; left:1px; width:0%; height:18px; background-color:orange;  }
.progress .progress-text { position:absolute;top:1px;left:1px; width:378px;height:16px;color:Black;text-align:center;font-size:12px; }
</style>
<script type="text/javascript">
	
function stResultInfo(domain, Result, Status)
{
	this.domain = domain;
	this.Result = Result;
	this.Status = Status;
}            
     
function AreaRelationInfo(ChineseDes, E8CArea)
{
	this.ChineseDes = ChineseDes;
	this.E8CArea = E8CArea;
}

var AreaRelationInfos = new Array();

var userEthInfos = new Array(new AreaRelationInfo("重庆","023"),
							 new AreaRelationInfo("四川","028"),
							 new AreaRelationInfo("云南","0871"),
							 new AreaRelationInfo("贵州","0851"),			 
							 new AreaRelationInfo("北京","010"),
							 new AreaRelationInfo("上海","021"),
							 new AreaRelationInfo("天津","022"),	 
							 new AreaRelationInfo("安徽","0551"),
							 new AreaRelationInfo("福建","0591"),
							 new AreaRelationInfo("甘肃","0931"),
							 new AreaRelationInfo("广东","020"),
							 new AreaRelationInfo("广西","0771"),			 
							 new AreaRelationInfo("海南","0898"),
							 new AreaRelationInfo("河北","0311"),
							 new AreaRelationInfo("河南","0371"),
							 new AreaRelationInfo("湖北","027"),
							 new AreaRelationInfo("湖南","0731"),
							 new AreaRelationInfo("吉林","0431"),
							 new AreaRelationInfo("江苏","025"),
							 new AreaRelationInfo("江西","0791"),
							 new AreaRelationInfo("辽宁","024"),
							 new AreaRelationInfo("宁夏","0951"),
							 new AreaRelationInfo("青海","0971"),
							 new AreaRelationInfo("山东","0531"),
							 new AreaRelationInfo("山西","0351"),
							 new AreaRelationInfo("陕西","029"),	 
							 new AreaRelationInfo("西藏","0891"),
							 new AreaRelationInfo("新疆","0991"),				 
							 new AreaRelationInfo("浙江","0571"),
							 new AreaRelationInfo("黑龙江","0451"),
							 new AreaRelationInfo("内蒙古","0471"),
							 null);


function GetE8CAreaByName(userEthInfos,name)
{
	var length = userEthInfos.length;
	
	for( var i = 0; i <  length - 1; i++)
	{
	    if(name == userEthInfos[i].ChineseDes)
		{
			return userEthInfos[i].E8CArea;
		}
	}
	
	return null;
}

function GetE8CAreaByCfgFtWord(userEthInfos,name)
{
	var length = userEthInfos.length;
	
	for( var i = 0; i <  length - 1; i++)
	{
	    if(name == userEthInfos[i].E8CArea)
		{
			return userEthInfos[i].ChineseDes;
		}
	}
	
	return null;
}

var stResultInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UserInfo, Result|Status, stResultInfo);%>;
var Infos = stResultInfos[0];

var ontPonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.AccessMode);%>';

var CfgFtWordArea = '<%GetConfigAreaInfo();%>';

var ProvinceArray = '<%GetChoiceProvinceInfo();%>';

var IsMaintWan = '<%HW_WEB_IfMainWanLink();%>';
var br0Ip = '<%HW_WEB_GetBr0IPString();%>';
var httpport = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_WebServerConfig.ListenInnerPort);%>';
var CfgFtWord = '<%HW_WEB_GetCfgMode();%>';

var CurBinMode = '<%HW_WEB_GetBinMode();%>';
var g_checkkey="";

if (IsMaintWan == 1)
{
	if (window.location.href.indexOf('loidreg.asp') == -1)
	{
		window.location = window.location.substr(0, window.location.href.lastIndexOf('/')) + '/loidreg.asp';
	}
}
else
{
	if (window.location.href.indexOf(br0Ip) == -1)
	{
		window.location = 'http://' + br0Ip +':'+ httpport +'/loidreg.asp';
	}
}

if ((parseInt(Infos.Result) == 1) && (0 == parseInt(Infos.Status)))
{
	window.location="/loidgregsuccess.asp";	
}

if ('CMCC' != CurBinMode.toUpperCase())	
{
	window.location="/login.asp";
}

function Submit(type)
{
    if (CheckForm(type) == true) {
        var Form = new webSubmitForm();
        AddSubmitParam(Form,type);
        Form.submit();
    }
}

function stDevInfo(domain,loid, eponpwd)
{
	this.domain = domain;
	this.loid       = loid;
    this.eponpwd = eponpwd;
}

function stOperateInfo(domain,Result,Status)
{
	this.domain = domain;
    this.Result = Result;
    this.Status = Status;
}

var stDevInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.DeviceInfo, X_HW_Loid|X_HW_EponPwd, stDevInfo);%>;

var stOperateInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_UserInfo, Result|Status, stOperateInfo);%>;

var stDevinfo = stDevInfos[0];

var stOperateInfo = stOperateInfos[0];

function CheckForm()
{
    var loid = getValue('LOIDValue');
    var eponpwd = getValue('PwdValue');
    var inLen = 0;
	
	if ((null == loid) || ('' == loid))
	{
		alert("LOID不能为空，请输入正确的LOID。");
		return false;
	}
	
	if (!isValidAscii(loid))
	{
		alert("LOID包含非ASCII字符，请输入正确的LOID。");
		return false;
	}
	
	if (loid.length > 24)
	{
		alert("LOID不能超过24个字符。");
		return false;
	}
	
	inLen =  loid.length;
	if( inLen != 0)
	{
    	if ( ( loid.charAt(0) == ' ' ) || (loid.charAt(inLen -1) == ' ') )
    	{
        	if(false == confirm('您输入的LOID开始或结尾有空格，是否确认？'))
        	{			
        		return false;
        	}
    	}
	}	
	
	if ((null != eponpwd) && ('' != eponpwd))
	{
		if (!isValidAscii(eponpwd))
		{
			alert("PASSWORD包含非ASCII字符，请输入正确的PASSWORD。");
			return false;
		}
		
		if (eponpwd.length > 12)
		{
			alert("PASSWORD不能超过12个字符。");
			return false;
		}
		
   	    inLen =  eponpwd.length;
    	if( inLen != 0)
    	{
        	if ( ( eponpwd.charAt(0) == ' ' ) || (eponpwd.charAt(inLen -1) == ' ') )
        	{
            	if(false == confirm('您输入的Password开始或结尾有空格，是否确认？'))
            	{			
            		return false;
            	}
        	}
    	}		
	}
	
	return true;
}

function SetCookie(name, value)
{
    var expires = (SetCookie.arguments.length > 2 ? SetCookie.arguments[2] : null);
    var domain = (SetCookie.arguments.length > 4 ? SetCookie.arguments[4] : null);
    var secure = (SetCookie.arguments.length > 5 ? SetCookie.arguments[5] : false);

    var expiresStr = "";
    if (expires != null) {
        var expdate = new Date();
        expdate.setDate(expdate.getTime() + (expires * 1000));
        expiresStr = "expires=" + expdate.toGMTString() + ";";
    }
    document.cookie = name + "=" + escape (value) + ";" + expiresStr + "path=/;"
                      + (domain == null ? "" : "domain=" + domain + ";")
                      + (secure == true ? "secure" : "");
}

function IsIEBrower(num) {
    var ua = navigator.userAgent.toLowerCase();
    var isIE = ua.indexOf("msie")>-1;
    var safariVersion;
    if(isIE){
        safariVersion =  ua.match(/msie ([\d.]+)/)[1];
        var sa = parseInt(safariVersion);
        if(safariVersion <= num ){
           alert("您当前使用的IE浏览器版本过低（不支持IE6/7/8），必须升级到IE9及以上版本，以便正常访问WEB页面。");
        }
    }
}

function LoadFrame()
{ 

	if ('GDCU' == CfgFtWord.toUpperCase())
	{
		setDisable('PwdValue',1);
	}

}

function AddSubmitParam1()
{
    if ((parseInt(Infos.Status) == 0) && (parseInt(Infos.Result) == 1))
	{
		window.location="/loidgregsuccess.asp";
		return;	
	}
	
	if (CheckForm() == true)
	{
		var PrevTime = new Date();
		SetCookie("lStartTime",PrevTime);
		SetCookie("StepStatus","0");
		SetCookie("CheckOnline","0");
		SetCookie("lastPercent","0");
		SetCookie("GdTR069WanStatus","0");
		SetCookie("GdDispStatus","0");
		SetCookie("GdTR096WanIp","0");
		
		var SubmitForm = new webSubmitForm();
		
		SubmitForm.addParameter('x.UserName', getValue('LOIDValue'));
		SubmitForm.addParameter('x.UserId', getValue('PwdValue'));
        SubmitForm.addParameter('x.X_HW_Token', getAuthToken());
		SubmitForm.setAction('loid.cgi?' +'x=InternetGatewayDevice.X_HW_UserInfo&RequestFile=loidresult.asp');
		setDisable('btnApply',1);
		setDisable('resetValue',1);
		SubmitForm.submit();
	}
}

function AddSubmitParam2()
{
	setText('LOIDValue','');
	setText('PwdValue','');
}

function CheckPwdCancel()
{
  window.location.reload(true);
}

</script>
<body onLoad="LoadFrame();"> 
<form> 
<div align="center"> 
<table cellSpacing="0" cellPadding="0" width="653" align="center" border="0"> 
<TBODY > 

<TR> 
<TD><table width="653" height="323" border="0" align="center" cellpadding="0" cellspacing="0" font style="font-size:16px;"> 
<TBODY> 
<TR> 

<script language="javascript">		
		 document.write('<TD  align="center" width="653" height="323" background="/images/register_cmccinfo.jpg">');
		
</script>


<div  id="ChooseAreaModule" class="module" align="left" style="font-size:14px; display:none; width:420px; height:220px;padding-top:75px">
<p class="header"><font style="font-size: 14px;">请选择所在地区:</font></p>
<input type="button"  class="submit_area" name="010" id="010" value="北京" />
<input type="button"  class="submit_area" name="021" id="021" value="上海" />
<input type="button"  class="submit_area" name="022" id="022" value="天津" />
<input type="button"  class="submit_area" name="023" id="023" value="重庆" />
<input type="button"  class="submit_area" name="0551" id="0551" value="安徽" />
<input type="button"  class="submit_area" name="0591" id="0591" value="福建" />
<input type="button"  class="submit_area" name="0971" id="0971" value="甘肃" />
<input type="button"  class="submit_area" name="020" id="020" value="广东" />
<input type="button"  class="submit_area" name="0771" id="0771" value="广西" />
<input type="button"  class="submit_area" name="0851" id="0851" value="贵州" />
<input type="button"  class="submit_area" name="0898" id="0898" value="海南" />
<input type="button"  class="submit_area" name="0311" id="0311" value="河北" />
<input type="button"  class="submit_area" name="0371" id="0371" value="河南" />
<input type="button"  class="submit_area" name="027" id="027" value="湖北" />
<input type="button"  class="submit_area" name="0731" id="0731" value="湖南" />
<input type="button"  class="submit_area" name="0431" id="0431" value="吉林" />
<input type="button"  class="submit_area" name="025" id="025" value="江苏" />
<input type="button"  class="submit_area" name="0791" id="0791" value="江西" />
<input type="button"  class="submit_area" name="024" id="024" value="辽宁" />
<input type="button"  class="submit_area" name="0951" id="0951" value="宁夏" />
<input type="button"  class="submit_area" name="0971" id="0971" value="青海" />
<input type="button"  class="submit_area" name="0531" id="0531" value="山东" />
<input type="button"  class="submit_area" name="0351" id="0351" value="山西" />
<input type="button"  class="submit_area" name="029" id="029" value="陕西" />
<input type="button"  class="submit_area" name="028" id="028" value="四川" />
<input type="button"  class="submit_area" name="0891" id="0891" value="西藏" />
<input type="button"  class="submit_area" name="0991" id="0991" value="新疆" />
<input type="button"  class="submit_area" name="0871" id="0871" value="云南" />
<input type="button"  class="submit_area" name="0571" id="0571" value="浙江" />
<input type="button"  class="submit_area" name="0451" id="0451" value="黑龙江" />
<input type="button"  class="submit_area" name="0471" id="0471" value="内蒙古" />
</div>

<div id="ApplyAreaModule" class="module" style="display:none;padding-top:70px">

<div class="progress">
<div class="progressbar">
<div class="progress-text">0%</div>
</div>
</div>
<p id="RedirectText" style="text-align:center; height:200px"></p>

<script type="text/javascript">
$('#ApplyAreaModule').children('table')
.addClass('register-input')
</script>
</div>

<div id="CheckPwdModule" class="module" style="display:none;">
<br />
<br />
<br />
<br />
<p  align="center"> <font style='font-size: 15px;'>验证密码：</font><input type="password" autocomplete="off" class="input" name="CheckPwdValue" id="CheckPwdValue" style="font-size: 13px;" size="15" maxlength="127"/><strong style="color:#FF0033">*</strong></p>
<font id="CheckPwdPrompt" style="margin-left:20px;display:none;font-size: 14px;" size="2">提示：输入的验证密码不正确，请找支撑经理从CMS平台获取。</font>                      
<p style="text-align:center;">
<br>
<input style="font-size: 13px;" name="btnCheckPwdApply" class="submitApply" id="btnCheckPwdApply"  type="button" value="&nbsp;确&nbsp;认&nbsp;">
<input style="margin-left:20px;font-size: 13px;"　name="btnCheckPwdCancel" class="submitCancel" id="btnCheckPwdCancel" onClick="CheckPwdCancel();" type="button" value="&nbsp;取&nbsp;消&nbsp;">
</p>
 
 <script language="javascript">
document.write('<p style="text-align:center;"> <font style="font-size: 14px;">中国移动客服热线10086号</font></p>');
</script> 
</div>  

<div id="RegisterModule" class="module" style="display:none;padding-top:50px">
<TABLE cellSpacing="0" cellPadding="0" width="400" border="0" height="80%">
 <tr id="showChooseArea">
    <br />
	<br />
    <td colspan="2" style="text-align:center;font-size: 16px;">
        当前配置地区为<span id="SelectedArea"></span>，更改请<a href="#" class="showChooseAreaModule" >点击&gt;&gt;</a>
    </td>
</tr>

<tr id="tr_pon_type" style="display:none;">
  <td colspan="2" height="18" align="left" id="pon_type"></td>
</tr>

<tr>
  <td colspan="2" align="center" id="ont_sn_des" style="padding-left:30px;"></td>
</tr>
<tr >
  <td colspan="2" align="center" id="otherinfo_des" style="padding-left:30px;"></td>
</tr>
<tr style="height:25px;">
  <td class="register-input-title" id="ont_loid_value"></td>
  <td class="register-input-content" ><input name="LOIDValue" class="input" id="LOIDValue" type="text" size="15" style="font-size: 13px;" maxlength="63"><strong style="color:#FF0033;font-size: 16px;">*</strong></td>
</tr>

<tr style="height:25px;">
  <td class="register-input-title" id="passpwd_value"></td>
  <td class="register-input-content"><input type="text" class="input" name="PwdValue" id="PwdValue" size="15" style="font-size: 13px;" maxlength="63"/></td>
</tr>
<script language="javascript">
document.getElementById('tr_pon_type').style.display="";
document.write('<TR>');
if (ontPonMode == 'gpon' || ontPonMode == 'GPON')
{
	document.getElementById('pon_type').innerHTML = "<p size='2' style='text-align:center;color:#FF0033;font-size: 18px;'><strong>GPON上行终端</strong></p>";        
}
else
{
	document.getElementById('pon_type').innerHTML = "<p size='2' style='text-align:center;color:#FF0033;font-size: 18px;'><strong>EPON上行终端</strong></p>";   
}
document.write('</TR>');
if ('GDCU' == CfgFtWord.toUpperCase())
{
	document.getElementById('otherinfo_des').innerHTML = "<font style='font-size: 14px;'>提示：终端该密码为空，不能填写。</font>";
}
	document.getElementById('ont_sn_des').innerHTML = "<font style='font-size: 16px;'>请您输入申请业务时所提供的LOID和Password：</font>";
document.getElementById('ont_loid_value').innerHTML = "<font style='font-size: 16px;'>LOID：</font>";
document.getElementById('passpwd_value').innerHTML = "<font style='font-size: 16px;'>Password：</font>";
					
</script> 

<script language="javascript">
	document.write('<TR>');
	document.write('<TD align="middle" colSpan="2" height="35" font style="font-size: 14px;"> <input name="btnApply" class="submit" id="setReg" style="font-size: 13px;" onClick="AddSubmitParam1()" type="button" value="&nbsp;提&nbsp;交&nbsp;">');
	document.write('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
	document.write('<input name="resetValue" id="resetValue" type="button" class="submit"  onClick="AddSubmitParam2();" style="font-size: 13px;" value="&nbsp;重&nbsp;置&nbsp;"> </TD>');	
	document.write('</TR>');
</script>
 
<script language="javascript">	
document.write('<TD align="center" colSpan="2" width="100%" height="20"><font style="font-size: 14px;">中国移动客服热线10086号</font></TD>');	
</script>
</TR> 
<TR> <TD align="left" colSpan="2" height="40"></TD> </TR> 
</TABLE> 
</div>
</TR> </TBODY> </TABLE> </TD> </TR> 
</TBODY> 
</TABLE> 
</div> 

<div align="center" style="margin-top:-320px">
<table class="prompt">
<TR>
<TD width="12%"></TD>
<TD align="right" width="15%">
<br />
<script language="javascript">
document.write('<A href="http://' + br0Ip +':'+ httpport +'/login.asp"><FONT style="font-size: 14px;" color="#000000">返回登录页面</FONT></A>');
</script>
</TD> </TR> </TABLE> </div>
</form> 
<script type="text/javascript">
    $(document).ready(function () {
        var viewModel = {
            selectedArea: null,
            $ChooseAreaModule: $('#ChooseAreaModule'),
            $ApplyAreaModule: $('#ApplyAreaModule'),
            $CheckPwdModule: $('#CheckPwdModule'),
            $RegisterModule: $('#RegisterModule')
        };
         
        viewModel.$ChooseAreaModule.delegate(':button', 'click', function () {
            var area = this.value;
			if(this.disabled) return false;
            viewModel.$ApplyAreaModule.trigger('start', area);

        }).bind({
            start: function (event, backable) {


                viewModel.$ApplyAreaModule.hide();
                viewModel.$RegisterModule.hide();

                viewModel.$ChooseAreaModule.show();
                var gobackBtn = viewModel.$ChooseAreaModule.find('.goback');
                if (backable === "noback") {
                    gobackBtn.remove();

                } else {
                    if (!gobackBtn.length) {
                        viewModel.$ChooseAreaModule.append('<a class="goback" href="#" style="font-size: 14px;">返回&gt;&gt;</a>');
                    }
                }
				var enabledBtns = ProvinceArray;

				$('.submit_area').filter('[type="button"]').each(function(index) {
					var element = this;
					var name = element.name;
					if(enabledBtns.indexOf) {
						if(enabledBtns.indexOf(name) == -1) {
							$(this).attr('disabled', 'disabled').addClass('disabled');						
						}
					} else {
						var included = false;
						$.each(enabledBtns,function(index, item){
							if(item == name)
							{	
								included = true;
								return false;
							}
						});
						
						if(!included) {
							$(element).attr('disabled', 'disabled').addClass('disabled');
						}
					}
					
				});
				
            }	
        }).delegate('a.goback', 'click', function (event) {
            event.preventDefault();
            event.stopPropagation();

            viewModel.$RegisterModule.trigger('start');
        });
        viewModel.$ApplyAreaModule.bind({
            start: function (event, area) {
                var e8cArea;

                if (!area) {
                    alert("您未选择任何区域!");
                    return;
                }
                
				if ((parseInt(Infos.Status) == 0) && (parseInt(Infos.Result) == 1))
				{
					alert("已注册成功，请恢复出厂后重新选择所在地区！");
					return;
				}

                e8cArea = GetE8CAreaByName(userEthInfos, area);
                if (confirm("您当前选择的地区为" + area + "，是否确认?")) {

                    viewModel.$ChooseAreaModule.hide();
                    viewModel.$RegisterModule.hide();

                    viewModel.$ApplyAreaModule.show();
                    $.post('ConfigE8cArea.cgi?&RequestFile=loidreg.asp', { "AreaInfo": e8cArea,"CheckKey":g_checkkey, 'x.X_HW_Token': getAuthToken()});
					g_checkkey="";
                    
                    window.CfgFtWordArea = e8cArea;
                    viewModel.$ApplyAreaModule.trigger('beginProgress');
				
                }
            },
            beginProgress: function () {
                var completeSeconds = 10;
                var startSeconds = 0;
                var startTime = new Date();
                var endTime = new Date();
				
				viewModel.$ApplyAreaModule.find('#RedirectText').text("请稍候，正在配置，请勿断电...");
				viewModel.$ApplyAreaModule.trigger('setProgress', parseInt((startSeconds / completeSeconds) * 100));
                var interval = setInterval(function () {

                    if (startSeconds != completeSeconds) {
                        var configstatus = '';
                        
                        $.ajax({
													type : "POST",
													async : true,
													cache : false,
													url : "/asp/GetConfigStatusInfo.asp",
													success : function(data) {
													configstatus = data;
													},
													error: function() {
         										configstatus = '';
         								},
         								
         								complete: function()
         								{
         									  if(configstatus == '')
		                        {   		
		                        		if(parseInt((endTime.getTime()-startTime.getTime())/1000) > 40)
			                    			{
			                    				viewModel.$ApplyAreaModule.find('#RedirectText').text("设备网络连接可能已断开，请检查你的网络连接状态。");
			                    			}
		                        }
		                        else if(configstatus == "DONE")
		                    		{
		                    			  viewModel.$ApplyAreaModule.find('#RedirectText').text("请稍候，正在配置，请勿断电...");
		                    				startSeconds = completeSeconds;
		                    		}
		                      	else if(parseInt((startSeconds / completeSeconds) * 100) >90)
		                    		{
		                    			viewModel.$ApplyAreaModule.find('#RedirectText').text("请稍候，正在配置，请勿断电...");  			
		                    			viewModel.$ApplyAreaModule.trigger('setProgress', 100);
		                    			startSeconds = completeSeconds;  			
		                    		}
		                    		else if(configstatus == "DOING")
		                  			{
		                  					viewModel.$ApplyAreaModule.trigger('setProgress', parseInt((startSeconds / completeSeconds) * 100));
		                    		    startSeconds += 1;
		                  			}
		                  			
		                  			endTime = new Date();
         								}
         								
         								
													});
													
                       
                  			
                    } else {

                        viewModel.$ApplyAreaModule.trigger('setProgress', 100);
                        viewModel.$ApplyAreaModule.trigger('endProgress');
                        clearInterval(interval);
                    };

                }, 1000);
            },
            setProgress: function (event, percent) {
                viewModel.$ApplyAreaModule.find('.progressbar').css('width', percent + '%');
                viewModel.$ApplyAreaModule.find('.progress-text').text(percent + '%');
            },
            endProgress: function () {

                redirectSeconds = 1;

                var tempInterval = setInterval(function () {

                    if (redirectSeconds !== 0) {
                        redirectSeconds -= 1;
                    } else {
						clearInterval(tempInterval);
                        window.location.reload(true);
                    }
                }, 1000);

            }
        });

        viewModel.$CheckPwdModule.bind({
            start: function () {
            	
            viewModel.$ChooseAreaModule.hide();
						viewModel.$ApplyAreaModule.hide();
						viewModel.$RegisterModule.hide();
						viewModel.$CheckPwdModule.show();
            }
          
        }).delegate('.submitApply', 'click', function (event) {

            var CheckPassword = document.getElementById("CheckPwdValue").value;
            if(CheckPassword == '')
            {
            	 alert("输入的密码不能为空！");
            	return false;
            }
           
			var CheckInfo = FormatUrlEncode(CheckPassword);
            var CheckResult =0;
			g_checkkey=CheckPassword;
     
            $.ajax({
            type : "POST",
            async : false,
            cache : false,
            url : '/asp/CheckModifyInfo.asp?&1=1',
            data :'CheckInfo='+CheckInfo,
            success : function(data) {
                CheckResult = data;
            }
        });
						        
            
            if(1 == CheckResult) 
            {
            	viewModel.$CheckPwdModule.hide();
              viewModel.$ChooseAreaModule.trigger('start');
            }
            else
          	{
          		
          		document.getElementById('CheckPwdPrompt').style.display="";
          		viewModel.$CheckPwdModule.show();
          	}
            
           
        });  

        viewModel.$RegisterModule.bind({
            start: function () {
                viewModel.$ChooseAreaModule.hide();
                viewModel.$ApplyAreaModule.hide();

                viewModel.$RegisterModule.show();
                viewModel.$RegisterModule.find('#SelectedArea').text(GetE8CAreaByCfgFtWord(userEthInfos, CfgFtWordArea));
            }
        }).delegate('.showChooseAreaModule', 'click', function (event) {
        

            event.preventDefault();
            event.stopPropagation();

       
            if(CfgFtWordArea.toUpperCase() != 'NOCHOOSE' && CfgFtWordArea.toUpperCase() != 'CHOOSE' )
            {
            	setText('CheckPwdValue','');
            	viewModel.$CheckPwdModule.trigger('start');
            }
            else
          	{
          		viewModel.$ChooseAreaModule.trigger('start');
          	}
        });

       
         if(CfgFtWordArea.toUpperCase() != 'NOCHOOSE' && CfgFtWordArea.toUpperCase() != 'CHOOSE' ) {
            viewModel.$RegisterModule.trigger('start');
            
            
        }
        else if(CfgFtWordArea.toUpperCase() == 'NOCHOOSE')
      	{
      		  viewModel.$RegisterModule.trigger('start');
      		  document.getElementById('showChooseArea').style.display="none";
      	}
        else {
            viewModel.$ChooseAreaModule.trigger('start', 'noback');
        }
        		
		
    });
</script> 
</body>
</html>
