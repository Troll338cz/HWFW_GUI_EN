<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<title>设备信息帮助</title>
</head>
<body class="mainbody">
    <blockquote>
        <p>
            <b>设备基本信息</b>
            <p>显示设备型号，设备标识号，硬件版本，软件版本等信息。</p>
        </p>
        <script type="text/javascript">
            var BjunicomFeature = '<%HW_WEB_GetFeatureSupport(BBSP_FT_BJUNICOM);%>';
            if (BjunicomFeature == "1")
            {
                document.write('<p><b>注册信息</b><p>显示业务开通状态。</p></p>');
            }
        </script>
    </blockquote>
</body>
</html>

