<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(InitForm.asp);%>"></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(InitFormCus.js);%>'></script>
<script language="JavaScript" src='../../../Cusjs/<%HW_WEB_GetCusSource(ptvdfjs.js);%>'></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(voicedes.html, vdfringsch);%>"></script>
<title></title>
<style>
h1 {
    font-weight: 400;
}
.clearfix {
    *zoom: 1;
}
#content-reset-wrap {
    float: left;
    margin-left: 50px;
    width: 710px;
    min-height: 700px;
}
#content-wrap {
    margin: 0 auto;
    width: 950px;
    color: #333333;
    padding-top: 30px;
}
#content-wrap {
    margin: 0 auto;
    width: 950px;
    color: #333333;
    padding-top: 30px;
}
#look_4 {
    background-color: #fff;
}

html {
    overflow-y: scroll;
}
#content {
    padding-bottom: 60px;
    position: relative;
    -webkit-transition: all 0.3s ease-out;
    -moz-transition: all 0.3s ease-out;
    -o-transition: all 0.3s ease-out;
    transition: all 0.3s ease-out;
}
/* @media only screen and (min-width:768px) */
#resetWrapMobile {
    display: none;
}
.resetButtons {
    height: 30px;
    width: 30px;
    right: 0px;
    position: absolute;
    background-image: url("../../../images/button-reload.png");
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
    cursor: pointer;
    z-index: 99;
}
.op40 {
    opacity: 0.4;
    pointer-events: none;
}
:focus {
    outline: 0 dotted #c0c;
}
input.button-add {
    background-image: url("../../../images/button-add-desktop.png");
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
    width: 30px;
    height: 30px;
    padding: 0;
    box-shadow: none;
    -moz-box-shadow: none;
    -webkit-box-shadow: none;
}
input.button-delete, input.button-delete-message, input.button-delete-pairing {
    background-image: url("../../../images/button-delete-desktop.png");
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
    width: 30px;
    height: 30px;
    padding: 0;
    box-shadow: none;
    -moz-box-shadow: none;
    -webkit-box-shadow: none;
}
input.button-edit {
    background-image: url("../../../images/button-edit-desktop.png");
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
    width: 30px;
    height: 30px;
    padding: 0;
    box-shadow: none;
    -moz-box-shadow: none;
    -webkit-box-shadow: none;
}
input.button.button-apply {
    background-color: #b141ad;
    color: #fff;
}

.title {
    color: #e60000;
    font-family: "VodafoneRgRegular";
    font-size: 28px;
    line-height: 50px;
}

