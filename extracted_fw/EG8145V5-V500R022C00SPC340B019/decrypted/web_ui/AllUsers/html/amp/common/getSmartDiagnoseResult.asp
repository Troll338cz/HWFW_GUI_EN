function() {
  function stLinkStatus(domain, status)
  {
      this.domain = domain;
      this.Status = status;    
  }
  
  function pwdBandSecurityStatus(domain, PWD_2G_Security, PWD_5G_Security)
  {
      this.domain = domain;
      this.PWD_2G_Security = PWD_2G_Security;
      this.PWD_5G_Security = PWD_5G_Security;    
  }
  
  function getResult()
  {
      var wifiPwdSecurity = '';
      
      var flag = '<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_WLAN);%>';
      if(flag == 1)
      {
          wifiPwdSecurity = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.WifiPwdSecurity.Security);%>';
      }
      else
      {
          wifiPwdSecurity = 'high';
      }
      
      
      var opticInfo = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.Optic.RxPower);%>';
      
      var ontPonMode = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.AccessModeDisp.AccessMode);%>';
      var gponStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.AMP.ONT.State);%>';
      var eponStatus = '<%HW_WEB_GetParaByDomainName(InternetGatewayDevice.X_HW_DEBUG.OAM.ONT.State);%>';
      var regStatus = '';
      
      if(opticInfo == "--" || opticInfo == "")
      { 
          opticInfo = "nok";
      }
      else
      {
          opticInfo = "ok";
      }
      
      if (ontPonMode.toUpperCase() == 'GPON')
      {
          if (gponStatus.toUpperCase() == 'O5')
          {
              regStatus = 'ok';
          }
          else
          {
              regStatus = 'nok';
          }
      }
      else if (ontPonMode.toUpperCase() == 'EPON')
      {
          if (eponStatus.toUpperCase() =="ONLINE" )
          {
              regStatus = 'ok';
          }
          else
          {
              regStatus = 'nok';
          }
      }
      else
      {
          regStatus = 'nok';
      }
      
      var obj = new Object();
      
      var ProductType = '<%HW_WEB_GetProductType();%>';
      if (ProductType == '2')
      {
          var dslLinkStatus = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANDSLInterfaceConfig, Status, stLinkStatus);%>;
          var ethLinkStatus = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.WANDevice.{i}.WANEthernetInterfaceConfig, Status, stLinkStatus);%>;
      
          /* Up,Linking,NoSignal */
          for (var i=0; i<dslLinkStatus.length; i++)
          {
              if (dslLinkStatus[i] == null)
                  continue;
              switch (dslLinkStatus[i].Status)
              {
                  case "Up":
                      obj.dslLinkStatus = "Up";
                      break;
                  case "Initializing":
                  case "EstablishingLink":
                      obj.dslLinkStatus = "Linking";
                      break;
                  case "NoSignal":
                  default:
                      obj.dslLinkStatus = "NoSignal";
                      break;
              }
              break;
          }
  
          /* Up,NoLink,Error,Disabled */
          for (var i=0; i<ethLinkStatus.length; i++)
          {
              if (ethLinkStatus[i] == null)
                  continue;
  
              obj.ethLinkStatus = ethLinkStatus[i].Status;
              break;
          }
          
      if (flag == 1)
      {
        var bandWifiPwdSecurity = '';
        bandWifiPwdSecurity = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.WifiBandPWDSecurity, PWD_2G_Security|PWD_5G_Security, pwdBandSecurityStatus);%>;
        bandWifiPwdSecurity = bandWifiPwdSecurity[0];
        obj.PWD_2G_Security = bandWifiPwdSecurity.PWD_2G_Security;
        obj.PWD_5G_Security = bandWifiPwdSecurity.PWD_5G_Security;
      }
      else
      {
        obj.PWD_2G_Security = 'high';
        obj.PWD_5G_Security = 'high';
      }
      } else {
          if (flag == 1) {
              var bandWifiPwdSecurity = '';
              bandWifiPwdSecurity = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_DEBUG.AMP.WifiBandPWDSecurity, PWD_2G_Security|PWD_5G_Security, pwdBandSecurityStatus);%>;
              bandWifiPwdSecurity = bandWifiPwdSecurity[0];
              obj.PWD_2G_Security = bandWifiPwdSecurity.PWD_2G_Security;
              obj.PWD_5G_Security = bandWifiPwdSecurity.PWD_5G_Security;
          } else {
              obj.PWD_2G_Security = 'high';
              obj.PWD_5G_Security = 'high';
          }
      }
      
      obj.wifiPwdSecurity = wifiPwdSecurity;
      obj.opticInfo = opticInfo;
      obj.regStatus = regStatus;
      
      return obj;
  }
  
  return getResult();
}
