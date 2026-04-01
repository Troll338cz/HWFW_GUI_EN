<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet"  href='../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>' type='text/css'>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>
<script language="JavaScript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(util.js);%>"></script>
<script language="JavaScript" src="../../../resource/<%HW_WEB_Resource(ampdes.html);%>"></script>
<script type="text/javascript" src="../../../resource/common/<%HW_WEB_CleanCache_Resource(jquery.min.js);%>"></script>
<script language="javascript" src="../common/wlan_list.asp"></script>
<script language="javascript" src="../common/wlan_extended.asp"></script>
<script language="javascript" src="wlanadvance_com_api.asp"></script>
<script language="javascript" src="e8cwlanadvance_api.asp"></script>
<title>wireless advance configure</title>
<script>
  var processingState = 0;
  function checkProcessingState() {
      getProcessingState();
      return processingState === '1';
  }

  function getProcessingState() {
      $.ajax({
        type : "POST",
        async : false,
        cache : false,
        url : "getProcessState.asp",
        success : function(data) {
          processingState = data;
        }
      });
  }
</script>
</head>

<body class="mainbody" onLoad="loadFrameWifi();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="prompt">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td class="table_head" width="100%">无线高级配置</td> 
        </tr>
        <tr> 
          <td height="5"></td> 
        </tr>
        <tr>
          <td class="title_common" id='e8CWlanAdvanceTitle'>
          <label id="Title_wlan_advanced_set_lable" class="title_common">
          </label>
          </td>
        </tr>
        <tr>
          <td class="title_common">
            <div>
              <table>
                <tr> 
                  <td class='width_per15 align_left'><img style="margin-bottom:2px" src="../../../images/icon_01.gif" width="15" height="15" /></td> 
                  <td class='width_per85 align_left' BindText="amp_wlan_note1"></td> 
                </tr>
              </table>
            </div>
            <tr>
              <td class="title_common" BindText="amp_wlan_note"></td>
            </tr>
          </td> 
        </tr> 
    
      </table>
    </td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" id="AdvanceConfig" style="display:none">
  <tr><td>
    <form id="ConfigForm" action="../network/set.cgi">

      <div id='wifiCfg'>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
          <tr>
            <td class="table_left width_per25">隐藏无线网络名称:&nbsp;</td>
            <td class="table_right" id="TdHide">
              <input type='checkbox' id='WlanHide_checkbox' name='WlanHide_checkbox' value="OFF"><span class="gray"> </span>
            </td>
          </tr>
  
          <tr id='switchChannel'>
            <td class="table_left width_per25" BindText='amp_wlan_channel'></td>
            <td class="table_right">
              <select id='WlanChannel_select' name='WlanChannel_select' size="1" class="width_150px">
              </select>
            </td>
          </tr>

          <tr id='switchChannelWidth'>
            <td class="table_left width_per25" BindText='amp_channel_width'></td>
            <td class="table_right">
              <select id='WlanBandWidth_select' name='WlanBandWidth_select' size="1" onChange="channelWidthChange()" class="width_150px">
              </select>
              <label id="Title_wlan_dfs_tips_lable" class="title_red" style="display:none">
                <script>
                      document.write("检测到雷达信号，频宽退避为80M频宽");
                </script>
              </label>
            </td>
          </tr>

          <tr id="X_HW_StandardRow" style="display:none">
            <td class="table_left width_per25" BindText='amp_channel_mode'></td>
            <td class="table_right">
              <select id="X_HW_Standard" name="X_HW_Standard" size="1" class="width_150px" onchange="X_HW_StandardChange()">
                <option value="11a">802.11a</option>
                <option value="11na">802.11a/n</option> 
                <option value="11ac">802.11a/n/ac</option>
                <option value="11b">802.11b</option>
                <option value="11g">802.11g</option>
                <option value="11n">802.11n</option>
                <option value="11bg">802.11b/g</option>
                <option value="11bgn" selected>802.11b/g/n</option>
                <option value="11ax">802.11b/g/n/ax</option>
              </select>
            </td>
          </tr>

          <tr>
            <td class="table_left width_per25">802.11保护间隔:&nbsp;</td>
            <td class="table_right">
              <select id="WlanInterval_select" name="WlanInterval_select" size="1" class="width_150px">
                <option value="800nsec"> 长</option>
                <option value="400nsec"> 短</option>
              </select>
            </td>
          </tr>

          <tr id="wlPutOutPower">
            <td class="table_left width_per25">发射功率:&nbsp;</td>
            <td class="table_right"> 
              <select id='WlanTransmit_select' name='WlanTransmit_select' class='width_150px'>
                <option value='100'> 100% </option>
                <option value='80'> 80% </option>
                <option value='60'> 60% </option>
                <option value='40'> 40% </option>
                <option value='20'> 20% </option>
              </select>
            </td>
         </tr>
         
         <tr id="powerStrenthMode" style="display:none;">
            <td class="table_left width_per25">
                <script>document.write(cfg_wlancfgadvance_language['amp_wallmode']);</script>
            </td>
            <td class="table_right"> 
              <select id='wallMode_select' name='wallMode_select' class='width_150px' onChange="WallModeChange();">
                <option value='0'><script>document.write(cfg_wlancfgadvance_language['amp_wallmode_standard']);</script></option>
                <option value='1'><script>document.write(cfg_wlancfgadvance_language['amp_wallmode_throughwall']);</script></option>
              </select>
            </td>
         </tr>
  
        </table>

        <div id="div_wds_config" style="display:none">
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
            <tr id="wds_config">
              <td class="table_left width_per25" BindText='amp_wds_enable'></td>
              <td class="table_left width_per75">
                <input type='checkbox' id='wds_enable' name='wds_enable' class="table_left" onClick='wdsClickFunc();'>
                <span class="gray"><script>document.write(cfg_wlancfgadvance_language['amp_wds_notes']);</script></span>
              </td>
            </tr>
          </table>

          <div id='div_wds_mac'>	  
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tabal_bg">
              <tr id="wds_master">
                <td class="table_left width_per25"></td>
                <td class="table_left width_per20">WDS <script>document.write(cfg_wlancfgadvance_language['amp_wds_address_label']);</script></td>
                <td id='X_HW_WlanMac' class="table_left width_per55"></td>
              </tr>

              <tr id="wds_ap1">
                <td class="table_left width_per25"></td>
                <td class="table_left width_per20">AP1 <script>document.write(cfg_wlancfgadvance_language['amp_wds_address_label']);</script></td>
                <td class="table_left width_per55">
                  <input type='text' id='wds_text_ap1' name='wds_text_ap1' size='10' class="width_150px">
                  <span class="gray"><script>document.write(cfg_wlancfgadvance_language['amp_wds_address_demo']);</script></span>
                </td>
              </tr>

              <tr id="wds_ap2">
                <td class="table_left width_per25"></td>
                <td class="table_left width_per20">AP2 <script>document.write(cfg_wlancfgadvance_language['amp_wds_address_label']);</script></td>
                <td class="table_left width_per55">
                  <input type='text' id='wds_text_ap2' name='wds_text_ap2' size='10' class="width_150px">
                  <span class="gray"><script>document.write(cfg_wlancfgadvance_language['amp_wds_address_demo']);</script></span>
                </td>
              </tr>

              <tr id="wds_ap3">
                <td class="table_left width_per25"></td>
                <td class="table_left width_per20">AP3 <script>document.write(cfg_wlancfgadvance_language['amp_wds_address_label']);</script></td>
                <td class="table_left width_per55">
                  <input type='text' id='wds_text_ap3' name='wds_text_ap3' size='10' class="width_150px">
                  <span class="gray"><script>document.write(cfg_wlancfgadvance_language['amp_wds_address_demo']);</script></span>
                </td>
              </tr>

              <tr id="wds_ap4">
                <td class="table_left width_per25"></td>
                <td class="table_left width_per20">AP4 <script>document.write(cfg_wlancfgadvance_language['amp_wds_address_label']);</script></td>
                <td class="table_left width_per55">
                  <input type='text' id='wds_text_ap4' name='wds_text_ap4' size='10' class="width_150px">
                  <span class="gray"><script>document.write(cfg_wlancfgadvance_language['amp_wds_address_demo']);</script></span>
                </td>
              </tr>

            </table>
          </div>
        </div>

        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr><td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_button">
              <tr align="right">
                <td class="table_submit width_per25"></td>
                <td class="table_submit"> 
                  <input type="hidden" name="onttoken" id="hwonttoken" value="<%HW_WEB_GetToken();%>">
                  <button id="Save_button" name="Save_button" type="button" class="submit" onClick="Submit();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_sure']);</script></button>
                  <button id="Cancel_button" name="Cancel_button" type="button" class="submit" onClick="cancelConfig();"><script>document.write(cfg_wlancfgother_language['amp_wlancfg_cancel']);</script></button>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
  
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr><td class="width_10px"></td></tr>
      </table> 
    </div>
  
  </form>
</td></tr>
</table>

</body>
</html>