div.table {
    display: table;
    width: 100%;
    line-height: 24px;
}
.message-error {
    background: url("../../../images/error.png") no-repeat scroll 20px 18px #fef0f0;
    border: 1px solid #e60000;
    border-radius: 3px;
    margin-top: 20px;
    margin-bottom: 20px;
    padding: 22px 80px 20px 70px;
}
.popup .apply-cancel {
    text-align: right;
    margin-top: 20px;
}
.no-text-align {
    text-align: inherit !important;
}
.space-right {
    padding-right: 80px;
}
.row > div {
    padding-top: 12px;
    padding-bottom: 12px;
}
:not(.no-border).h3-content .row + .row > div, .h3-wrapper-content .row + .row > div {
    border-top: solid 1px #e6e6e6;
}
#content-wrap .row .left {
    display: table-cell;
}
#content-wrap .row .right {
    display: table-cell;
    text-align: right;
}
/* @media only screen and (min-width:768px) */
.mobile-wrap-from-to {
    display: none;
}
/* @media only screen and (min-width:768px) */
.mobile-table {
    display: none;
}
/* @media only screen and (min-width:768px) */
.content-ringing-schedule#content .mobile {
    display: none !important;
}
.chosen-container * {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
input[type='text'], input[type='password'] {
    border-radius: 4px;
    box-shadow: inset 0px 1px 2px 0px #767676;
    -moz-box-shadow: 0 1px 2px 0 #767676 inset;
    -webkit-box-shadow: 0 1px 2px 0 #767676 inset;
    color: #767676;
    font-size: 16px;
    line-height: 24px;
    padding: 7px 14px;
    box-sizing: border-box;
}
.chosen-container a {
    cursor: pointer;
}
.chosen-container-single .chosen-single {
    position: relative;
    display: block;
    overflow: hidden;
    text-decoration: none;
    white-space: nowrap;
}
.chosen-container-single .chosen-default {
    color: #999;
}
 .chosen-container-single .chosen-single {
    width: 230px !important;
}
.chosen-container .chosen-drop {
    position: absolute;
    top: 100%;
    left: -9999px;
    z-index: 1010;
    width: 100%;
    border: 1px solid #aaa;
    border-top: 0;
    background: #fff;
    box-shadow: 0px 4px 5px rgba(0,0,0,0.15);
}
.chosen-container-single .chosen-drop {
    margin-top: -1px;
    border-radius: 0 0 4px 4px;
    background-clip: padding-box;
}
.chosen-container-single .chosen-search {
    position: relative;
    z-index: 1010;
    margin: 0;
    padding: 3px 4px;
    white-space: nowrap;
}
.chosen-container-single.chosen-container-single-nosearch .chosen-search {
    position: absolute;
    left: -9999px;
}
.chosen-container .chosen-results {
    color: #444;
    position: relative;
    overflow-x: hidden;
    overflow-y: auto;
    margin: 0 4px 4px 0;
    padding: 0 0 0 4px;
    max-height: 240px;
    -webkit-overflow-scrolling: touch;
}
 .chosen-container .chosen-results {
    padding: 0;
    border: 0;
    margin: 0;
}
.chosen-container-single .chosen-search input[type=text] {
    margin: 1px 0;
    padding: 4px 20px 4px 5px;
    width: 100%;
    height: auto;
    outline: 0;
    border: 1px solid #aaa;
    font-size: 1em;
    font-family: sans-serif;
    line-height: normal;
    border-radius: 0;
}
.chosen-container-single .chosen-single span {
    display: block;
    overflow: hidden;
    margin-right: 26px;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.chosen-container-single .chosen-single div b {
    display: block;
    width: 100%;
    height: 100%;
}
.chosen-container-single .chosen-single div {
    position: absolute;
    top: 3px;
    right: 0;
    display: block;
    width: 34px;
    height: 33px;
    border-left: solid 1px #ccc;
    text-align: left;
}
.chosen-container-single.chosen-with-drop .chosen-single div b {
    background: url(../../../images/arrow-up.png) no-repeat scroll center center transparent !important;
}
#content .chosen-container-single.chosen-with-drop .chosen-single div b {
    background: url(../../../images/arrow-up.png) no-repeat scroll center center transparent !important;
}
.chosen-container-single .chosen-single div b {
    background: url(../../../images/arrow-down.png) no-repeat scroll center center transparent !important;
}
.chosen-container-single .chosen-single {
    background: none repeat scroll 0 0 rgba(0, 0, 0, 0);
    border-radius: 3px;
    color: #333;
    font-size: 14px;
    height: 39px;
    line-height: 39px;
    padding: 0 14px;
    box-shadow: 0px 1px 3px rgba(0, 0, 0, .55);
    -moz-box-shadow: 0px 1px 3px rgba(0, 0, 0, .55);
    -webkit-box-shadow: 0px 1px 3px rgba(0, 0, 0, .55);
    border: 0;
    font-size: 16px;
    width: 290px;
    text-align: left;
}

[type='checkbox']:not(:checked), [type='checkbox']:checked {
    left: -9999px;
    position: absolute;
}
[type='checkbox']:not(:checked) + label, [type='checkbox']:checked + label {
    cursor: pointer;
    font-weight: normal;
    line-height: 20px;
    margin-bottom: 15px;
    padding-left: 25px;
    position: relative;
    z-index: 2;
}

.h3-content.no-padding-bottom {
    padding-bottom: 0px;
}
.shadowProblem {
    padding-right: 10px !important;
    margin-right: -10px;
}
.level-3 {
    padding: 0 0 0 14px;
}
.h3-content > table {
    width: 100%;
}
.italic {
    font-style: italic;
}
.tC {
    text-align: center !important;
}
#look_4 .content-ipv6 .h3-content td, .h3-content th {
    padding-left: 8px;
}
.h3-content td, .h3-content th {
    font-weight: normal;
    height: 30px;
    line-height: 30px;
    padding: 10px;
    text-align: left;
}
.h3-content th {
    border-bottom: 1px solid #e6e6e6;
}
.h3-content table.table-three-columns th {
    width: 33%;
}
#schedule-table thead th {
    font-weight: bold;
}
div.button {
    background-color: #808080;
    border-radius: 30px;
    height: 30px;
    position: relative;
    -webkit-transition: all 0.3s ease-out;
    -moz-transition: all 0.3s ease-out;
    -o-transition: all 0.3s ease-out;
    transition: all 0.3s ease-out;
    width: 60px;
    z-index: 1;
    display: inline-block;
}
div.button::after {
    background-color: #fff;
    border-radius: 14px;
    box-shadow: 0 4px 3px rgba(0, 0, 0, 0.2);
    -moz-box-shadow: 0 4px 3px rgba(0, 0, 0, 0.2);
    -webkit-box-shadow: 0 4px 3px rgba(0, 0, 0, 0.2);
    content: " ";
    display: block;
    height: 28px;
    left: 1px;
    position: absolute;
    top: 1px;
    -webkit-transition: all 0.2s ease-in-out;
    -moz-transition: all 0.2s ease-in-out;
    -o-transition: all 0.2s ease-in-out;
    transition: all 0.2s ease-in-out;
    width: 28px;
    z-index: 2;
}
div.button.button-on {
    background-color: #a8b400;
}
div.button.button-on::after {
    left: 31px;
}
#resetBar {
    text-align: left;
}
#r {
    height: 70px;
    line-height: 34px;
}
#resetT {
    padding-right: 10px;
}
#cancelR {
    float: right;
}
#resetR {
    float: right;
    margin-right: 5px;
}
.image-style {
    border: 0px;
    width: 30px;
    height: 30px
}

.chosen-container.chosen-with-drop .chosen-drop {
    left: 0px;
}
.chosen-container .chosen-results li {
    display: none;
    margin: 0;
    padding: 5px 6px;
    list-style: none;
    line-height: 15px;
    word-wrap: break-word;
    -webkit-touch-callout: none;
}
.chosen-container .chosen-results li.active-result {
    display: list-item;
    cursor: pointer;
}
.chosen-container .chosen-results li.highlighted {
    background-color: #3875d7;
    background-image: -webkit-gradient(linear, 50% 0, 50% 100%, color-stop(20%, rgb(56, 117, 215)), color-stop(90%, rgb(42, 98, 188)));
    background-image: -webkit-linear-gradient(rgb(56, 117, 215) 20%, rgb(42, 98, 188) 90%);
    background-image: -moz-linear-gradient(#3875d7 20%,#2a62bc 90%);
    background-image: -o-linear-gradient(#3875d7 20%,#2a62bc 90%);
    background-image: linear-gradient(rgb(56, 117, 215) 20%, rgb(42, 98, 188) 90%);
    color: #fff;
}
.chosen-container .chosen-results li {
    line-height: 39px;
    height: 39px;
    padding: 0 14px;
    font-size: 16px;
    text-align: left;
}
.chosen-container .chosen-results li.highlighted {
    background: #666;
    box-shadow: inset 0px 1px 3px rgba(0,0,0,0.55);
    -moz-box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.55) inset;
    -webkit-box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.55) inset;
    color: #fff;
}
.chosen-container-single .chosen-drop {
    border-radius: 3px;
    border: 0;
    box-shadow: 0px -3px 0px rgba(255, 255, 255, 1), 0px 1px 3px rgba(0, 0, 0, .55);
    -moz-box-shadow: 0px -3px 0px rgba(255, 255, 255, 1), 0px 1px 3px rgba(0, 0, 0, .55);
    -webkit-box-shadow: 0px -3px 0px rgba(255, 255, 255, 1), 0px 1px 3px rgba(0, 0, 0, .55);
}
.chosen-container {
    position: relative;
    display: inline-block;
    vertical-align: middle;
    font-size: 13px;
    zoom: 1;
    *display: inline;
    -webkit-user-select: none;
    -moz-user-select: none;
    user-select: none;
}
:focus {
    outline: 0 dotted #c0c;
}
.popup {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%,-50%);
}
input[type="time" i] {
    border-radius: 3px;
    -webkit-box-shadow: 0px 1px 3px rgba(0, 0, 0, .55);
    border: 0;
    padding: 2px;
}
</style>
<script language="JavaScript" type="text/javascript">
function stRingSchedule(Domain, Enable, Policy)
{
    this.Domain = Domain;
    this.Enable = Enable;
    this.Policy = Policy;
}
function stSchedule(Domain, Numbers, Days, TimeFrom, TimeTo)
{
    this.Domain = Domain;
    this.Numbers = Numbers;
    this.Days = Days;
    this.TimeFrom = TimeFrom;
    this.TimeTo = TimeTo;
    this.InstanceID = Domain.split('.')[8];
}
var schedules = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_RingSchedule.Schedules.{i},Numbers|Days|TimeFrom|TimeTo,stSchedule);%>;
var scheduleStatus = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_RingSchedule,Enable|Policy,stRingSchedule);%>;
var initFlag;
function stLine(Domain, DirectoryNumber, PhyReferenceList)
{
    this.Domain = Domain;
    if(DirectoryNumber != null) {
        this.DirectoryNumber = DirectoryNumber.toString().replace(/&apos;/g,"\'").split('@')[0];
    } else {
        this.DirectoryNumber = DirectoryNumber;
    }
    if (this.DirectoryNumber.length > 15) {
        this.DirectoryNumber = this.DirectoryNumber.substring(0, 12) + '...';
    }
    this.InstId = Domain.split('.')[7];
    this.Port = PhyReferenceList;
}

