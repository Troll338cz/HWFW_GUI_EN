function stXDevInfo(domain, RegistrationID,MutualAuthSwitch,PreSharedKey)
{
	this.RegistrationID = RegistrationID;
	this.MutualAuthSwitch = MutualAuthSwitch;
	this.PreSharedKey = PreSharedKey;
}

var stXDevInfos = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.X_HW_XgponDeviceInfo, RegistrationID|MutualAuthSwitch|PreSharedKey, stXDevInfo);%>;
stXDevInfos = stXDevInfos[0];

var xgponregisterid = stXDevInfos.RegistrationID;
var xgponmutualauthswitch = stXDevInfos.MutualAuthSwitch;
var xgponpsk = stXDevInfos.PreSharedKey;

function xgpon_init()
{
	if (('<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_10GPON);%>' != '1') || (1 != stDevinfo.devtype))
	{
		return;
	}

	setText("RegisterId", xgponregisterid);
	setText("tRegisterId", xgponregisterid);
	setText("Psk", xgponpsk);
	setText("tPsk", xgponpsk);
	setCheck("MutualAuth", xgponmutualauthswitch);
	setDisplay("TrPasswordGpon", 0);
	setDisplay("TrPasswordmode", 0);
    setDisplay("TrHexPassword",0);	
	
	if (1 == getRadioVal("rMethod"))
	{
		setDisplay("TrPSK", 0);
		setDisplay("TrRegisterId", 0);
		setDisplay("TrMutualAuth", 0);
		return;
	}

	if (0 == '<%HW_WEB_GetFeatureSupport(FT_FEATURE_SINGTEL);%>')
	{
		setDisplay("TrMutualAuth", 1);
	}
	
	if (1 == xgponmutualauthswitch)
	{
		setDisplay("TrPSK", 1);
		setDisplay("TrRegisterId", 0);
	}
	else
	{
		setDisplay("TrPSK", 0);
		setDisplay("TrRegisterId", 1);
	}
	
	if  ((isOntOnline == 1) && (curUserType != sysUserType))	
	{
		setDisable("RegisterId", 1);
		setDisable("tRegisterId", 1);
		setDisable("Psk", 1);
		setDisable("tPsk", 1);
	}

}

function onMutualAuthSwitch()
{
	if (1 == getCheckVal("MutualAuth"))
	{
		setDisplay("TrRegisterId", 0);
		setDisplay("TrPSK", 1);
	}
	else
	{
		setDisplay("TrRegisterId", 1);
		setDisplay("TrPSK", 0);
	}
	
	xgponmutualauthswitch = getCheckVal("MutualAuth");
}

function checkxgponinfo()
{
	var ret = CheckStr("RegisterId", xgponregisterid, 0, 36);
	
	if (false == ret)
	{
		return false;
	}
	
	ret = CheckStr("Psk", xgponpsk, 0, 16);
	
	return ret;
}

function AddXgponForm(Form, requestfile)
{
	if (('<%HW_WEB_GetFeatureSupport(HW_AMP_FEATURE_10GPON);%>' != '1') || (1 != stDevinfo.devtype))
	{
		return;
	}
	
	Form.addParameter("y.RegistrationID", getValue('RegisterId'));
	Form.addParameter("y.MutualAuthSwitch", xgponmutualauthswitch);
	Form.addParameter("y.PreSharedKey", getValue('Psk'));

	Form.setAction('set.cgi?' +'x=InternetGatewayDevice.DeviceInfo&y=InternetGatewayDevice.X_HW_XgponDeviceInfo' 
						+ '&RequestFile=' + requestfile);
}
