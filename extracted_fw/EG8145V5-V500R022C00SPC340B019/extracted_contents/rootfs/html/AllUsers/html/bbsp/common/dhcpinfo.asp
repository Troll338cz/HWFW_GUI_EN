
function checkLease(fieldPrompt,LeaseTime,Frag,resourceLangDes)
{
       var errmsg="";
       var field="";
       
       field=resourceLangDes[fieldPrompt];
       errmsg=new Array("bbsp_lease_invalid","bbsp_lease_num","bbsp_lease_outrange");
       
       if (LeaseTime == '')
       {
           AlertEx(field+resourceLangDes[errmsg[0]]);
           return false;
       }
   
      	if(!isInteger(LeaseTime) )
  		{
    	   AlertEx(field+resourceLangDes[errmsg[1]]);
           return false;
        }
   
        var lease=LeaseTime*Frag;
        if(lease<=0)
      	{
            AlertEx(field+resourceLangDes[errmsg[1]]);
            return false;
        }
   
        if((lease>604800*10))
      	{
      	    AlertEx(field+resourceLangDes[errmsg[2]]);
            return false;
      	}
      
        return true;
}

function ipTDEPreserved(IpAddress)
{
	var ip4 = IpAddress.split(".");
	
	if ((parseInt(ip4[0],10) == 192)
		&& (parseInt(ip4[1],10) == 168)
		&& (parseInt(ip4[2],10) == 2))
	{
		return true;
	}	
	
	return false;
}

function ipRangTDEPreserved(startIp, endIp)
{
	var ipChkStart = IpAddress2DecNum('192.168.2.0');
	var ipChkEnd = IpAddress2DecNum('192.168.2.255');
	var startIpNum = IpAddress2DecNum(startIp);
	var endIpNum = IpAddress2DecNum(endIp);
	
	if ((endIpNum < ipChkStart) || (startIpNum > ipChkEnd))
	{
		return false;
	}
	
	return true;
}