function stAuth(Domain, AuthUserName, URI)
{
    this.Domain = Domain;
    if(AuthUserName != null) {
        this.AuthUserName = AuthUserName.toString().replace(/&apos;/g,"\'").split('@')[0];
    } else {
        this.AuthUserName = AuthUserName;
    }
    if(URI != null) {
        this.URI = URI.toString().replace(/&apos;/g,"\'").split('@')[0];
    } else {
        this.URI = URI;
    }
    if (this.AuthUserName.length > 15) {
        this.AuthUserName = this.AuthUserName.substring(0, 12) + '...';
    }
    if (this.URI.length > 15) {
        this.URI = this.URI.substring(0, 12) + '...';
    }
    this.LineId = Domain.split('.')[7];
}
var numbers;
var allNumbers;
var curPolicy;

$(document).ready(function(){
    $('div').click(function() {
        if ($(this).closest('.chosen-single').length == 0)
            $(".chosen-with-drop").toggleClass('chosen-with-drop');
    });
    $('#hide-all').click(function(){
        $(this).toggleClass('button-on');
        var tmp = $('.hide-all');
        $('.hide-all').slideToggle(1000);
        SubmitScheduleEnable($(this).hasClass('button-on'));
    });
    $('a.chosen-single').click(function(){
        if (!$(this).parent().hasClass('chosen-with-drop')) {
            $(this).parent().toggleClass('chosen-with-drop');
            $(this).next().find('.result-selected').first().addClass('highlighted');
            return false;
        }
    });
    $('li.active-result').click(function(){
        if ($(this).hasClass('result-selected')) {
            return;
        }
        var selected = $(this).parent().find('.result-selected');
        if (selected.length > 0) {
            selected.first().toggleClass('result-selected');
            selected.first().removeClass('highlighted');
        }
        $(this).toggleClass('highlighted');
        $(this).toggleClass('result-selected');
        var input = $(this).closest('.chosen-container').find('span');
        var html = $(this).text();
        input.text(html);
        if ($(this).closest('.content-ringing-schedule').length > 0) {
            $('.schedule-on').toggle();
            $('.schedule-off').toggle();
            if (html == vdfringsch['vspa_ptvdf_rs_policy_enable']) {
                curPolicy = 1;
            } else {
                curPolicy = 0;
            }
        } else if ($(this).closest('.popup').length > 0) {
            var individualDays = $('#individualDays');
            if ($(this).html() == vdfringsch['vspa_ptvdf_rs_individ']) {
                individualDays.toggle();
                var days;
                if (scheduleIndex == -1) {
                    days = '0000000';
                } else {
                    days = schedules[scheduleIndex].Days;
                }
                for (var i=1; i<=7; i++) {
                    $('#ch' + i).attr("checked", days[i-1] == '1' ? true : false);
                }
            } else {
                if (individualDays.is(':visible')) {
                    individualDays.toggle();
                }
            }
        }
    });
    $('.button-edit').click(function(){
        var id = $(this).attr('id').split('_')[1];
        ShowEditPop(id);
    });
    $('.button-delete').click(function(){
        if ($(this).closest('.popup').length > 0) {
            $(this).closest('.assign-row22').first().toggle();
            $('#addNumber').removeClass('op40');
        } else {
            var idx = $(this).attr('id').split('_')[1];
            SubmitDelSchedule(idx);
        }
    });
    $('.button-add').click(function(){
        if ($(this).attr('id') == 'addSchedule') {
            ShowEditPop(-1);
        } else if ($(this).attr('id') == 'addNumber') {
            var visibleNum = 0;
            var isDone = false;
            for (var i=1; i<=8; i++) {
                var item = $('#number' + i);
                if (item.is(':hidden')) {
                    if (!isDone) {
                        item.attr('style', 'display: block');
                        InitNumberSelect(item, 0);
                        isDone = true;
                    }
                } else {
                    visibleNum++;
                }
            }
            if (visibleNum == 7) {
                $(this).toggleClass('op40')
            }
        }
    });
    $('.button-apply').click(function(){
        if ($(this).attr('id') == 'edit-apply') {
            if (SubmitEditSchedule()) {
                $('#edit-popup').toggle();
                window.parent.getElementById("indexblackBackground").style.display = "none";
            }
        } else if ($(this).attr('id') == 'applyButton'){
            SubmitSchedulePolicy(true);
        }
    });
    $('.button-cancel').click(function(){
        if ($(this).attr('id') == 'edit-cancel') {
            $('#edit-popup').toggle();
            window.parent.getElementById("indexblackBackground").style.display = "none";
        } else {
            if (initFlag == true) {
                SubmitSchedulePolicy(false);;
            }
        }
    });

    var switchIcon = document.getElementById("hide-all");
    var policySelect = $("#policy-select");
    var hide = document.getElementById("hide-content");
    if (scheduleStatus[0] == null) {
        initFlag = false;
        scheduleStatus[0] = new stRingSchedule(0, 0, 0);
    } else {
        initFlag = true;
    }
    if (scheduleStatus[0].Enable == 1) {
        switchIcon.setAttribute("class", "button button-on");
        hide.style.display = "block";
    } else {
        switchIcon.setAttribute("class", "button");
        hide.style.display = "none";
    }
    curPolicy = scheduleStatus[0].Policy;
    var selectHtml = scheduleStatus[0].Policy == 1 ? vdfringsch['vspa_ptvdf_rs_policy_enable'] : vdfringsch['vspa_ptvdf_rs_policy_disable'];
    policySelect.parent().find('.active-result').each(function() {
        var html = $(this).html();
        if ($(this).html() == selectHtml) {
            $(this).addClass('result-selected');
            $(this).closest('.chosen-container').find('span').text(selectHtml);
             return false;
        }
    });
    if (scheduleStatus[0].Policy == 1) {
        $('.schedule-on').toggle();
    } else {
        $('.schedule-off').toggle();
    }
    if (schedules.length == 41) {
        $('#addSchedule').toggleClass('op40');
    }
}); 

