var lldpIdx = 0;
var ssidIdx = 0;
var changeWlanClick = 1;   
var WlanBasicPage = '2G';
var WlanAdvancePage = '2G';
var WlanSTAPIN = '';
var lanDevIndex = 1;
var QoSCurInterface = '';
var DDNSProvider = '';
var ripIndex = "";
var previousPage = "";
var preAddDomain = "";
var editIndex = -1;
var editDomain = '';
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>'; 
var sptUserType = '1';
var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var MenuName = "";
var StartIndex = 1;
var Menu2Path = "";
var authMode = 0;
var Passwordmode = 0;
var changeMethod = 999; 
var SaveDataFlag = 0;
var RouteFlag = 0;
var collectType = "";
var EquipFlag = 0;


var Frame = {
    init : function() {
        //this.initElement();
    },

    getRemoteData : function() {
    },

	show : function() {
        var frame = this;
        frame.getRemoteData();
        $(document).ready(function() {
            frame.init();
        });
    }
};

Frame.show();
