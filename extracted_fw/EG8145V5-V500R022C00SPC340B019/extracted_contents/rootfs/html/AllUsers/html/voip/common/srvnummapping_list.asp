function stServiceNumMappingList(Domain, ServiceNum, TemplateName)
{
    this.Domain = Domain;
    this.ServiceNum = ServiceNum;
    this.TemplateName = TemplateName;
    var temp = Domain.split('.');
    this.InstId = temp[6];
}
var ServiceNumMappingList = <%HW_WEB_GetParaArryByDomain(InternetGatewayDevice.Services.VoiceService.1.X_HW_DspTemplate.ServiceNumMapping.{i},ServiceNum|TemplateName,stServiceNumMappingList); %>;

var AllMappingList = new Array();
for(var i = 0; i < ServiceNumMappingList.length - 1; i++)
{
    AllMappingList.push(ServiceNumMappingList[i]);
}

function writeListTabHeader(tabTitle, tabwidth, btnWidth, tabId)
{
	if (tabwidth == null)
		tabwidth = "100%";

	var html = "<table";

	if (tabId != null)
	{
		html += " id=\"" + tabId + "\"";
	}

	html += " width=\"" + tabwidth + "\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
			+ "<tr class=\"alignment_rule\">"
			+ "<td>";


	GetLanguageInfo(LanguageArrayInfos, g_curLanguage);

	html +=  '<input style="width:' + btnWidth + '"' +'class="NewDelbuttoncss" id="Newbutton" type="button" value="' + NewCurValue + '"'
			 + 'onclick="clickAddList(\''
			 + tabTitle + '\');">'
			 + '<input style="margin-left:9px;width:' + btnWidth + '"' +'id="DeleteButton" class="NewDelbuttoncss" type="button" value="' + DelCurValue + '"'
			 + 'onclick="OnDeleteButtonClick(\''
			 + tabTitle + '\');">'
			 + '<tr>'
			 + '<td class="button_spread">'
			 + "<\/td>"
			 + "<\/tr>";


	html += "<\/td>"
			+ "<\/tr>"
			+ "<tr>"
			+ "<td id=\"" + tabTitle + "\">";

	writeFile(html);
	document.write(html);
}