function InitPolicySelect()
{
    var html = '<ul class="chosen-results"><li class="active-result" data-option-array-index="0">';
    html += vdfringsch['vspa_ptvdf_rs_policy_enable'];
    html += '</li><li class="active-result" data-option-array-index="1">';
    html += vdfringsch['vspa_ptvdf_rs_policy_disable'];
    html += '</li></ul>';
    return html;
}

function InitSchedulsTable()
{
    if (schedules.length <= 1) {
        $('.noEntryTD').first().toggle();
    } else {
        var table = $('#schedule-table');
        for (var i=schedules.length-2; i>=0; i--) {
            var trHtml = '<tr><td><span class="language-string">';
            trHtml += ParseDays(schedules[i].Days);
            trHtml += '</span></td><td><span class="language-string">' + vdfringsch['vspa_ptvdf_rs_times_from'] + ' </span>';
            trHtml += schedules[i].TimeFrom;
            trHtml += '<span class="language-string"> ' + vdfringsch['vspa_ptvdf_rs_times_to'] + ' </span>';
            trHtml += schedules[i].TimeTo;
            trHtml += '</td><td><span class="language-string">';
            if (schedules[i].Numbers == 'all') {
                trHtml += vdfringsch['vspa_ptvdf_rs_numbers_all'];
            } else {
                trHtml += schedules[i].Numbers;
            }
            trHtml += '</span></td>';
            trHtml += '<td><div class="schedule-on" style="display:none;">';
            trHtml += '<span class="language-string">' + vdfringsch['vspa_ptvdf_rs_policy_enable'] + '</span></div>';
            trHtml += '<div class="schedule-off" style="display:none;">';
            trHtml += '<span class="language-string">' + vdfringsch['vspa_ptvdf_rs_policy_disable'] + '</span></div></td>';
            trHtml += '<td><input class="button button-edit image-style" type="button" value="" id="edit_' + i + '"></td>';
            trHtml += '<td><input class="button button-delete right image-style" type="button" value="" id="delet_'+ i+'"></td></tr>';
            table.prepend(trHtml);
        }
    }
}

function ParseDays(Days)
{
    if (Days == '0000011')
        return vdfringsch['vspa_ptvdf_rs_weekend'];
    else if (Days == '1111100')
        return vdfringsch['vspa_ptvdf_rs_workday'];
    else if (Days == '1111111')
        return vdfringsch['vspa_ptvdf_rs_everyday'];
    else {
        var result = '';
        if (Days[0] == '1')
            result += vdfringsch['vspa_ptvdf_rs_days_mon'] + ',';
        if (Days[1] == '1')
            result += vdfringsch['vspa_ptvdf_rs_days_tue'] + ',';
        if (Days[2] == '1')
            result += vdfringsch['vspa_ptvdf_rs_days_wed'] + ',';
        if (Days[3] == '1')
            result += vdfringsch['vspa_ptvdf_rs_days_thu'] + ',';
        if (Days[4] == '1')
            result += vdfringsch['vspa_ptvdf_rs_days_fri'] + ',';
        if (Days[5] == '1')
            result += vdfringsch['vspa_ptvdf_rs_days_sat'] + ',';
        if (Days[6] == '1')
            result += vdfringsch['vspa_ptvdf_rs_days_sun'] + ',';
        if (result.length > 0)
            result = result.substring(0, result.length-1)
        return result;
    }
}

function InitApplyBtn()
{
    var html = '<input class="button button-apply" id="applyButton" type="button" value="' + vdfringsch['vspa_ptvdf_rs_apply'];
    html += '"><input class="button button-cancel " id="cancelButton" type="button" value="' + vdfringsch['vspa_ptvdf_rs_cancel'] + '" onclick="">';
    return html;
}

function InitDaySelect()
{
    var html = '<ul class="chosen-results"><li class="active-result" data-option-array-index="0">';
    html += vdfringsch['vspa_ptvdf_rs_individ'];
    html += '</li><li class="active-result" data-option-array-index="1">';
    html += vdfringsch['vspa_ptvdf_rs_everyday'];
    html += '</li><li class="active-result" data-option-array-index="2">';
    html += vdfringsch['vspa_ptvdf_rs_workday'];
    html += '</li><li class="active-result" data-option-array-index="3">';
    html += vdfringsch['vspa_ptvdf_rs_weekend'];
    html += '</li></ul>';
    return html;
}

