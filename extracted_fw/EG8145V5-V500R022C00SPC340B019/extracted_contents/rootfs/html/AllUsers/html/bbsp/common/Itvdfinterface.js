function ContentString(num, id, string) {
    var arr = new Array();
    var str = "";
    if (num > 1) {
        for (var i = 0; i < num; i++) {
            var getinputValue = getValue(id + i);
            if (getinputValue == "") {
                str = "";
            }
            else
            {
                arr.push(getinputValue);
            }
        };
    }
    str = arr.join(string);
    return str;
}

function SelectOption(classname1, classname2, classname3) {
    $("#" + classname1).hover(function() {
        $("#" + classname2).show();
        $("#" + classname2 + " " + "li").hover(function() {
            index = $("#" + classname2 + " " + "li").index(this);
            $("#" + classname2 + " " + "li").eq(index).addClass("hover");
        }, function() {
            $("#" + classname2 + " " + "li").removeClass("hover");
        })
    }, function() {
        $("#" + classname2).hide();
    });
    $("#" + classname2 + " " + "li").click(function() {
        $("#" + classname3).text($(this).text());
        $("#" + classname2).hide();
    });
}

function InputSkip(nub,id) {
    var txts = id.getElementsByTagName("input");
    for (var i = 0; i < txts.length; i++) {
        var t = txts[i];
        t.index = i;
        t.onkeyup = function() {
            if (this.value.length >= nub) {
                this.value = this.value.substr(0, nub);
                var next = this.index + 1;
                if (next > txts.length - 1)
                {
                    return;
                };
                txts[next].focus();
            }
        }
    }
    txts[0].removeAttribute("readonly");
}
function setAdrssStr(id,obj,str,nub)
{
    if (obj != null)
    {
        var ipadrss = obj.split(str);
        for (var i = 0; i < ipadrss.length; i++)
        {
            setText(id + i,ipadrss[i]);
        }
    }
    else
    {
        for (var i = 0; i < nub; i++)
        {
            setText(id + i,"");
        }
    }
}
var g_Allclickshow = false;
var dropdownArrlen = "";
function BbspCreateDropdown(selectid,dropdowndefault,width,dropdownArr,callfuncobj,flags,nub)
{
    var i = 0;
    var dropdownShowId = selectid + "show";
    var dropdownHideId = selectid + "hide";
    dropdownArrlen = dropdownArr.length;
    $('#'+selectid).css({"width":width});

    var DropdownIdStr = "<div class='iframedropdownShow' id='" + dropdownShowId + "' onclick='BbspshowDropdown(this,event);'></div><ul class='iframedropdownHide' id='" + dropdownHideId + "' style='display:none;'></ul>";

    $('#'+selectid).html(DropdownIdStr);

    $('#'+dropdownShowId).css({"width":"98%"});
    $('#'+dropdownShowId).html(dropdowndefault);
    if(flags == true)
    {
        $("#"+dropdownHideId).append("<li id='dropdowns_a' onclick='" + callfuncobj + "' title='"+ htmlencode(dropdowndefault) + "'>"+  GetStringContentForTitle(htmlencode(dropdowndefault),nub)+"</li>");
    }
    for(var i=0;i<dropdownArr.length;i++)
    {
        $("#"+dropdownHideId).append("<li id='dropdowns_"+ i + "' onclick='" + callfuncobj + "' title='"+ htmlencode(dropdownArr[i]) + "'>"+GetStringContentForTitle(htmlencode(dropdownArr[i]),nub)+"</li>")
    }
    $('#'+dropdownHideId).css({"width":width});

}
function BbspshowDropdown(obj, event)
{
    var ShowId = obj.id;
    var HideId = obj.id.split("show")[0] + "hide";

    $("#" + HideId).toggle(function()
    {
        if(false == g_Allclickshow)
        {
            var heightvalue = (dropdownArrlen*39) + "px";
            $("#showhight").css('height', heightvalue);
            $('#'+ShowId).css("background-image","url('../../../images/arrow-up.png')");
            g_Allclickshow = true;

        }
        else
        {
            $("#showhight").css('height', 0);
            g_Allclickshow = false;
            $('#'+ShowId).css("background-image","url('../../../images/arrow-down.png')");
        }
    });

    $("body").click(function()
    {
        $("#showhight").css('height', 0);
        $("#"+HideId).hide();
        g_Allclickshow = false;
        $('#'+ShowId).css("background-image","url('../../../images/arrow-down.png')");
    });

    var e = window.event || event;
    if(e.stopPropagation)
    {
        e.stopPropagation();
    }
    else
    {
        window.event.cancelBubble = true;
    }
}