var sysUserType = '0';
var curUserType = '<%HW_WEB_GetUserType();%>';
var DBAA1 = "<%HW_WEB_GetFeatureSupport(HW_SSMP_FEATRUE_DBAA1);%>";
var dbaa1SuperSysUserType = '2';

function IsAdminUser()
{
    if (DBAA1 == '1') {
        return curUserType == dbaa1SuperSysUserType;
    }
    return curUserType == sysUserType;
}