function InitPopApplyBtn()
{
    var html = '<input class="button button-apply" id="edit-apply" type="button" value="' + vdfringsch['vspa_ptvdf_rs_apply'];
    html += '"><input class="button button-cancel " id="edit-cancel" type="button" value="' + vdfringsch['vspa_ptvdf_rs_cancel'] + '" onclick="">';
    return html;
}

var scheduleIndex = -1;
function ShowEditPop(id)
{
    scheduleIndex = id;
    numbers = new Array();
    var lines = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i},DirectoryNumber|PhyReferenceList,stLine);%>;
    var authUsers = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.{i}.Line.{i}.SIP, AuthUserName|URI, stAuth);%>;
    for (var i=0; i<lines.length-1; i++) {
        for (var j=0; j<authUsers.length-1; j++) {
            if(lines[i].InstId == authUsers[j].LineId) {
                if (authUsers[j].URI.length > 0) {
                    numbers.push(authUsers[j].URI);
                } else if (lines[i].DirectoryNumber.length > 0) {
                    numbers.push(lines[i].DirectoryNumber);
                } else {
                    numbers.push(authUsers[j].AuthUserName); 
                }
            }
        }
    }
    $('#edit-popup').toggle();
    $('#addNumber').removeClass('op40');
    InitEditNumberLayout(id);
    InitEditDaysLayout(id);
    InitEditTimeLayout(id);
    window.parent.getElementById("indexblackBackground").style.display = "block";
}

function InitEditNumberLayout(id)
{
    allNumbers = new Array();
    var schNumbers = new Array();
    if (id == -1) {
        allNumbers = numbers;
        allNumbers.push(vdfringsch['vspa_ptvdf_rs_numbers_all']);
        schNumbers.push(allNumbers[0]);
    } else {
        schNumbers = schedules[id].Numbers.split(',');
        for (var i=0; i<numbers.length; i++) {
            var findFlag = 0;
            for (var j=0; j<schNumbers.length; j++) {
                if (numbers[i] == schNumbers[j]) {
                    findFlag = 1;
                    break;
                }
            }
            if (findFlag == 0) {
                allNumbers.push(numbers[i]);
            }
        }
        if (schedules[id].Numbers == 'all') {
            allNumbers.unshift(vdfringsch['vspa_ptvdf_rs_numbers_all']);
        } else {
            allNumbers.push(vdfringsch['vspa_ptvdf_rs_numbers_all']);
            for (var i=0; i<schNumbers.length; i++) {
            if (schNumbers[i].length > 0) {
                allNumbers.unshift(schNumbers[i]);
            }
        }
        }
        
    }
    for (var i=1; i<=8; i++) {
        var numItem = $('#number' + i);
        if (i <= schNumbers.length) {
            numItem.attr('style', 'display: block');
        } else {
            numItem.attr('style', 'display: none');
            continue;
        }
        InitNumberSelect(numItem, i-1);
    }
}

function InitNumberSelect(numItem, selectindex) 
{
    var chosenList = numItem.find('.chosen-results').first();
    chosenList.empty();
    for (var j=0; j<allNumbers.length; j++) {
        chosenList.append('<li class="active-result">' + allNumbers[j] + '</li>');
    }
    chosenList.find('li').on('click', function() {
         if ($(this).hasClass('.result-selected')) {
            return;
        }
        var selected = $(this).parent().find('.result-selected');
        if (selected.length > 0) {
            selected.first().toggleClass('result-selected');
            selected.first().removeClass('highlighted');
        }
        $(this).toggleClass('highlighted');
        $(this).toggleClass('result-selected');
        var input = $(this).closest('.chosen-container').find('span');
        var html = $(this).html();
        input.text(html);
    });
    var item = chosenList.find('.active-result').eq(selectindex);
    item.addClass('result-selected');
    item.addClass('highlighted');
    var tmp = chosenList.closest('.chosen-container').first().find('span');
    tmp.first().text(item.html());
}

function InitEditDaysLayout(id)
{
    var individualDays = $('#individualDays');
    if (individualDays.is(':visible')) {
        individualDays.toggle();
    }
    var daySelect = $('#selectDays');
    var items = daySelect.find('.active-result');
    var itemStr;
    var Days;
    if (id == -1) {
        Days = '0000011'; 
        itemStr = vdfringsch['vspa_ptvdf_rs_weekend'];
    } else {
        Days = schedules[id].Days;
        if (Days == '1111111') {
            itemStr = vdfringsch['vspa_ptvdf_rs_everyday'];
        } else if (Days == '1111100') {
            itemStr = vdfringsch['vspa_ptvdf_rs_workday'];
        } else if (Days == '0000011') {
            itemStr = vdfringsch['vspa_ptvdf_rs_weekend'];
        } else {
            itemStr = vdfringsch['vspa_ptvdf_rs_individ'];
        }
    }
    for (var i=0; i<items.length; i++) {
        var item = items.eq(i)
        if (item.html() == itemStr) {
            item.addClass('result-selected');
            item.addClass('highlighted');
            var tmp = daySelect.find('span');
            tmp.first().text(item.html());
        } else {
            item.removeClass('result-selected');
            item.removeClass('highlighted');
        }
    }
    if (itemStr == vdfringsch['vspa_ptvdf_rs_individ']) {
        individualDays.toggle();
        for (var i=1; i<=7; i++) {
            $('#ch' + i).attr("checked", Days[i-1] == '1' ? true : false);
        }
    }
}

function InitEditTimeLayout(id)
{
    if (id < 0)
        return;
    if (schedules[id].TimeFrom.length > 0)
        $('#fromTime').attr('value', schedules[id].TimeFrom);
    if (schedules[id].TimeTo.length > 0)
        $('#toTime').attr('value', schedules[id].TimeTo);
}

function SubmitScheduleEnable(enable)
{
    if (!initFlag) {
        return;
    }
    var Form = new webSubmitForm();
    scheduleStatus[0].Enable = (enable ? 1 : 0);
    Form.addParameter('a.Enable', scheduleStatus[0].Enable);
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    var ActionURL = 'set.cgi?'
            + 'a=InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_RingSchedule'
            + '&x=InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1'
            + '&RequestFile=html/voip/vdfringsch/vdfringsch.asp';
    
    Form.setAction(ActionURL);
    Form.submit();
}

