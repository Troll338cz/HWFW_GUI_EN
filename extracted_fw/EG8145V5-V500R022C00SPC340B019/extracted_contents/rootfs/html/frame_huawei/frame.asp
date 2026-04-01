
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
var sptUserType = '1';
var sysUserType = '0';
var MenuName = "";
var StartIndex = 1;
var Menu2Path = "";
var authMode = 0;
var Passwordmode = 0;
var changeMethod = 999;
var UpgradeFlag = 0;
var SaveDataFlag = 0;
var collectType = "";
var PwdModifyFlag = 1;
var PwdAspNum = 0;
var SystemToolsNum = 0;
var EquipFlag = 0;
var productName = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.DeviceInfo.ModelName);%>';
var CfgMode ='<%HW_WEB_GetCfgMode();%>';
var curLanguage = '<%HW_WEB_GetCurrentLanguage();%>';
var curUserType = '<%HW_WEB_GetUserType();%>';
var TypeWordMode = '<%HW_WEB_GetTypeWord();%>'
var jumptomodifypwd = '<%HW_WEB_GetWebUserMdFlag();%>';
var menuArray = <%HW_WEB_GetWebMenuArray();%>;
var LoginDeviceInfoFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_DEVICEINFO);%>'; 
var curWebMode = '<%HW_WEB_GetWebMode();%>'; 
var Ftmodifyowner =  '<%HW_WEB_GetFeatureSupport(FT_WEB_MODIFY_OWNER_PWD);%>'; 
var ProductType = '<%HW_WEB_GetProductType();%>';
var sonetFlag = '<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATURE_MNGT_SONET);%>';
var UserName = '<%HW_WEB_GetCurUserName();%>';

if ('ORO' == CfgMode.toUpperCase())
{
    productName = "Internet Box 1000";
}

document.title = productName;

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

