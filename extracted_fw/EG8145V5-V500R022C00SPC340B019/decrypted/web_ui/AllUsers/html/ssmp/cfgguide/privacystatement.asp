<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta name="format-detection" content="telephone=no"/>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ssmpdes.js);%>"></script>



<script language="JavaScript" type="text/javascript">
var IsZQ = "<%HW_WEB_GetFeatureSupport(HW_FEATURE_ZQ);%>";

function LoadFrame()
{

}

function Goback()
{
    window.location="/index.asp";
}

</script>
</head>
<body class="mainbody pageBg" onLoad="LoadFrame();"> 
    <script>
        if (IsZQ == 1) {
            document.write('<div class="func_title" style="text-align: center" BindText="s2036_bpon"></div>');
        } else {
            document.write('<div class="func_title" style="text-align: center" BindText="s2036"></div>');
        }
    </script>
    <table width="100%" border="0" cellpadding="0" cellspacing="0"> 
        <script>
            if (IsZQ == 1) {
                document.write('<tr><td id="title_01" class="table_title" BindText="s2037_bpon"></td></tr>');
                document.write('<tr><td id="title_02" class="table_title" style="font-weight: bold" BindText="s2038_bpon"></td></tr>');
                document.write('<tr><td id="title_03" class="table_title" BindText="s2039_bpon"></td></tr>');
                document.write('<tr><td id="title_04" class="table_title" style="text-align: right"  BindText="s2029_bpon"></td></tr>');
            } else {
                document.write('<tr><td id="title_01" class="table_title" BindText="s2037"></td></tr>');
                document.write('<tr><td id="title_02" class="table_title" style="font-weight: bold" BindText="s2038a"></td></tr>');
                document.write('<tr><td id="title_03" class="table_title" BindText="s2039"></td></tr>');
                document.write('<tr><td id="title_04" class="table_title" style="text-align: right"  BindText="s2029"></td></tr>');
            }
        </script>
    </table> 

    <div class="func_spread"></div>
    <div id="return" style="text-align: right">
        <input type="button" name="btnback" id="btnback" class="CancleButtonCss buttonwidth_100px" onClick="Goback();" BindText="s2035" />
    </div>

    <script>
        ParseBindTextByTagName(CfgguideLgeDes, "div",   1);
        ParseBindTextByTagName(CfgguideLgeDes, "td",    1);
        ParseBindTextByTagName(CfgguideLgeDes, "input", 2);
    </script>
</body>
</html>
