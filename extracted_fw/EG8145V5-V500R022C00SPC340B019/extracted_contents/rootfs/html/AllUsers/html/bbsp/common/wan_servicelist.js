function CleanServiceListVoip()
{
    var ServiceList = document.getElementById("ServiceList");
    var Length = ServiceList.options.length;
	var ProductName = GetProductName();
	
		if ((ProductName != 'HG8045') && (ProductName != 'HG8045A2') && (ProductName != 'HG8010') && (ProductName != 'HG8040') && (ProductName != 'HG8045A') && (ProductName != 'HG8045H') && (ProductName != 'HG8045D') && (ProductName != 'HG8021H')
		 && (IsSupportVoice != '0'))
	{
		return true;
	}
	
    for (var i = Length; i >=0; i--)
    {
        try
        {
            var Child = ServiceList.options[i];
            if (Child == undefined)
            {
               continue;
            }

      if ((Child.value.toString().toUpperCase().indexOf('VOIP') >= 0) && ((selctIndex == -1) ||
        (CfgModeWord.toUpperCase() == 'ELISAAP')))
      {
        ServiceList.remove(i);        
      }
        }
        catch(ex)
        {
        }
    }
}

function RemoveAllFromSelectByKey(objSelect, objItemKey) 
{             
	for (var i = objSelect.options.length -1 ; i >= 0; i--) 
	{  
		if(objSelect.options[i].value.indexOf(objItemKey) >= 0 )  
		{ 
            objSelect.options[i]=null;            
        }     
    }
}

function RemoveItemFromSelect(objSelect, objItemValue) 
{             
    for (var i = 0; i < objSelect.options.length; i++) 
	{  
	
		if(objSelect.options[i].value == objItemValue) 
		{        
            objSelect.options[i]=null;         
            break;        
        }     
  }
}

function ClearIPTVAndOtherService()
{
	if(0== ROSTelecomFeature)
	{
		return ;
	}
	var svrlist = getElementById("ServiceList");
	RemoveAllFromSelectByKey(svrlist,Languages['IPTV']);
	RemoveAllFromSelectByKey(svrlist,Languages['OTHER']);
}

function ClearOtherService()
{	
	if(("TELMEX2WIFI" == CfgModeWord.toUpperCase())&&(IsXdProduct()))
	{
		var svrlist = getElementById("ServiceList");
		RemoveAllFromSelectByKey(svrlist , Languages['OTHER']);
	}
}

function CleanServiceListTR069()
{	
	if(APAutoUPPortFlag == 1)
	{
		var svrlist = getElementById("ServiceList");
		RemoveItemFromSelect(svrlist , Languages['TR069']);
		RemoveItemFromSelect(svrlist , Languages['TR069_INTERNET']);
		RemoveItemFromSelect(svrlist , Languages['TR069_VOIP_INTERNET']);
		RemoveItemFromSelect(svrlist , Languages['TR069_VOIP']);
		RemoveItemFromSelect(svrlist , Languages['TR069_IPTV']);
		RemoveItemFromSelect(svrlist , Languages['TR069_VOIP_IPTV']);
		RemoveItemFromSelect(svrlist , Languages['TR069_VOIP_IPTV_INTERNET']); 
		RemoveItemFromSelect(svrlist , Languages['IPTV']);
		RemoveItemFromSelect(svrlist , Languages['OTHER']);
		RemoveItemFromSelect(svrlist , Languages['IPTV_INTERNET']);
    if (CfgModeWord.toUpperCase() == 'ELISAAP') {
      RemoveItemFromSelect(svrlist , Languages['INTERNET']);
    } else {
      RemoveItemFromSelect(svrlist , Languages['TR069_IPTV_INTERNET']);
    }
	}
}