var Frame = {

    menuItems : [],
    mainMenuCounter : 0,
    subMenuCounter : 0,
    $mainMenu : null,
    $subMenu : null,
    $content : null,

    init : function() {
        this.initData();
        this.initElement();
    },

    initData : function() {
        var frame = this;

        this.mainMenuCounter = 0;
        this.subMenuCounter = 0;

        this.$mainMenu = $("#headerTab ul");
        this.$subMenu = $("#nav ul");
        this.$content = $("#frameContent");

        this.$content.on("load", function() {
            frame.$content.show();
            frame.setContentHeight();
        });
        var TmpMenuInfoArray = menuArray;
        var DestMenuInfo = null;
        if(0 == curWebMode){
            var ModeType = "Basic Mode";
        }else{
            var ModeType = "Expert Mode";
        }
        
        for(var Index in TmpMenuInfoArray)
        {
            if(ModeType == TmpMenuInfoArray[Index].name)
            {
                if(undefined != TmpMenuInfoArray[Index].subMenus)
                {
                    DestMenuInfo = TmpMenuInfoArray[Index].subMenus;
                }
                
                break;
            }
        }
        
        this.menuItems = (null == DestMenuInfo || undefined == DestMenuInfo)?TmpMenuInfoArray:DestMenuInfo;
    },
    
    initElement : function() {
        $("#headerTitle").text(productName);

        this.setLogoutElement(curLanguage);
        this.setCopyRightInfo(curLanguage);
        this.setAppDesInfo(curLanguage);

        if (this.menuItems.length > 0) {
            this.addMenuItems(this.$mainMenu, this.menuItems, "main");

            if(("Quick Setup" == this.menuItems[0].name))
            {
                jumptomodifypwd = 1;
            }
            
            if ((CfgMode.toUpperCase() == "TELIALT") && (0 == LoginDeviceInfoFlag) && (curUserType != sysUserType) && (PwdModifyFlag == 1))
            {
                var pwdurl = "html/amp/ontauth/passwordcommon.asp";
                
                MenuName = "System Tools";
                Menu2Path = "ONT Authentication";
                    
                var indexPos;                        
                for (indexPos = 0; indexPos < this.menuItems.length; indexPos++)
                {
                    if (this.menuItems[indexPos].name == MenuName)
                    {
                        break;
                    }                
                }
                if (indexPos == this.menuItems.length)
                {
                    indexPos = this.menuItems.length - 1;
                }
                this.addMenuItems(this.$subMenu, this.menuItems[indexPos].subMenus, "sub");
                this.setContentPath(pwdurl);
            }
            else if ((jumptomodifypwd == 0) && (0 == LoginDeviceInfoFlag) && (curUserType != sysUserType) && (PwdModifyFlag == 1))
            {
                var pwdurl = "html/ssmp/accoutcfg/account.asp";
                if(CfgMode.toUpperCase() == "BELTELECOM" || CfgMode.toUpperCase() == "BELTELECOM2")
                {
                    if(TypeWordMode.toUpperCase() == "LAN"){
                        var pwdurl = "html/ssmp/accoutcfg/account.asp";
                    }else{
                        pwdurl = "html/ssmp/accoutcfg/accountBeltelecom.asp";
                    }
                }

                if(CfgMode.toUpperCase() == "ROSUNION") {
                    pwdurl = "html/ssmp/accoutcfg/accountrosunion.asp";
                }
                if(curLanguage.toUpperCase() == "ENGLISH")
                {
                    MenuName = "System Tools";
                    Menu2Path = "Modify Login Password";
                }
                else if(curLanguage.toUpperCase() == "PORTUGUESE")
                {
                    MenuName = "Ferram. de Sis.";
                    Menu2Path = "Alterar palavra-passe";
                }
                else if(curLanguage.toUpperCase() == "JAPANESE")
                {
                    MenuName = "システムツール";
                    Menu2Path = "ログインパスワードの変更";
                }
                else if(curLanguage.toUpperCase() == "SPANISH")
                {
                    MenuName = "Herramientas del sistema";
                    Menu2Path = "Modificar contraseña";
                }
                else if(curLanguage.toUpperCase() == "RUSSIAN")
                {
                    MenuName = "Инструменты";
                    Menu2Path = "Изменение пароля";
                }
                else if(curLanguage.toUpperCase() == "CHINESE")
                {
                    MenuName = "系统工具";
                    Menu2Path = "修改登录密码";
                }
                else if(curLanguage.toUpperCase() == "TURKISH")
                {
                    MenuName = "Sistem Araçları";
                    Menu2Path = "Giriş Şifresini Değiştir";
                }
                else 
                {
                    MenuName = "System Tools";
                    Menu2Path = "Modify Login Password";
                }
                
                var indexPos;                        
                for (indexPos = 0; indexPos < this.menuItems.length; indexPos++)
                {
                    if (this.menuItems[indexPos].name == MenuName)
                    {
                        break;
                    }                
                }
                if (indexPos == this.menuItems.length)
                {
                    indexPos = this.menuItems.length - 1;
                }
                this.addMenuItems(this.$subMenu, this.menuItems[indexPos].subMenus, "sub");
                this.setContentPath(pwdurl);
            }
            else if ((jumptomodifypwd == 0) && (0 == LoginDeviceInfoFlag) && (curUserType == sysUserType) && (Ftmodifyowner == 1) && (PwdModifyFlag == 1))
            {
                var pwdurl = "html/ssmp/accoutcfg/accountadmin.asp";
                
                MenuName = "System Tools";
                Menu2Path = "Modify Login Password";
                    
                var indexPos;                        
                for (indexPos = 0; indexPos < this.menuItems.length; indexPos++)
                {
                    if (this.menuItems[indexPos].name == MenuName)
                    {
                        break;
                    }                
                }
                if (indexPos == this.menuItems.length)
                {
                    indexPos = this.menuItems.length - 1;
                }
                this.addMenuItems(this.$subMenu, this.menuItems[indexPos].subMenus, "sub");
                this.setContentPath(pwdurl);
            
            }
            else
            {
                MenuName = this.menuItems[0].name;
                Menu2Path = this.menuItems[0].subMenus[0].name;
                this.addMenuItems(this.$mainMenu, this.menuItems, "main");
                this.addMenuItems(this.$subMenu, this.menuItems[0].subMenus, "sub");
            }
        }
    },

    addMenuItems : function(element, menus, type) {
        var frame = this;
        var posDeviceInfo = 0;
        element.empty();
        if(type == "main") {
            this.mainMenuCounter = 0;
            for (var i = 0, len = menus.length; i < len; i++) {

                if(menus[i].name == "System Tools"
                    || menus[i].name == "Ferram. de Sis."
                    || menus[i].name == "システムツール" 
                    || menus[i].name == "Herramientas del sistema"
                    ||  menus[i].name == "Инструменты"
                    ||  menus[i].name == "系统工具"
                    || menus[i].name == "Sistem Araçları")
                {
                    SystemToolsNum = i;
                }
                
                var maindivname = GetIdByUrl("maindiv", menus[i].url);
                var mainliname = GetIdByUrl("mainli", menus[i].url);
                var leftlistr = '<li value="' + i + '" name="' + mainliname + '">';
                var middledivstr = '<div class="tabBtnCenter" name="' + maindivname + '">' + menus[i].name + '</div>';
                element.append( leftlistr + '<div class="tabBtnLeft"></div>' + middledivstr + '<div class="tabBtnRight"></div>' + '</li>');
            }
            
            if (('TELIALT' == CfgMode.toUpperCase()) && (0 == LoginDeviceInfoFlag) && (curUserType != sysUserType) && (PwdModifyFlag == 1))
            {
                element.children("li").eq(SystemToolsNum).addClass("hover");
            }
            else if ((jumptomodifypwd == 0) && (0 == LoginDeviceInfoFlag) && (curUserType != sysUserType) && (PwdModifyFlag == 1))
            {
                element.children("li").eq(SystemToolsNum).addClass("hover");
            }
            else if ((jumptomodifypwd == 0) && (0 == LoginDeviceInfoFlag) && (curUserType == sysUserType) && (Ftmodifyowner == 1) && (PwdModifyFlag == 1))
            {
                element.children("li").eq(SystemToolsNum).addClass("hover");
            }
            else
            {
                 element.children("li").eq(0).addClass("hover");
            }

            element.children("li").click(function() {
                if (!element.children("li").eq(this.value).is(".hover")) {
                    if(frame.mainMenuCounter != SystemToolsNum)
                    {
                        element.children("li").eq(SystemToolsNum).removeClass("hover");
                    }

                    element.children("li").eq(frame.mainMenuCounter).removeClass("hover");
                    element.children("li").eq(this.value).addClass("hover");
                    frame.mainMenuCounter = this.value;
                    MenuName = menus[this.value].name;
                    frame.addMenuItems($("#nav ul"), menus[this.value].subMenus, "sub");
                }
            });
        } else if (type == "sub") {
            this.subMenuCounter = 0;
            var subMenuNameMaxLength = 33;
            for (var i = 0, len = menus.length; i < len; i++) {
            
                var subdivname = GetIdByUrl("subdiv", menus[i].url);
                var subliname = GetIdByUrl("subli", menus[i].url);
                var subMenuNameLength = menus[i].name.length;
                if(subMenuNameLength > subMenuNameMaxLength) {
                    element.append('<li value="' + i + '" name="' + subliname +'" title="' + menus[i].name + '"><div name="' + subdivname + '">' + menus[i].name + '</div></li>');
                }
                else{
                    element.append('<li value="' + i + '" name="' + subliname +'" ><div name="' + subdivname + '">' + menus[i].name + '</div></li>');
                }
                if('GLOBE' == CfgMode.toUpperCase())
                {
                    if("Info Page" == menus[i].name)
                    {
                        posDeviceInfo = i;
                    }
                }
                else
                {
                    if("Device Information" == menus[i].name 
                        || "Infor. do dispositivo" == menus[i].name 
                        || "デバイス情報" == menus[i].name 
                        || "Información del dispositivo" == menus[i].name
                        || "Информация устройства" == menus[i].name
                        || "设备信息" == menus[i].name
                        || "Cihaz Bilgisi" == menus[i].name)
                    {
                        posDeviceInfo = i;
                    }
                }
                
                if('TELIALT' == CfgMode.toUpperCase())
                {
                    if("ONT Authentication" == menus[i].name)
                    {
                        PwdAspNum = i;
                    }
                }
                else
                {
                    if(menus[i].name == "Modify Login Password" 
                       || menus[i].name == "Alterar palavra-passe" 
                       || menus[i].name == "ログインパスワードの変更" 
                       || menus[i].name == "Modificar contraseña"
                       || menus[i].name == "Изменение пароля"
                       || menus[i].name == "修改登录密码"
                       || menus[i].name == "Giriş Şifresini Değiştir")
                    {
                        PwdAspNum = i;
                    }
                }
            }
            if (('TELIALT' == CfgMode.toUpperCase()) && (0 == LoginDeviceInfoFlag) && (curUserType != sysUserType) && (PwdModifyFlag == 1))
            {
                element.children("li").eq(PwdAspNum).addClass("hover");
                PwdModifyFlag = 0;
            }
            else if ((jumptomodifypwd == 0) && (0 == LoginDeviceInfoFlag) && (curUserType != sysUserType) && (PwdModifyFlag == 1))
            {
                element.children("li").eq(PwdAspNum).addClass("hover");
                PwdModifyFlag = 0;
            }
            else if ((jumptomodifypwd == 0) && (0 == LoginDeviceInfoFlag) && (curUserType == sysUserType) && (Ftmodifyowner == 1) && (PwdModifyFlag == 1))
            {
                element.children("li").eq(PwdAspNum).addClass("hover");
                PwdModifyFlag = 0;
            }
            else
            {
                element.children("li").eq(frame.subMenuCounter).removeClass("hover");
                element.children("li").eq(posDeviceInfo).addClass("hover");
                frame.subMenuCounter = posDeviceInfo;
                Menu2Path = menus[posDeviceInfo].name;
                frame.setContentPath(menus[posDeviceInfo].url);
            }
            element.children("li").click(function() {
                 if(PwdAspNum != frame.subMenuCounter)
                 {
                     element.children("li").eq(PwdAspNum).removeClass("hover");
                 }

                element.children("li").eq(frame.subMenuCounter).removeClass("hover");
                element.children("li").eq(this.value).addClass("hover");
                frame.subMenuCounter = this.value;

                Menu2Path = menus[this.value].name;
                frame.setContentPath(menus[this.value].url);
            });
        }
    },

    setContentPath : function(url) {
        var msg;
        if (UpgradeFlag == 1)
        {
            if(curLanguage == 'english') {
                msg = 'Note: Upgrade will be interrupted and the device might not boot successfully next time if you switch to another page. It is strongly recommended to press cancel and remain on this page until the upgrade is complete.';
            }else if(curLanguage == 'portuguese') {
                msg = 'Nota: Actualização será interrompida e o dispositivo pode não iniciar com sucesso a próxima vez que mudar para outra página. É altamente recomendável pressionar cancelar e permanecer nesta página até a actualização estar concluída.';
            }else if(curLanguage == 'japanese') {
                msg = '備考: 別のページに切り替えると、アップグレードが中断され、次回デバイスがうまく起動できない可能性があります。 キャンセルを選択し、アップグレードが完了するまでこのページを切り替えないことをお薦めします。';
            }else if(curLanguage == 'spanish') {
                msg = 'Nota: Si decide cambiar de página, la actualización \nse interrumpirá y es posible que el dispositivo no arranque \nla próxima vez. Se recomienda presionar cancelar y permanecer en esta página hasta que se complete la actualización.';
            }else if(curLanguage == 'russian') {
                msg = 'Внимание! При переходе на другую страницу процесс обновления прервется, устройство может некорректно загружаться при следующем включении. Рекомендуется нажать Отмена и не покидать эту страницу до завершения процесса обновления.';
            }else if(curLanguage == 'chinese') {
                msg = '提醒:系统正在升级，离开本页面会导致升级失败。强烈建议您点击\"取消\"，停留在本页面，直到升级成功。';
            }else if(curLanguage == 'turkish') {
                msg = 'Not: Güncelleme sırasında başka bir sayfaya geçiş yapılması durumunda, güncelleme işlemi kesintiye uğrayacak ve cihazın bir sonraki başlatma işleminde sorun yaşanabilecektir. İptal işlemi başlatıldıktan sonra güncelleme tamamlanana kadar sayfada kalınması önemle tavsiye edilmektedir.';
            }

            if(confirm(msg))
            {
                UpgradeFlag = 0;
                this.setMenuPath();
                this.$content.attr("src", url);
            }
        }
        else
        {
            this.setMenuPath();
            this.$content.attr("src", url);
        }
    },

    setContentHeight : function() {
        setInterval(function() {
            try {
                var height = 0;

                if (window.ActiveXObject) {
                    height = document.getElementById("frameContent").contentWindow.document.body.scrollHeight;
                }
                else if (window.XMLHttpRequest) {
                    height = document.getElementById("frameContent").contentWindow.document.body.offsetHeight;
                }
                height = Math.max(height, 690, this.$("#nav li").length * 25);
                $("#center").height(height + 25);
                $("#nav").height(height + 25);
                $("#content").height(height + 25);
                $("#frameWarpContent").height(height);
                $("#frameContent").height(height);
            } catch (e) {

            }
        }, 200);
    },

    setMenuPath : function() {
        $("#topNav #topNavMainMenu").text(MenuName);
        $("#topNav #topNavSubMenu").text(Menu2Path);
    },

    setLogoutElement : function(curLanguage) {
        if(curLanguage == "english")
        {
            $("#headerLogout span").html("Logout");
        }
        else if(curLanguage == "portuguese")
        {
            $("#headerLogout span").html("Terminar sessão");
        }
        else if(curLanguage == "japanese")
        {
            $("#headerLogout span").html("ログアウト");
        }
        else if(curLanguage == "spanish")
        {
            $("#headerLogout span").html("Cerrar sesión");
        }
        else if(curLanguage == "russian")
        {
            $("#headerLogout span").html("Выйти");
        }
        else if(curLanguage == "chinese")
        {
            $("#headerLogout span").html("退出");
        }
        else if(curLanguage == "turkish")
        {
            $("#headerLogout span").html("Çıkış yap");
        }
        var frame = this;

        $("#headerLogout span").mouseover(function() {
            $("#headerLogout span").css({
                "color" : "#990000",
                "text-decoration" : "underline"
            });
        });
        $("#headerLogout span").mouseout(function() {
            $("#headerLogout span").css({
                "color" : "#000000",
                "text-decoration" : "none"
            });
        });
        $("#headerLogout span").click(function() {
            frame.clickLogout();
        });
    },

    setCopyRightInfo : function(language) {
        if (language == "english") {
            if (sonetFlag == 1) {
                $("#footerText").html("All rights reserved. ");
            } else {
                $("#footerText").html("Copyright © 2024 Huawei Technologies Co., Ltd. All rights reserved. ");
            }
        }else if (language == "portuguese") {
            $("#footerText").html("Copyright © 2024 Huawei Technologies Co., Ltd. Todos os direitos reservados. ");
        }else if (language == "japanese") {
            $("#footerText").html("All rights reserved.");
        }else if (language == "spanish") {
            $("#footerText").html("Copyright © 2024 Huawei Technologies Co., Ltd. Todos los derechos reservados. ");
        }else if (language == "russian") {
            $("#footerText").html("Copyright © 2024 Huawei Technologies Co., Ltd. Все права защищены. ");
        }else if (language == "chinese") {
            $("#footerText").html("版权所有 © 2024 华为技术有限公司。保留一切权利。");
        }else if (language == "turkish") {
            $("#footerText").html("Telif Hakkı © Huawei Technologies Co., Ltd. 2024. Tüm hakları saklıdır. ");
        }
    },
    setAppDesInfo : function(language) {
        if (language == "english") {
            $("#appdes").html("Click or scan to download the APP");
        }else if (language == "portuguese") {
            $("#appdes").html("Clique ou digitalize para transferir a aplicação.");
        }else if (language == "japanese") {
            $("#appdes").html("クリックまたはスキャンしてAPPをダウンロードしてください");
        }else if (language == "spanish") {
            $("#appdes").html("Hacer clic en la imagen o escanearla para descargar la APP.");
        }else if (language == "russian") {
            $("#appdes").html("Нажмите или просканируйте, чтобы загрузить приложение");
        }else if (language == "chinese") {
            $("#appdes").html("点击或者扫描下载手机APP");
        }else if (language == "turkish") {
            $("#appdes").html("Uygulamayı indirmek için tıklayın veya taratın");
        }
    },

    clickLogout : function() {
        logoutfunc();
    },
    show : function() {
        var frame = this;
        $(document).ready(function() {
            frame.init();
        });
    },
    showjump : function(hpa,zpa)
    {
        if((productName == 'HG8045') && (curUserType == sysUserType))
        {
            hpa--;
        }
        this.$mainMenu.children("li").eq(this.mainMenuCounter).removeClass("hover");
        this.$mainMenu.children("li").eq(this.menuItems.length-hpa).addClass("hover");
        this.mainMenuCounter=this.menuItems.length-hpa;
        this.addMenuItems($("#nav ul"), this.menuItems[this.menuItems.length-hpa].subMenus, "sub");
        this.$subMenu.children("li").eq(this.subMenuCounter).removeClass("hover");
        this.$subMenu.children("li").eq(zpa).addClass("hover");
        MenuName = this.menuItems[this.menuItems.length-hpa].name;
        Menu2Path = this.menuItems[this.menuItems.length-hpa].subMenus[zpa].name;
        this.setContentPath(this.menuItems[this.menuItems.length-hpa].subMenus[zpa].url);
        this.subMenuCounter=zpa;
    }
};

Frame.show();

