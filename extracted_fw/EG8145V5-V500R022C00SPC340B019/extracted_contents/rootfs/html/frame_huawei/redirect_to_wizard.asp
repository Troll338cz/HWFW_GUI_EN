<script>
    var br0Ip = '<%HW_WEB_GetBr0IPString();%>';
    var isRosUnion = '<%HW_WEB_GetFeatureSupport(FT_ROS_UNION);%>'
    var httpport = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.Services.X_HW_WebServerConfig.ListenInnerPort);%>';
    var redirectAsp = "/ros_setup_wizard.asp";
    if (isRosUnion == '1') {
        redirectAsp = "/rosunion_setup_wizard.asp";
    }
    window.location.href="http://" + br0Ip + ":" + httpport + redirectAsp;
</script>