function innerControlsvrlist()
{
	var svrlist = getElementById("ServiceList");
	var Wan = GetCurrentWan();
	
	svrlist.options.length = 0;
  if (typeof typeWord == 'undefined') {
    var typeWord = '';
  }

	if ((IsAdminUser() == false) && (CfgModeWord.toUpperCase() == 'ROSUNION')) {
		svrlist.options.length = 0;
		svrlist.options.add(new Option(Languages['INTERNET'],Languages['INTERNET']));
		RemoveItemFromSelect(svrlist , GetCurrentWan().ServiceList.toString().toUpperCase());
		svrlist.options.add(new Option(GetCurrentWan().ServiceList.toString().toUpperCase(), GetCurrentWan().ServiceList.toString().toUpperCase()));
		svrlist.value = Wan.ServiceList.toString().toUpperCase();
		return;
	}

	svrlist.options.add(new Option(Languages['TR069'],Languages['TR069']));
	if (exchangeWan == "1") {
		svrlist.options.add(new Option(Languages['eRouter'],Languages['INTERNET']));
	} else {
		svrlist.options.add(new Option(Languages['INTERNET'], 'INTERNET'));
	}
	svrlist.options.add(new Option(Languages['TR069_INTERNET'],Languages['TR069_INTERNET']));
	var svrSupportVoip = (('E8C' == CurrentBin.toUpperCase()) || (CUVoiceFeature == "1"));
	if(svrSupportVoip) {
		svrlist.options.add(new Option("VOICE",Languages['VOIP']));
		svrlist.options.add(new Option("TR069_VOICE",Languages['TR069_VOIP']));
		svrlist.options.add(new Option("VOICE_INTERNET",Languages['VOIP_INTERNET']));
		svrlist.options.add(new Option("TR069_VOICE_INTERNET",Languages['TR069_VOIP_INTERNET']));
	} else {
		if (exchangeWan == "1") {
			svrlist.options.add(new Option(Languages['eMTA'],Languages['VOIP']));
		} else {
			svrlist.options.add(new Option(Languages['VOIP'],Languages['VOIP']));
		}
		svrlist.options.add(new Option(Languages['TR069_VOIP'],Languages['TR069_VOIP']));
		svrlist.options.add(new Option(Languages['VOIP_INTERNET'],Languages['VOIP_INTERNET']));
		svrlist.options.add(new Option(Languages['TR069_VOIP_INTERNET'],Languages['TR069_VOIP_INTERNET']));
		svrlist.options.add(new Option(Languages['IPTV_INTERNET'],Languages['IPTV_INTERNET']));
		svrlist.options.add(new Option(Languages['VOIP_IPTV_INTERNET'],Languages['VOIP_IPTV_INTERNET']));
		svrlist.options.add(new Option(Languages['TR069_IPTV_INTERNET'],Languages['TR069_IPTV_INTERNET']));
		svrlist.options.add(new Option(Languages['TR069_VOIP_IPTV_INTERNET'],Languages['TR069_VOIP_IPTV_INTERNET']));
	}
	if(!IsE8cFrame()) {
		svrlist.options.add(new Option(Languages['IPTV'],Languages['IPTV']));
	}
	svrlist.options.add(new Option(Languages['OTHER'], 'OTHER'));

  if (checkHon()) {
    svrlist.options.add(new Option(Languages['HON'],Languages['HON']));
  }

  if (EditFlag.toUpperCase() != "ADD") {
    svrlist.options.add(new Option(Languages['CAPWAP'], Languages['CAPWAP']));
  }
	
	if ("NOS2" == CfgModeWord.toUpperCase())
	{
		 svrlist.options.add(new Option(Languages['SPECIAL_SERVICE_1'],Languages['SPECIAL_SERVICE_1']));
		 svrlist.options.add(new Option(Languages['SPECIAL_SERVICE_2'],Languages['SPECIAL_SERVICE_2']));
		 svrlist.options.add(new Option(Languages['SPECIAL_SERVICE_3'],Languages['SPECIAL_SERVICE_3']));
		 svrlist.options.add(new Option(Languages['SPECIAL_SERVICE_4'],Languages['SPECIAL_SERVICE_4']));	
	}

  if (isUnicomNetworkExpress == '1') {
    svrlist.options.add(new Option(Languages['HQoS'],Languages['HQoS']));
    svrlist.options.add(new Option(Languages['D_Bus'],Languages['D_Bus']));
  }


	svrlist.value = Languages['INTERNET'] ;
	
	if((getValue('WanMode').toString().toUpperCase().indexOf("ROUTED") >= 0))
	{
		if(("TELMEXACCESS" == CfgModeWord.toUpperCase() || "TELMEXACCESSNV" == CfgModeWord.toUpperCase()) &&(EditFlag.toUpperCase() == "ADD"))
		{
			svrlist.value = Languages['TR069_VOIP_INTERNET'];
			Wan.ServiceList = "TR069_VOIP_INTERNET";
		}
		if(("TELMEXRESALE" == CfgModeWord.toUpperCase()) &&(EditFlag.toUpperCase() == "ADD"))
		{
			svrlist.value = Languages['TR069_VOIP_INTERNET'];
			Wan.ServiceList = "TR069_VOIP_INTERNET";
		}
		if((("TELMEXRESALE" == CfgModeWord.toUpperCase()) || ("TELMEXACCESS" == CfgModeWord.toUpperCase()) || ("TELMEXACCESSNV" == CfgModeWord.toUpperCase()) ) &&(EditFlag.toUpperCase() == "EDIT"))
		{
			if( -1 != selctIndex)
			{
				Wan.ServiceList = GetWanList()[selctIndex].ServiceList;
			}
		}
	}

	if(getValue('WanMode').toString().toUpperCase().indexOf("BRIDGED") >= 0)
	{
		svrlist.options.length = 0;
    if ((tedataGuide == 1) && (typeWord == 'PWD')) {
      svrlist.options.add(new Option(Languages['INTERNET'],Languages['INTERNET']));
      svrlist.options.add(new Option(Languages['IPTV'],Languages['IPTV']));
    } else { 
		if ((CfgModeWord.toUpperCase() != 'JLCU' && CfgModeWord.toUpperCase() != 'JLCUHG8321R')) {
			svrlist.options.add(new Option(Languages['INTERNET'],Languages['INTERNET']));
		}
		if(!IsE8cFrame())
		{
			svrlist.options.add(new Option(Languages['IPTV'],Languages['IPTV']));
		}
		svrlist.options.add(new Option(Languages['OTHER'],Languages['OTHER']));
    }
		var PriorityPolicy = (Wan.EnableVlan == "1") ? Wan.PriorityPolicy:"Specified";
		if(PriorityPolicy.toUpperCase() == "DSCPTOPBIT")
	    {
			setSelect('PriorityPolicy', 'Specified');
		}
		
		switch(GetCurrentWan().ServiceList.toString().toUpperCase()) 
		{
			case Languages['INTERNET']:
			case Languages['OTHER']:
			case Languages['IPTV']:
				svrlist.value = GetCurrentWan().ServiceList.toString().toUpperCase();
				break;
			default:
				if ((1 == MngtShct || CUVoiceFeature == "1") && (EditFlag.toUpperCase() != "ADD"))
				{
					var servalue = GetCurrentWan().ServiceList.toString().toUpperCase();
					if(servalue == Languages['TR069_VOIP'])
					{
						svrlist.options.add(new Option("TR069_VOICE","TR069_VOIP"));
						setSelect("ServiceList","TR069_VOIP");
					}
					else if(servalue == Languages['VOIP'])
					{
						svrlist.options.add(new Option("VOICE","VOIP"));
						setSelect("ServiceList","VOIP");
					}
					else if(servalue == Languages['VOIP_INTERNET'])
					{
						svrlist.options.add(new Option("VOICE_INTERNET","VOIP_INTERNET"));
						setSelect("ServiceList","VOIP_INTERNET");
					}
					else if(servalue == Languages['TR069_VOIP_INTERNET'])
					{
						svrlist.options.add(new Option("TR069_VOICE_INTERNET","TR069_VOIP_INTERNET"));
						setSelect("ServiceList","TR069_VOIP_INTERNET");
					}
					else if(servalue == Languages['VOIP_IPTV'])
					{
						svrlist.options.add(new Option("VOICE_IPTV","VOIP_IPTV"));
						setSelect("ServiceList","VOIP_IPTV");
					}
					else if(servalue == Languages['TR069_VOIP_IPTV'])
					{
						svrlist.options.add(new Option("TR069_VOICE_IPTV","TR069_VOIP_IPTV"));
						setSelect("ServiceList","TR069_VOIP_IPTV");
					}
					else
					{
                        svrlist.options.add(new Option(GetCurrentWan().ServiceList.toString().toUpperCase(), GetCurrentWan().ServiceList.toString().toUpperCase()));
                        svrlist.value = GetCurrentWan().ServiceList.toString().toUpperCase();				
					}
				}
				else
				{
					if("TELMEXACCESS" == CfgModeWord.toUpperCase() || "TELMEXACCESSNV" == CfgModeWord.toUpperCase())
					{
						svrlist.value = Languages['INTERNET'];
					}
					else if( "TELMEXRESALE" == CfgModeWord.toUpperCase())
					{
						svrlist.value = Languages['INTERNET'];
					}
					else
					{
						if((EditFlag.toUpperCase() == "ADD") && ((Wan.ServiceList == 'INTERNET') || (Wan.ServiceList == 'IPTV') || (Wan.ServiceList == 'OTHER'))
							|| (EditFlag.toUpperCase() != "ADD"))
						{
							svrlist.options.add(new Option(GetCurrentWan().ServiceList.toString().toUpperCase(), GetCurrentWan().ServiceList.toString().toUpperCase()));
							svrlist.value = GetCurrentWan().ServiceList.toString().toUpperCase();
						}
					}
				}
				break;
		}
		
	    	if( SingtelModeEX == 1)
		{
			RemoveItemFromSelect(svrlist , Languages['IPTV']);
		}
		
		if (IsSupportBridgeWan == 1)
		{
			RemoveItemFromSelect(svrlist , Languages['IPTV']);
			RemoveItemFromSelect(svrlist , Languages['OTHER']);
		}
		
		return ;
	}

	if ((bin4board_nonvoice() == true)&&(selctIndex == -1))
	{
		RemoveAllFromSelectByKey(svrlist , Languages['VOIP']);
	}

	if(((bin5board() == true) || ("1" == FtBin5Enhanced) || (IsSupportBridgeWan == 1)) && (EditFlag.toUpperCase() == "ADD")) 
	{
		RemoveItemFromSelect(svrlist , Languages['INTERNET']);
		RemoveItemFromSelect(svrlist , Languages['TR069_INTERNET']);
		RemoveItemFromSelect(svrlist , Languages['VOIP_INTERNET']);
		RemoveItemFromSelect(svrlist , Languages['TR069_VOIP_INTERNET']);
		RemoveItemFromSelect(svrlist , Languages['IPTV']);
		RemoveItemFromSelect(svrlist , Languages['OTHER']);
		RemoveItemFromSelect(svrlist , Languages['IPTV_INTERNET']);
		RemoveItemFromSelect(svrlist , Languages['VOIP_IPTV_INTERNET']);
		RemoveItemFromSelect(svrlist , Languages['TR069_IPTV_INTERNET']);
		RemoveItemFromSelect(svrlist , Languages['TR069_VOIP_IPTV_INTERNET']);
		if (IsSupportBridgeWan == 1)
		{
			RemoveItemFromSelect(svrlist , Languages['TR069_VOIP']);
			RemoveItemFromSelect(svrlist , Languages['VOIP']);
		}
		
		if(Wan.ServiceList.toString().toUpperCase()=='INTERNET')
		{
		    svrlist.value=Languages['TR069'];
   			Wan.ServiceList = "TR069";
		}
		else
		{
		    svrlist.value=Languages[Wan.ServiceList.toString().toUpperCase()];
		}
		
		CleanServiceListVoip();
		return;
	}
	
	if(!IsE8cFrame())
	{
		if(CUVoiceFeature == "1")
		{
			svrlist.options.add(new Option("VOICE_IPTV","VOIP_IPTV"));
			svrlist.options.add(new Option("TR069_IPTV","TR069_IPTV"));
			svrlist.options.add(new Option("TR069_VOICE_IPTV","TR069_VOIP_IPTV"));
		}
		else
		{
      if (!((tedataGuide == 1) && (typeWord == 'PWD'))) {
			svrlist.options.add(new Option(Languages['VOIP_IPTV'],Languages['VOIP_IPTV']));
			if (exchangeWan == "1") {
				svrlist.options.add(new Option(Languages['eSTB'],Languages['TR069_IPTV']));
			} else {
				svrlist.options.add(new Option(Languages['TR069_IPTV'],Languages['TR069_IPTV']));
			}
			svrlist.options.add(new Option(Languages['TR069_VOIP_IPTV'],Languages['TR069_VOIP_IPTV']));
      }
		}
    if (isUnicomNetworkExpress == '1') {
      svrlist.value = Wan.ServiceList.toString();
    } else {
      svrlist.value = Wan.ServiceList.toString().toUpperCase();    
    }
		
		CleanServiceListVoip();

		if( SingtelModeEX == 1)
		{
		    RemoveAllFromSelectByKey(svrlist , Languages['VOIP']);
	            RemoveAllFromSelectByKey(svrlist , Languages['IPTV']);
		}
		return;
	}
	else
	{   
	    svrlist.value = Wan.ServiceList.toString().toUpperCase();
	    CleanServiceListVoip();
	    return;
	}
}