function ShowServiceNumList(ShowDefault, TableName, TableType, ColumnNum, TableDataInfo, ColumnTitleDesArray,LaguageList)
{
    writeListTabHeader(TableName + "_head", '100%', null, TableName + "_tbl");
    var LineRowDataNum = TableDataInfo.length - 1;
	var tablehtml = '<table width="100%" class="tabal_bg" id="' + TableName + '" cellspacing="1">';
	for(var Column_i = 0; Column_i < ColumnNum;  Column_i++)
	{
		if(0 == Column_i)
		{
			var DataColumNum = ColumnNum;
			tablehtml += '<tr class="head_title">';
		}

		if(true == ColumnTitleDesArray[Column_i].IsNotShowFlag)
		{
			continue;
		}

		var headid = ' id="head' + TableName +  "_0_" + Column_i + '" ';
		var Column_i_Des = ColumnTitleDesArray[Column_i].DesRef;
		var Column_i_Class = (null == ColumnTitleDesArray[Column_i].TableClass ? "" : ColumnTitleDesArray[Column_i].TableClass);
		var Des = (null == LaguageList[Column_i_Des] || undefined == LaguageList[Column_i_Des]) ? "" : LaguageList[Column_i_Des];
		tablehtml += '<td class="' + Column_i_Class + '"' + headid + '>' + Des + '<\/td>';
	}

	tablehtml += '</tr>';
	document.write(tablehtml);

	if (LineRowDataNum == 0)
	{
		var firstroe = '<tr id="' + TableName + '_record_no"' + 'class="tabal_01" >';
		for(var Column_i = 0; Column_i < DataColumNum;  Column_i++)
		{
			if(true == ColumnTitleDesArray[Column_i].IsNotShowFlag)
			{
				continue;
			}

			var TdClass = (null == ColumnTitleDesArray[Column_i].TableClass ? "" : ColumnTitleDesArray[Column_i].TableClass);
			var headid = ' id="' + TableName +  "_0_" + Column_i + '" ';
			firstroe += '<td align="center" class="' + TdClass + '" ' + headid +  '>--</td>';
		}
		firstroe += '</tr>';
		document.write(firstroe);
	}
	else
	{
		var LIneDate;
		
    	for( var Data_j = 0; Data_j < TableDataInfo.length - 1; Data_j++)
    	{
            var LIneDate = TableDataInfo[Data_j];
    	   
    		if( Data_j%2 == 0 )
    		{
    			var LineHtml = '<TR id="' + TableName + '_record_' + Data_j + '" class="tabal_01" >';
    		}
    		else
    		{
    			var LineHtml = '<TR id="' + TableName + '_record_' + Data_j + '" class="tabal_02" >';
    		}
    		
		    for(var Title_j = 0; Title_j < ColumnTitleDesArray.length - 1; Title_j++)
		    {
                var TitleAttrName = ColumnTitleDesArray[Title_j].ShowAttrName;
			    var ShowFlag = ColumnTitleDesArray[Title_j].IsNotShowFlag;
			    var TdMaxNum = ColumnTitleDesArray[Title_j].MaxNum;
			    var Td_i_Class = (null == ColumnTitleDesArray[Title_j].TableClass ? "" : ColumnTitleDesArray[Title_j].TableClass);
			    var Ischangecode = (undefined != ColumnTitleDesArray[Title_j].Ischangecode && 0 == ColumnTitleDesArray[Title_j].Ischangecode ? 0 : 1);
			    
			    if("DomainBox" == TitleAttrName)
    			{
    				var onclickstr = GetCheckboxFuncString(TableName);
    				LineHtml += '<TD class="' + Td_i_Class + '" ><input id = "' + TableName + '_rml'+ Data_j + '" type="checkbox" name="' + TableName + 'rml"'  + onclickstr + ' value="' + TableDataInfo[Data_j].domain + '"></TD>';
    				continue;
    			}
    			
    			var TdId = ' id="' + TableName + "_" + Data_j + "_" + Title_j + '" ';
    			if("remotetelno" == TitleAttrName)
    			{
    			    LineHtml += '<td class="' + Td_i_Class + '" ' + TdId + '><input id = "' + TableName + '_txtl'+ Data_j + '" style="width: 90%" type="text" class="TexBox" maxlength="64" realtype="TextBox" bindfield="' + TableName + '_txtl'+ Data_j + '"></TD>';
    				continue;
    			}
    			
    			if("dsptemplate" == TitleAttrName)
    			{
    			    LineHtml += '<td class="' + Td_i_Class + '" ' + TdId + '><select id = "' + TableName + '_listl'+ Data_j + '" class="selectdefcss" realtype="DropDownList" bindfield="' + TableName + '_listl'+ Data_j + '"></select></TD>';
    				continue;
    			}
    			
    			if(0 == Ischangecode)
    			{
    				var ShowAttrValue = LIneDate[TitleAttrName];
    			}
    			else
    			{
    				var ShowAttrValue = htmlencode(LIneDate[TitleAttrName]);
    			}
    			
    			if (ShowAttrValue != null)
    			{
    				var InnerHtml = (TdMaxNum == "undefined" || TdMaxNum == "") ? ShowAttrValue : GetStringContent(ShowAttrValue, TdMaxNum);
    				if (ShowAttrValue === InnerHtml)
    				{
    					LineHtml += '<TD class="' + Td_i_Class + '" ' + TdId +'>' + InnerHtml + '</TD>';
    				}
    				else
    				{
    					LineHtml += '<TD class="' + Td_i_Class + '" title="' + ShowAttrValue + '"' + TdId +'>' + InnerHtml + '</TD>';
    				}
    			}
		    }
		    
		    LineHtml+='</tr>';
		    document.write(LineHtml);
    	}
	}

	document.write('</table>');
	writeTabTail();
}

function ShowMappingListTable(index, remotetelno, dsptemplate)
{
    this.index = index;
    this.remotetelno = remotetelno;
    this.dsptemplate = dsptemplate;
}