function SubmitSchedulePolicy(isApply)
{
    var Form = new webSubmitForm();
    if (isApply) {
        Form.addParameter('a.Policy', curPolicy);
    } else {
        Form.addParameter('a.Policy', scheduleStatus[0].Policy);
    }
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    var ActionURL = 'set.cgi?'
                + 'a=InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_RingSchedule'
                + '&x=InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1'
                + '&RequestFile=html/voip/vdfringsch/vdfringsch.asp';

    Form.setAction(ActionURL);
    Form.submit();
    scheduleStatus[0].Policy = curPolicy;
}

function SubmitDelSchedule(index)
{
    var Form = new webSubmitForm();
    Form.addParameter(schedules[index].Domain, '');
    Form.addParameter('x.X_HW_Token', getValue('onttoken'));
    var ActionURL = 'del.cgi?'
                    + 'RequestFile=html/voip/vdfringsch/vdfringsch.asp';
    Form.setAction(ActionURL);
    Form.submit();
}

function SubmitEditSchedule()
{
    var Numbers = '';
    for (var i=1; i<=8; i++) {
        var numItem = $('#number' + i);
        if (numItem.is(':visible')) {
            var num = numItem.find('.chosen-container').first().find('span').text();
            if (num == vdfringsch['vspa_ptvdf_rs_numbers_all']) {
                Numbers = 'all,';
                break;
            } else {
                var nums = Numbers.split(',');
                var findFlag = 0;
                for (var j=0; j<nums.length; j++) {
                    if (nums[j] == num) {
                        findFlag = 1;
                        break;
                    }
                }
                if (findFlag == 0) {
                    Numbers += num + ',';
                }
            }
        }
    }
    Numbers = Numbers.substring(0, Numbers.length-1);
    var Days = '';
    var daySelect = $('#selectDays').find('span').first().html();
    if (daySelect == vdfringsch['vspa_ptvdf_rs_everyday']) {
        Days = '1111111';
    } else if (daySelect == vdfringsch['vspa_ptvdf_rs_workday']) {
        Days = '1111100';
    } else if (daySelect == vdfringsch['vspa_ptvdf_rs_weekend']) {
        Days = '0000011';
    } else {
        for (var i=1; i<=7; i++) {
            if($('#ch' + i).is(':checked')) {
                Days += '1';
            } else {
                Days += '0';
            }
        }
    }
    var TimeFrom = $('#fromTime').val();
    var TimeTo = $('#toTime').val();
    if (TimeFrom > TimeTo) {
        alert(vdfringsch['vspa_ptvdf_rs_pop_tips']);
        return false;
    }
    if (scheduleIndex == -1) {
        var Form = new webSubmitForm();
        Form.addParameter('Add_b.Numbers', Numbers);
        Form.addParameter('Add_b.Days', Days);
        Form.addParameter('Add_b.TimeFrom', TimeFrom);
        Form.addParameter('Add_b.TimeTo', TimeTo);
        Form.addParameter('a.Policy', curPolicy);
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        var ActionURL = 'complex.cgi?'
                + 'a=InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_RingSchedule'
                + '&Add_b=InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_RingSchedule.Schedules'
                + '&RequestFile=html/voip/vdfringsch/vdfringsch.asp';
        Form.setAction(ActionURL);
        Form.submit();
    } else {
        var Form = new webSubmitForm();
        Form.addParameter('a.Numbers', Numbers);
        Form.addParameter('a.Days', Days);
        Form.addParameter('a.TimeFrom', TimeFrom);
        Form.addParameter('a.TimeTo', TimeTo);
        Form.addParameter('b.Policy', curPolicy);
        Form.addParameter('x.X_HW_Token', getValue('onttoken'));
        var ActionURL = 'set.cgi?'
                + 'a=InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_RingSchedule.Schedules.'
                + schedules[scheduleIndex].InstanceID
                + '&b=InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.X_HW_RingSchedule'
                + '&RequestFile=html/voip/vdfringsch/vdfringsch.asp';
        Form.setAction(ActionURL);
        Form.submit();
    }
    return true;
}