function removeSelectItem(objSelect, objItemValue) {
  for (var i = 0; i < objSelect.options.length; i++) {
    if(objSelect.options[i].value === objItemValue) {
      objSelect.options[i] = null;
      return;
    }
  }
}

function clrOthServList() {
  if (CfgModeWord.toUpperCase() !== 'DTEDATA2WIFI') {
    return;
  }
  var svrlist = getElementById('ServiceList');
  if (getValue('WanMode').toString().toUpperCase().indexOf('ROUTED') >= 0) {
    removeSelectItem(svrlist , Languages['TR069']);
    removeSelectItem(svrlist , Languages['INTERNET']);
    removeSelectItem(svrlist , Languages['TR069_IPTV_INTERNET']);
    removeSelectItem(svrlist , Languages['TR069_IPTV']);
    removeSelectItem(svrlist , Languages['IPTV']);
    removeSelectItem(svrlist , Languages['IPTV_INTERNET']);
  } else {
    removeSelectItem(svrlist , Languages['OTHER']);
  }
}

function Controlsvrlist()
{
	innerControlsvrlist();
	ClearIPTVAndOtherService();
	ClearOtherService();
	CleanServiceListTR069();
		var Wan = GetCurrentWan();
		var src = getElementById('ServiceList');
	
	if((IPV4V6Flag == 1) && (ChangeUISource == src) && (EditFlag == "ADD"))
	{
		if((getValue('WanMode').toString().toUpperCase().indexOf("ROUTE") >= 0) && (Wan.ServiceList.toString().toUpperCase().indexOf("INTERNET") >=0))
		{
			Wan.ProtocolType = "IPv4/IPv6";
			Wan.IPv4Enable = "1";
			Wan.IPv6Enable = "1";
			setSelect("ProtocolType","IPv4/IPv6");
		}
	}
  clrOthServList();
}