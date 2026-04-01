<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="../../../resource/common/<%HW_WEB_CleanCache_Resource(style.css);%>" type="text/css"/>
<link rel="stylesheet"  href='../../../Cuscss/<%HW_WEB_GetCusSource(frame.css);%>' type='text/css'>

<title>路由配置帮助</title>
</head>
<body class="mainbody">
<blockquote>
<b>IPv4默认路由</b></p>
  <p> 在IPv4默认路由页面，可以配置通过终端的IPv4数据包默认选择哪个WAN接口。 
  <p><br>
  <b>IPv4静态路由</b></p>
  <p> 在IPv4静态路由页面，可以配置特定IP的IPv4数据包选择哪个WAN接口。
  <p><b>WAN名称：</b>数据包通过终端时选择的WAN接口。<br />
    <b> IP地址/域名：</b>数据包到达的IP地址或域名。<br />
	<b>网关：</b>数据包将通过的网关。<br />
	<b>子网掩码:</b>数据包到达的IP地址对应的子网掩码。<br />
  <p>  
  <p><br>
    <b>IPv4策略路由</b>
  <p> 在IPv4策略路由页面，可以配置ONT的IPv4策略路由。 
  <p><b>厂商标识：</b>设备的Vendor ID。<br />
  <b>WAN名称：</b>带厂商标识的数据包通过终端时选择的WAN接口。<br>
  <p>  
  <p><br>
  <b>VLAN绑定</b></p>
  <p> 在VLAN绑定页面，可以进行VLAN绑定的操作。
  <p><b>端口：</b>进行VLAN绑定的端口，包括以太口和WiFi端口。<br />
  <b>绑定模式：</b>区分绑定模式是端口绑定，还是VLAN-WAN绑定。<br>
  <b>绑定VLAN对：</b>当为VLAN-WAN绑定时有效。配置VLAN-WAN绑定后，带User VLAN的报文可以通过对应WAN VLAN的WAN口出去。<br>
  <p>  
  <p><br>
  <b>IPv6默认路由</b></p>
  <p> 在IPv6默认路由页面，可以配置通过终端的IPv6数据包默认选择哪个WAN接口。 
  <p><br>
  <b>IPv6静态路由</b></p>
  <p> 在IPv6静态路由页面，可以配置特定IP的IPv6数据包选择哪个WAN接口。
  <p><b>WAN名称：</b>数据包通过终端时选择的WAN接口。<br />
    <b> 目的IP前缀：</b>目的IP子网在IP地址前段所占的位数。<br />
	<b>下一跳：</b>数据包传输的下一个网关的ip地址。<br />
  <p><br />
</blockquote>
</body>
</html>

