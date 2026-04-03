
var maskStatus = 0;
var PageInfo={};

;(function($) {

	$.extend($.fn, {
		swapClass: function(param1, param2) {
			var c1Elements = this.filter('.' + param1);
			this.filter('.' + param2).removeClass(param2).addClass(param1);
			c1Elements.removeClass(param1).addClass(param2);
			return this;
		},
		loadMaskDiv: function(){
			if(maskStatus==0)
			{
				$("#maskContent").css({
					"opacity": "0.6"
				});
				$("#maskContent").fadeIn("normal");
				$("#maskWaiteImg").fadeIn("normal");
				maskStatus = 1;
			}
		},
		unloadmaskDiv: function(){
		    if (1 == maskStatus)
		    {
		    	$("#maskContent").fadeOut("normal");
				$("#maskWaiteImg").fadeOut("normal");
				maskStatus  = 0;
		    }
		},
		setMaskAndContent: function(){
			var ImgHeight = document.getElementById('maskWaiteImg').offsetHeight;
			var ImgWidth = document.getElementById('maskWaiteImg').offsetWidth;
			var t=(PageInfo.height()/2)-(ImgHeight/2); t=t<10?10:t;
			var topVal =(t+PageInfo.top()) + 'px';
			var leftVal =((PageInfo.width()/2)-(ImgWidth/2)) + 'px';

			$("#maskWaiteImg").css({
				"top": topVal,
				"left": leftVal
			});		


			$("#maskContent").css({
				"height": PageInfo.theight(),
				"width": PageInfo.twidth()
			});
		},
		resize:function(){
		    $(this).setMaskAndContent();
		},
		findTreePath: function(){
			var strPath = '';
            var AppendFlag = 0;
			//check class of the first child
			var ulLength = $(this).children().length;
			for (var z = 0; z < ulLength; z++)
			{
				if ($(this).children().eq(z).is('ul'))
				{
					break;
				}
			}
			//eq(0) is div
            if ($(this).children().eq(0).hasClass('hitarea'))
			{
		        if (false == $(this).children().eq(0).hasClass('collapsable-hitarea'))
				{
					if ($(this).children().eq(0).hasClass('expandable-hitarea'))
					{
						//remove child not remove the first child, the child of ul Item 
						$(this).children().eq(z).children().not(':first').remove();
					}
					AppendFlag = 1;
					//set radio checked
					$(this).setCurrentRadio();
					//set button enable
					$(this).setButtonEnable();
					return $(this).findCurrentPath(AppendFlag);
				}
		    }			
			if (false == ($(this).children().eq(0).hasClass('hitarea')))
			{
				//for one file folder
				AppendFlag = 1;
			}
			//set radio checked
			if ($(this).find('input').length > 0)
			{
				$(this).setCurrentRadio();
			}
			//set button enable
			$(this).setButtonEnable();
			return $(this).findCurrentPath(AppendFlag);
		},
		findCurrentPath: function(IsAppend)
		{
			var CurrentPath = '';
			var CurrentOldPath = '';
			var id          = '';
			var parentLength = 0;
			
			if (IsAppend)
			{
			    //only modify the path
				CurrentPath = 'notAppend#';
			}
			id = $(this).find('ul').attr('id');
			parentLength = $(this).parents().find(">span").length;
			if (parentLength == 0)
			{
				//for folder
				CurrentPath += '/' + $(this).find(">span").text();
				CurrentOldPath += '-' + $(this).find(">span").attr("id");
				CurrentPath = CurrentPath + "/*" + CurrentOldPath;
				return CurrentPath;
			}
			for(var j =0; j <= (parentLength - 1); j++)
			{
				CurrentPath += '/' + $(this).parents().find(">span").eq(j).text();
				CurrentOldPath += '-' + $(this).parents().find(">span").eq(j).attr("id");
			}
			if ('' != $(this).find(">span").text())
			{
				CurrentPath += '/' + $(this).find(">span").text();
				CurrentOldPath += '-' + $(this).find(">span").attr("id");
			}
			CurrentPath = CurrentPath + "/*" + CurrentOldPath;
			return CurrentPath;

		},
		replaceClass: function(param1, param2) {
			return this.filter('.' + param1).removeClass(param1).addClass(param2).end();
		},
		heightToggle: function(lineParam, callback) {
			lineParam ?
				this.animate({ height: "toggle" }, lineParam, callback) :
				this.each(function(){
					if ($(this).find('li').length > 0)
					{
						jQuery(this)[ jQuery(this).is(":hidden") ? "show" : "hide" ]();
					}
					if(callback)
						callback.apply(this, arguments);
				});
		},
		hoverClass: function(paramClass) {
			paramClass = paramClass || "hover";
			return this.hover(function() {
				$(this).addClass(paramClass);
			}, function() {
				$(this).removeClass(paramClass);
			});
		},
		heightHide: function(lineParam, callback) {
			if (lineParam) {
				this.animate({ height: "hide" }, lineParam, callback);
			} else {
				this.hide();
				if (callback)
					this.each(callback);				
			}
		},
		prepareBranches: function(paramSetting, toggler) {
			if (!paramSetting.prerendered) {
				this.filter(":last-child:not(ul)").addClass(CLASSES.last);
				this.filter((paramSetting.collapsed ? "" : "." + CLASSES.closed) + ":not(." + CLASSES.open + ")").find(">ul").hide();
				this.filter(":not(:has(>a))").find(">span").click(toggler).add( $("a", this) ).hoverClass();
				if ($(this).find('li').length > 0)
				{
					if (false == ($(this).find('li').children().is('span')))
					{
						$(this).find('li').hide();
					}
				}
			}
			return this.filter(":has(>ul)");
		},
		applyClasses: function(paramSetting, toggler) {	
			if (!paramSetting.prerendered) {
			
				this.not(":has(>ul:hidden)").addClass(CLASSES.collapsable).replaceClass(CLASSES.last, CLASSES.lastCollapsable);
				this.filter(":has(>ul:hidden)").addClass(CLASSES.expandable).replaceClass(CLASSES.last, CLASSES.lastExpandable);
				if ($(this).find('li').length != 0)	
				{
					this.prepend("<div class=\"" + CLASSES.hitarea + "\"/>").find("div." + CLASSES.hitarea).each(function() {
						var newClasses = "";
						$.each($(this).parent().attr("class").split(" "), function() {
							newClasses += this + "-hitarea ";
						});
						$(this).addClass( newClasses );
					});
					this.find("div." + CLASSES.hitarea).click( toggler );
				}
				else
				{
					this.prepend("<div class=\"" + CLASSES.hitareaEx + "\"/>");
					this.find("div." + CLASSES.hitareaEx).click( toggler );
				}
			}
		},
		BuildcommonAppendStAndAppendOne: function(OldName, name, type, fileflag, firstflag, id, ulIdx)
		{
			var $common = '<span style="white-space:pre" id="' + OldName + '">' + name + '</span>';
			//set id is name
			var newid = 'usbId';
			var $tempFileImage = $fileimage;
			var $tempFolderImage = $folderimage;
			var $AppendSt = '';
			var $InputRadio = '<INPUT type="radio" name="treeRadio" id="treeRadio" value="' + g_radioValue + '">';
			
			if (!firstflag)
			{
				$tempFileImage = $diskimage;
				$tempFolderImage = $tempFileImage;
				if (ulIdx == 0)
				{
					$InputRadio = '<INPUT checked type="radio" name="treeRadio" id="treeRadio" value="' + g_radioValue + '">';
				}
			}
			if (firstflag && ulIdx == 0)
			{
				//set all radio is no checked
				$(':radio').removeAttr('checked');
				//set the first child is checked
				$InputRadio = '<INPUT checked type="radio" name="treeRadio" id="treeRadio" value="' + g_radioValue + '">';
			}
			g_radioValue++;
			switch(type)
			{
				case 0:
					 //file
					 if (fileflag)
					 {
						//if support file
						$AppendSt = $AppendSt + '<li>' + $tempFileImage + $InputRadio + $common + '<ul></ul></li>';
					 }
				break;
				case 1:
					//folder has no file
					$AppendSt = $AppendSt + '<li>' + $tempFolderImage + $InputRadio + $common + '<ul></ul></li>';
				break;
				case 2:
					 //folder has file only
					 if (fileflag)
					 {
						//if support file
						g_idNum++;
						$AppendSt = $AppendSt + '<li>' + $tempFolderImage + $InputRadio + $common + '<ul id=' + newid + '_' + g_idNum +'><li></li></ul></li>';
					 }
					 else
					 {
						$AppendSt = $AppendSt + '<li>' +  $tempFolderImage + $InputRadio + $common + '<ul></ul></li>';
					 }
				break;
				case 3:
					  g_idNum++;
					  $AppendSt = $AppendSt + '<li>' +  $tempFolderImage + $InputRadio + $common + '<ul id=' + newid + '_' + g_idNum +'><li></li></ul></li>';
				break;
				default:
				break;
			}
			if ('' != $AppendSt)
			{
				var branches = $($AppendSt).appendTo(id);
				$(id).treeview({
					add: branches
				});
			}
		},
		TransferBlanckToHtml: function(SrcStr)
		{
		    var DestStr = '';
			var ulLength = SrcStr.length;
            var re = /\s/g;
			DestStr = SrcStr.replace(re, '&nbsp;');
			return DestStr;
		},
		TransferHtmlToBlank: function(SrcStr)
		{
		    var DestStr = '';
			var re = /&nbsp;/g;
			DestStr = SrcStr.replace(re, ' ');
			return DestStr;
		},
		AppendOthersFromAjax: function(bfileflag, bfirstAppend, id, AjaxGetStr, AjaxOldStr)
		{
			var NewArray   = AjaxGetStr.split("/|");
			var ulLength   = NewArray.length - 1;
			var OldArray   = AjaxOldStr.split("/|");
			var ulOldLength = NewArray.length - 1;
			var subPath    = '';
			var subOldPath    = '';
			var PathArray;
				
			if (ulLength != ulOldLength)
			{
			    if (false == confirm("Get path error, are you sure to continue?"))
			    {
			        return;
			    }
			}
			id = '#' + id;
			for (var i = 0; i < ulLength; i++)
			{
				var TempArray = NewArray[i].split("/:");
				var TempOldArray = OldArray[i].split("/:");

				var PathName = $(this).TransferBlanckToHtml(TempArray[0]);
                if (0 == i)
				{
					subPath = PathName;
					subOldPath = TempOldArray[0];
				}
				$(this).BuildcommonAppendStAndAppendOne(TempOldArray[0], PathName, parseInt(TempArray[1]), bfileflag, bfirstAppend, id, i);
			}
			$(':radio').click(function(){path = $(this).findTreePath(); path = path.substring(10);});
			PathArray = path.split("/*");
			if (PathArray.length > 1)
			{
				path = PathArray[0] + '/' + subPath;
				OldPath = PathArray[1] + '-' + subOldPath;
				path = path + "/*" + OldPath;
			}
			else
			{
				path += '/' + subPath + '/*-' + subOldPath;
			}
			$(this).setButtonEnable();
	    },
		setCurrentRadio: function()
		{
			$(':radio').removeAttr('checked');
			$(this).find("input").prop('checked',true);
		},
		setButtonEnable: function()
		{
			if ($('input:checked').length > 0)
			{
				$(':button').removeAttr('disabled');
			}
			else
			{
				$(':button').eq(1).attr({disabled:'disabled'});
			}
		},
		treeview: function(param) {
			
			param = $.extend({
				cookieId: "treeview"
			}, param);
			
			if ( param.toggle ) {
				var callback = param.toggle;
				param.toggle = function() {
					return callback.apply($(this).parent()[0], arguments);
				};
			}

			if (param.add) {
				return this.trigger("add", [param.add]);
			}
	
			function toggler() {
				$(this)
					.parent()
					.find(">.hitarea").swapClass( CLASSES.collapsableHitarea, CLASSES.expandableHitarea )
					.swapClass( CLASSES.lastCollapsableHitarea, CLASSES.lastExpandableHitarea )
					.end()
					.swapClass( CLASSES.collapsable, CLASSES.expandable )
					.swapClass( CLASSES.lastCollapsable, CLASSES.lastExpandable )
					.find( ">ul" )
					.heightToggle( param.animated, param.toggle );
				if ( param.unique ) {
					$(this).parent()
						.siblings()
						.find(">.hitarea").replaceClass( CLASSES.collapsableHitarea, CLASSES.expandableHitarea ).replaceClass( CLASSES.lastCollapsableHitarea, CLASSES.lastExpandableHitarea ).end()
					$(this).parent().siblings().find( ">ul" ).heightHide( param.animated, param.toggle );
					$(this).parent()
						.siblings()
						.replaceClass( CLASSES.collapsable, CLASSES.expandable )
						.replaceClass( CLASSES.lastCollapsable, CLASSES.lastExpandable )
				}
			}
			
			function serialize() {
				function binary(flag) {
					return flag ? 1 : 0;
				}
				var data = [];
				branches.each(function(index, arg) {
					data[index] = $(arg).is(":has(>ul:visible)") ? 1 : 0;
				});
				$.cookie(param.cookieId, data.join("") );
			}
			
			function deserialize() {
				var stored = $.cookie(param.cookieId);
				if ( stored ) {
					var data = stored.split("");
					branches.each(function(i, e) {
						$(e).find(">ul")[ parseInt(data[i]) ? "show" : "hide" ]();
					});
				}
			}
			$(this).find('ul').hide();
			this.addClass("treeview");
			var branches = this.find("li").prepareBranches(param, toggler);

			branches.applyClasses(param, toggler);
				
			if ( param.control ) {
				treeController(this, param.control);
				$(param.control).show();
			}
			return this.bind("add", function(event, branches) {
			    $(branches).find('ul').hide();
				$(branches).prev().removeClass(CLASSES.last).removeClass(CLASSES.lastCollapsable).removeClass(CLASSES.lastExpandable)
				.find(">.hitarea")
					.removeClass(CLASSES.lastCollapsableHitarea)
					.removeClass(CLASSES.lastExpandableHitarea);
				$(branches).find('li').addBack().prepareBranches(param,toggler).applyClasses(param, toggler);
			});
		}
	});
	
	var CLASSES = $.fn.treeview.classes = {
		
		closed: "closed",
		expandable: "expandable",
		expandableHitarea: "expandable-hitarea",
		collapsable: "collapsable",
		collapsableHitarea: "collapsable-hitarea",
		lastExpandable: "lastExpandable",
		last: "last",
		hitareaEx: "hitareaEx",
		open: "open",
		lastExpandableHitarea: "lastExpandable-hitarea",
		lastCollapsableHitarea: "lastCollapsable-hitarea",
		lastCollapsable: "lastCollapsable",
		hitarea: "hitarea",
	};
	
	$.fn.Treeview = $.fn.treeview;
	
})(jQuery);

PageInfo=function(){
	return{
		height:function(){return self.innerHeight||document.documentElement.clientHeight},
		twidth:function(){
			var d=document, b=d.body, e=d.documentElement;
			return Math.max(Math.max(b.scrollWidth,e.scrollWidth),Math.max(b.clientWidth,e.clientWidth))
		},
		width:function(){return self.innerWidth||document.documentElement.clientWidth},
		top:function(){return document.body.scrollTop||document.documentElement.scrollTop},
		theight:function(){
			var d=document, b=d.body, e=d.documentElement;
			return Math.max(Math.max(b.scrollHeight,e.scrollHeight),Math.max(b.clientHeight,e.clientHeight))
		},
	}
}();
