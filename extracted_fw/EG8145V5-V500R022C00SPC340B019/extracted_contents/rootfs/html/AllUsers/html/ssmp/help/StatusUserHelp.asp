<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<script src="/resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>" type="text/javascript"></script>
<script src="/resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>" type="text/javascript" ></script>
</head>
<body class="mainbody" >
<blockquote>
<script language="javascript"> 
var menuJsonData;
var MENU_DESCRIPTION_MAP =  {
    "LAN信息" : "以太网接口信息",
    "LAN接口信息" : "以太网接口信息",
    "LAN用户信息" : "以太网用户信息",
    "WLAN信息" : "WLAN接口信息",
    "语音接口" : "语音接口信息",
}

function getUserInfoMenuArray(menuJsonData) {
    var userInfoArray = [];
    menuJsonData.forEach(menuArray => {
        if(menuArray.name !== "状态") {
            return;
        }
        menuArray.subMenus.forEach(subMenuItem => { 
            if (subMenuItem.name === "用户侧信息") {
                userInfoArray = subMenuItem.subMenus;
            } 
        });
	});

    return userInfoArray;
}

function generateTxtMenuArray(userInfoArray) {
    var txtMenuArray = "";
    var numOfArray = userInfoArray.length;
    if (numOfArray === 0) {
        txtMenuArray = "<p><b>用户侧信息</b></p><p>获取菜单状态失败</p>";
        return txtMenuArray;
    }

    userInfoArray.forEach((userInfoObj, index)=> {
        var userInfoName = userInfoObj.name;
        userInfoName = (userInfoName in MENU_DESCRIPTION_MAP) ? MENU_DESCRIPTION_MAP[userInfoName] : userInfoName;
        if (index < numOfArray -1) {
            txtMenuArray += `${userInfoName}，`;
            return;
        }
        txtMenuArray += `${userInfoName}。`;
    })
    txtMenuArray = `<p><b>用户侧信息</b></p><p>包括家庭终端用户侧${txtMenuArray}</p>`;
    return txtMenuArray;
}

$.ajax({
    type : "POST",
    async : false,
    cache : false,
    url : "/asp/getMenuArray.asp",
    success : function(data) {
         menuJsonData  = dealDataWithFun(data);
         userInfoArray = getUserInfoMenuArray(menuJsonData);
         txtMenuArray = generateTxtMenuArray(userInfoArray);
         document.write(txtMenuArray);
    }
});
</script>

</blockquote>
</body>
</html>