</script>
</head>
<body>
    <div id="look_4" class="white-background">
        <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
        <div class="reset-ringing-schedule" id="resetWrap" style="display: none;">
            <div class="resetButtons resetButtonsShort" id="resetButtonsShort">
                <div class="rel">
                    <span class="left" id="resetB">&nbsp;</span>
                </div>
            </div>
            <div class="resetBar" id="resetBar" style="display: none;">
                <div style="">
                    <div class="clearfix">
                        <span id="resetT">
                            Do you want to reset this page to default settings?
                        </span>
                        <input title="Cancel" class="cancelR button button-cancel " id="cancelR" type="button" value="Cancel">
                        <input title="Reset" class="resetR button button-apply" id="resetR" type="button" value="Reset">

                        <div class="reset-bar"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="content-ringing-schedule" id="content" style="padding-right:5px">
            <h1>
                <span class="language-string" name="PAGE_RINGING_SCHEDULE_TITLE"><script>document.write(vdfringsch['vspa_ptvdf_rs_title']);</script></span>
            </h1>
            <h2>
                <span class="language-string" name="PAGE_RINGING_SCHEDULE_SUBTITLE"><script>document.write(vdfringsch['vspa_ptvdf_rs_title_lab']);</script></span>
            </h2>

            <div class="ringingScheduleContent">
                <div class="h3-content no-padding-bottom">
                    <div class="row mobile-row-half">
                        <div class="left">
                            <span class="language-string" name="PAGE_RINGING_SCHEDULE_RINGING_SCHEDULE"><script>document.write(vdfringsch['vspa_ptvdf_rs_status_lab']);</script></span>
                        </div>
                        <div class="right">
                            <div id="hide-all"></div>
                        </div>
                    </div>
                </div>
                <div id="hide-content" class="level-3 hide-all shadowProblem">
                    <div class="h3-content">
                        <div class="row assign-row">
                            <div class="left">
                                <span class="language-string" name="PAGE_RINGING_SCHEDULE_DURING_THIS_TIME"><script>document.write(vdfringsch['vspa_ptvdf_rs_policy']);</script></span>
                            </div>
                            <div class="right">
                                <div title="" class="chosen-container chosen-container-single chosen-container-single-nosearch" id="policy-select" style="width: 0px;">
                                    <a tabindex="-1" class="chosen-single">
                                        <span></span><div><b></b></div>
                                    </a>
                                    <div class="chosen-drop">
                                        <div class="chosen-search">
                                            <input type="text" autocomplete="off" readonly="">
                                        </div>
                                        <script>
                                            document.write(InitPolicySelect());
                                        </script>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="h3-content">
                        <table class="no-mobile table-three-columns" id="schedule-table">
                            <thead>
                                <tr>
                                <th style="width: 133px;">
                                    <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_days']);</script></span>
                                </th>
                                <th style="width: 159px;">
                                    <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_times']);</script></span>
                                </th>
                                <th style="width: 99px;">
                                    <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_numbers']);</script></span>
                                </th>
                                <th style="width: 75px;">
                                    <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_status']);</script></span>
                                </th>
                                <th style="width: 40px;">&nbsp;</th>
                                <th style="width: 50px;">&nbsp;</th>
                                </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td class="noEntryTD tC italic" style="display: none;" colspan="6">
                                    <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_empty_lab']);</script></span>
                                </td>
                            </tr>
                            <script>
                                InitSchedulsTable();
                            </script>
                            <tr class="btnAdd">
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>
                                <input class="button button-add right popup-add image-style" id="addSchedule" type="button" onClick="" value="">
                            </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <div class="clearfix apply-cancel">
                <script>
                    document.write(InitApplyBtn());
                </script>
            </div>
        </div>

        <div class="blackBackground" id="edit-popup" style="display:none;">
            <div class="popup big add">
                <p class="title">
                    <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_pop_title']);</script></span>
                </p>
                <div class="row assign-row22" id="number1">
                    <div class="left" style="width: 240px;">
                        <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_pop_lab1']);</script></span>:
                    </div>
                    <div class="right" style="padding-right:10px;">
                        <div title="" class="chosen-container chosen-container-single chosen-container-single-nosearch" style="width: 0px;">
                            <a tabindex="-1" class="chosen-single">
                                <span></span>
                                <div><b></b></div>
                            </a>
                            <div class="chosen-drop">
                                <div class="chosen-search">
                                    <input type="text" readonly="" autocomplete="off">
                                </div>
                                <ul class="chosen-results"></ul>
                            </div>
                        </div>
                    </div>
                    <div class="right" style="padding-right: 16px;">
                        <input class="button button-delete op40" type="button" value="">
                    </div>
                </div>
                <div class="row assign-row22" style="display:none" id="number2">
                    <div class="left" style="width: 240px;">
                    </div>
                    <div class="right" style="padding-right:10px;">
                        <div title="" class="chosen-container chosen-container-single chosen-container-single-nosearch" style="width: 0px;">
                            <a tabindex="-1" class="chosen-single">
                                <span>All</span>
                                <div><b></b></div>
                            </a>
                            <div class="chosen-drop">
                                <div class="chosen-search">
                                    <input type="text" readonly="" autocomplete="off">
                                </div>
                                <ul class="chosen-results"></ul>
                            </div>
                        </div>
                    </div>
                    <div class="right" style="padding-right:16px">
                        <input class="button button-delete" type="button" value="">
                    </div>
                </div>
                <div class="row assign-row22" style="display:none" id="number3">
                    <div class="left" style="width: 240px;">
                    </div>
                    <div class="right" style="padding-right:10px;">
                        <div title="" class="chosen-container chosen-container-single chosen-container-single-nosearch" style="width: 0px;">
                            <a tabindex="-1" class="chosen-single">
                                <span></span>
                                <div><b></b></div>
                            </a>
                            <div class="chosen-drop">
                                <div class="chosen-search">
                                    <input type="text" readonly="" autocomplete="off">
                                </div>
                                <ul class="chosen-results"></ul>
                            </div>
                        </div>
                    </div>
                    <div class="right" style="padding-right:16px">
                        <input class="button button-delete" type="button" value="">
                    </div>
                </div>
                <div class="row assign-row22" style="display:none" id="number4">
                    <div class="left" style="width: 240px;">
                    </div>
                    <div class="right" style="padding-right:10px;">
                        <div title="" class="chosen-container chosen-container-single chosen-container-single-nosearch" style="width: 0px;">
                            <a tabindex="-1" class="chosen-single">
                                <span>All</span>
                                <div><b></b></div>
                            </a>
                            <div class="chosen-drop">
                                <div class="chosen-search">
                                    <input type="text" readonly="" autocomplete="off">
                                </div>
                                <ul class="chosen-results"></ul>
                            </div>
                        </div>
                    </div>
                    <div class="right" style="padding-right:16px">
                        <input class="button button-delete" type="button" value="">
                    </div>
                </div>
                <div class="row assign-row22" style="display:none" id="number5">
                    <div class="left" style="width: 240px;">
                    </div>
                    <div class="right" style="padding-right:10px;">
                        <div title="" class="chosen-container chosen-container-single chosen-container-single-nosearch" style="width: 0px;">
                            <a tabindex="-1" class="chosen-single">
                                <span>All</span>
                                <div><b></b></div>
                            </a>
                            <div class="chosen-drop">
                                <div class="chosen-search">
                                    <input type="text" readonly="" autocomplete="off">
                                </div>
                                <ul class="chosen-results"></ul>
                            </div>
                        </div>
                    </div>
                    <div class="right" style="padding-right:16px">
                        <input class="button button-delete" type="button" value="">
                    </div>
                </div>
                <div class="row assign-row22" style="display:none" id="number6">
                    <div class="left" style="width: 240px;">
                    </div>
                    <div class="right" style="padding-right:10px;">
                        <div title="" class="chosen-container chosen-container-single chosen-container-single-nosearch" style="width: 0px;">
                            <a tabindex="-1" class="chosen-single">
                                <span>All</span>
                                <div><b></b></div>
                            </a>
                            <div class="chosen-drop">
                                <div class="chosen-search">
                                    <input type="text" readonly="" autocomplete="off">
                                </div>
                                <ul class="chosen-results"></ul>
                            </div>
                        </div>
                    </div>
                    <div class="right" style="padding-right:16px">
                        <input class="button button-delete" type="button" value="">
                    </div>
                </div>
                <div class="row assign-row22" style="display:none" id="number7">
                    <div class="left" style="width: 240px;">
                    </div>
                    <div class="right" style="padding-right:10px;">
                        <div title="" class="chosen-container chosen-container-single chosen-container-single-nosearch" style="width: 0px;">
                            <a tabindex="-1" class="chosen-single">
                                <span>All</span>
                                <div><b></b></div>
                            </a>
                            <div class="chosen-drop">
                                <div class="chosen-search">
                                    <input type="text" readonly="" autocomplete="off">
                                </div>
                                <ul class="chosen-results"></ul>
                            </div>
                        </div>
                    </div>
                    <div class="right" style="padding-right:16px">
                        <input class="button button-delete" type="button" value="">
                    </div>
                </div>
                <div class="row assign-row22" style="display:none" id="number8">
                    <div class="left" style="width: 240px;">
                    </div>
                    <div class="right" style="padding-right:10px;">
                        <div title="" class="chosen-container chosen-container-single chosen-container-single-nosearch" style="width: 0px;">
                            <a tabindex="-1" class="chosen-single">
                                <span>All</span>
                                <div><b></b></div>
                            </a>
                            <div class="chosen-drop">
                                <div class="chosen-search">
                                    <input type="text" readonly="" autocomplete="off">
                                </div>
                                <ul class="chosen-results"></ul>
                            </div>
                        </div>
                    </div>
                    <div class="right" style="padding-right:16px">
                        <input class="button button-delete" type="button" value="">
                    </div>
                </div>
                <div class="mobile-add-container row" style="display: block;">
                    <div class="right" style="width: 240px;">
                    </div>
                    <div class="right" style="width: 240px;">
                    </div>
                    <div class="right" style="padding-right:16px">
                        <input class="button button-add assign-add22" id="addNumber" type="button" value="">
                    </div>
                </div>
                <div class="row" style="display: block;">
                    <div class="left" style="width: 240px;">
                        <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_pop_lab2']);</script></span>
                    </div>
                    <div class="right" style="padding-right:10px;">
                        <div title="" class="chosen-container chosen-container-single chosen-container-single-nosearch" id="selectDays" style="width: 0px;">
                            <a tabindex="-1" class="chosen-single">
                                <span></span>
                                <div><b></b></div>
                            </a>
                            <div class="chosen-drop">
                                <div class="chosen-search">
                                    <input type="text" readonly="" autocomplete="off">
                                </div>
                                <script>
                                    document.write(InitDaySelect());
                                </script>
                            </div>
                        </div>
                    </div>
                    <div class="right" style="width: 46px; padding-right:16px">
                    </div>
                </div>

                <div id="individualDays" style="display: none;">
                    <div class="row">
                        <div class="left space-right" style="width: 50%;">
                            <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_pop_lab3']);</script></span>
                        </div>
                        <div class="right no-text-align">
                            <input class="checkbox checkbox-unchecked ch1" id="ch1" type="checkbox">
                            <label for="ch1"></label>
                            <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_days_monday']);</script></span>
                        </div>
                        <div class="right no-text-align">
                            <input class="checkbox checkbox-unchecked ch6" id="ch6" type="checkbox">
                            <label for="ch6"></label>
                            <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_days_saturday']);</script></span>
                        </div>
                    </div>
                    <div class="no-mobile row">
                        <div class="left"></div>
                        <div class="right no-text-align">
                            <input class="checkbox checkbox-unchecked ch2" id="ch2" type="checkbox">
                            <label for="ch2"></label>
                            <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_days_tuesday']);</script></span>
                        </div>
                          <div class="right no-text-align">
                            <input class="checkbox checkbox-unchecked ch7" id="ch7" type="checkbox">
                            <label for="ch7"></label>
                            <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_days_sunday']);</script></span>
                        </div>
                    </div>
                    <div class="no-mobile row">
                        <div class="left"></div>
                        <div class="right no-text-align">
                            <input class="checkbox checkbox-unchecked ch3" id="ch3" type="checkbox">
                            <label for="ch3"></label>
                            <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_days_wednesday']);</script></span> 
                        </div>
                        <div class="right no-text-align"></div>
                    </div>
                    <div class="no-mobile row">
                        <div class="left"></div>
                        <div class="right no-text-align">
                            <input class="checkbox checkbox-unchecked ch4" id="ch4" type="checkbox">
                            <label for="ch4"></label>
                            <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_days_thursday']);</script></span>
                        </div>
                        <div class="right no-text-align"></div>
                    </div>
                    <div class="no-mobile row">
                        <div class="left"></div>
                        <div class="right no-text-align">
                            <input class="checkbox checkbox-unchecked ch5" id="ch5" type="checkbox">
                            <label for="ch5"></label>
                            <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_days_friday']);</script></span>
                        </div>
                        <div class="right no-text-align"></div>
                    </div>
                 </div>
                
                <div class="row">
                    <div class="left" style="width: 50%;">
                        <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_pop_lab4']);</script></span>
                    </div>
                    <div class="mobile-popup right" style="width: 50%;">
                       <div class="row">  
                            <div class="left">
                                <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_times_from']);</script></span>
                                <input style="width: 82px;" type="time" maxlength="5" value="09:00" id='fromTime'> 
                            </div>
                            <div class="right" style="padding-left: 15px;">
                                <span class="language-string"><script>document.write(vdfringsch['vspa_ptvdf_rs_times_to']);</script></span>
                                <input style="width: 82px;" type="time" maxlength="5" value="10:30" id="toTime">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="apply-cancel">
                    <script>
                        document.write(InitPopApplyBtn());
                    </script>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