function GetServiceNumMappingPara()
{

	var MappingListArray = new Array();
	
	if(AllMappingList.length == 0)
	{
		var MappingListTab = new ShowMappingListTable();
		MappingListTab.index = "--";
		MappingListTab.remotetelno = "--";
		MappingListTab.dsptemplate = "--";
	}
	else
	{
		
		for (var i = 0; i < AllMappingList.length; i++)
		{	
			var MappingListTab = new ShowMappingListTable();
			
			MappingListTab.domain = AllMappingList[i].Domain;
			
			MappingListTab.index = i+1;
			
			MappingListTab.remotetelno = AllMappingList[i].ServiceNum;
		    MappingListTab.dsptemplate = AllMappingList[i].TemplateName;
			MappingListArray.push(MappingListTab);
		}
	}
	
	MappingListArray.push(null);
	return MappingListArray;
}

function ShowServiceNumListTable(dtTemplateParams)
{
    var i = 0;
    var ShowableFlag = 1;
    var ShowButtonFlag = 1;
    var ColumnNum = 4;
    var ConfiglistInfo = new Array(new stTableTileInfo("Empty","","DomainBox",false),
    							new stTableTileInfo("vspa_seq","align_center","index",false),
    							new stTableTileInfo("vspa_remotetelno","wordclass align_center","remotetelno",false),
    							new stTableTileInfo("vspa_dsptemplates","wordclass align_center","dsptemplate",false),null);
    var tableid = "ServiceNumMappingList";			
    						
    var VoipArray = GetServiceNumMappingPara();
    ShowServiceNumList(ShowableFlag, tableid, ShowButtonFlag, ColumnNum, VoipArray, ConfiglistInfo, sipuser);

    for(var indx = 0; indx < AllMappingList.length; indx++)
    {
        var setlectid = tableid + '_listl' + indx;
        DropDownListTemplateSelect(setlectid, dtTemplateParams);
    }
}

function ServiceNumMappingListselectRemoveCnt()
{
}

function setCurServiceNumMappingPara()
{
    var cellid;
    var TableName = "ServiceNumMappingList";
    
    for(var idx = 0; idx < ServiceNumMappingList.length - 1; idx++)
    {

        cellid = TableName + '_txtl'+ idx;
        setText(cellid,ServiceNumMappingList[idx].ServiceNum);
        
        cellid = TableName + '_listl'+ idx;
        addTemplateItem(cellid, ServiceNumMappingList[idx].TemplateName);
        setSelect(cellid, ServiceNumMappingList[idx].TemplateName);
    }
}

function CheckSrvNumMappingPara()
{
    for(var i = 0; i < AllMappingList.length; i++)
    {
        var itemid = "ServiceNumMappingList_txtl"+i;
        if(isSafeStringIn(getValue(itemid), '0123456789*#xX') == false)
        {
            return false;
        }
    }
}

function clickAddList(tabTitle)
{
	var tab = document.getElementById(tabTitle).getElementsByTagName('table');
	var row,col;
	var rowLen = tab[0].rows.length;
	var PrevTabID = "";
	var insertlength = 0;
	var TableName = "ServiceNumMappingList";
	var rowidex = ServiceNumMappingList.length - 1;
	
    if(rowidex >= 20)
    {
        AlertEx(sipuser['vspa_servicenummappingmax']);
        return false;
    }

	if(-1 != tabTitle.indexOf("_head"))
	{
		PrevTabID = tabTitle.split("_")[0];
		var Record_null = PrevTabID+"_record_"+rowidex;
		var Record_no = PrevTabID+"_record_no";
	}
	else
	{
		PrevTabID = '';
		var Record_null = rowidex;
		var Record_no = "record_no";
	}

	var firstRow = tab[0].rows[0];
	var lastRow = tab[0].rows[rowLen - 1];

	if (lastRow.id == Record_null)
	{
		return;
	}
	else if (lastRow.id == Record_no)
	{
		tab[0].deleteRow(rowLen-1);
		rowLen = tab[0].rows.length;
	}

	row = tab[0].insertRow(rowLen);

	var appName = navigator.appName;
	if(appName == 'Microsoft Internet Explorer')
	{
		g_browserVersion = 1; /* IE */
		row.className = 'tabal_01';
		row.id = Record_null;
	}
	else
	{
		g_browserVersion = 2; /* firefox */
		row.setAttribute('class','tabal_01');
		row.setAttribute('id',Record_null);
	}

	/* get first or second cells length*/
	insertlength = firstRow.cells.length;
	if(1 == firstRow.cells.length)
	{
		SecondRow = tab[0].rows[1];
		insertlength = SecondRow.cells.length
	}
	
	for (var i = 0; i < insertlength; i++)
	{
		col = row.insertCell(i);
        if(g_browserVersion == 1)
        {
            col.className = firstRow.cells[i].className;
        }
        else
        {
            col.setAttribute('class',firstRow.cells[i].className);
        }
		
	    var TdId = ' id="' + TableName + "_" + rowidex + "_" + i + '" ';	
		if(i == 0)
		{
		    col.innerHTML =  '<input id = "' + TableName + '_rml'+ rowidex + '" type="checkbox" name="' + TableName + 'rml"' + ' value="' + '">';
		}
		else if(i == 2)
		{
		    col.innerHTML = '<input id = "' + TableName + '_txtl'+ rowidex + '" style="width: 90%" type="text" class="TexBox" maxlength="64" realtype="TextBox" bindfield="' + TableName + '_txtl'+ rowidex + '">';
		}
		else if(i == 3)
	    {
	        col.innerHTML = '<select id = "' + TableName + '_listl'+ rowidex + '" class="selectdefcss" realtype="DropDownList" bindfield="' + TableName + '_listl'+ rowidex + '"></select>';
	    }
	    else
	    {
	        col.innerHTML = ServiceNumMappingList.length;
	    }
		    
	}
	
	DropDownListTemplateSelect(TableName + '_listl'+ rowidex, UserDspTemplateParams);
	
	AllMappingList.push(new stServiceNumMappingList('InternetGatewayDevice.Services.VoiceService.1.X_HW_DspTempalte.ServiceNumMapping.'+ServiceNumMappingList.length, '', ''));
}

function clickRemoveItem(filepath) 
{
    var CheckBoxList = document.getElementsByName("ServiceNumMappingListrml");
    var SubmitForm = new webSubmitForm();
    var Count = 0;
    
    for (var i = 0; i < CheckBoxList.length; i++)
    {
        if (CheckBoxList[i].checked == true)
        {
            Count++;
            SubmitForm.addParameter(CheckBoxList[i].value,'');
        }
    }
    
    if(Count)
    {
        SubmitForm.setAction('del.cgi?RequestFile='+filepath);
    	SubmitForm.addParameter('x.X_HW_Token', getValue('onttoken'));
    	SubmitForm.submit();
    }
    
}

function SetSrvNumMappingPara(SrvNumMappingParaData)
{
	var Result = null;
	$.ajax({
	type : "POST",
	async : false,
	cache : false,
	url : './SetSrvNumMapping.cgi?num='+SrvNumMappingParaData,
	data :'x.X_HW_Token=' + getValue('onttoken'),
	success : function(data) 
	{
	
	}
	});

	return null;

}

function SetSrvNumMappingDataBuf()
{
    var PrefixId;
    var PrefixTelno;
    var PrefixName;
    var ParaBuf = '';
    
    if(ServiceNumMappingList.length <= 1)
    {
        return ;
    }

    ParaBuf = (ServiceNumMappingList.length - 1);
    for(var i = 0; i < ServiceNumMappingList.length - 1; i++)
    {
        itemtxtid = 'ServiceNumMappingList_txtl'+i;
        itemselectid = 'ServiceNumMappingList_listl'+i;
        PrefixId = '&id'+i+'=';
        PrefixTelno = '&telno'+i+'=';
        PrefixName = '&name'+i+'=';
        
        ParaBuf += PrefixId + ServiceNumMappingList[i].InstId + PrefixTelno + getValue(itemtxtid) + PrefixName + getSelectVal(itemselectid);
    }
    
    SetSrvNumMappingPara(ParaBuf);
 
}