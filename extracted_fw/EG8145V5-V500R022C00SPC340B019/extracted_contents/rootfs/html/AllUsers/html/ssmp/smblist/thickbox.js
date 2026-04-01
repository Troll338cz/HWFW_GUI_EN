var tb_pathToImage = "/html/ssmp/smblist/images/loadingAnimation.gif";
var avMaxPathLen = 256;

function tb_initFunc(domChunk) {
	$(domChunk).click(function(){
	var localTitle = this.title || this.name || null;
	var localAlt = this.href || this.alt;
	var localRel = this.rel || false;
	tb_show(localTitle ,localAlt, localRel);
	this.blur();
	return false;
	});
}

$(document).ready(function(){
	tb_initFunc('a.thickbox, area.thickbox, input.thickbox');
	imgLoader = new Image();
	imgLoader.src = tb_pathToImage;
});

function tb_detectMacXFF() {
	var userAgent = navigator.userAgent.toLowerCase();
	if (userAgent.indexOf('mac') != -1 && userAgent.indexOf('firefox')!=-1) {
	  return true;
	}
}

function tb_showIframe(){
	$("#TB_load").remove();
	$("#TB_window").css({display:"block"});
}

function tb_parseQuery (query) {
	var pairs = query.split(/[;&]/);
	var params = {};
	if (!query) {
		return params;
	}

	for (var i = 0; i < pairs.length; i++ ) {
	   var keyValue = pairs[i].split('=');
	   if ( ! keyValue || keyValue.length != 2 ) {
		   continue;
		}
	   var key = unescape( keyValue[0] );
	   var val = unescape( keyValue[1] );
	   val = val.replace(/\+/g, ' ');
	   params[key] = val;
	}
	return params;
 }
  
function tb_positionFun() {
	  $("#TB_window").css({marginLeft: '-' + parseInt((TB_WIDTH / 2),10) + 'px', width: TB_WIDTH + 'px'});
			  $("#TB_window").css({marginTop: '-' + parseInt((TB_HEIGHT / 2),10) + 'px'});
}

function tb_show(caption, thickBoxUrl, imageGroup) {
	
	try {
		if (typeof document.body.style.maxHeight === "undefined") {
			$("html").css("overflow","hidden");
			$("body","html").css({height: "100%", width: "100%"});
			if (document.getElementById("TB_HideSelect") === null) {
				$("body").append("<iframe id='TB_HideSelect'></iframe><div id='TB_overlay'></div><div id='TB_window'></div>");
				$("#TB_overlay").click(tb_removeFunc);
			}
		} else {
			if (document.getElementById("TB_overlay") === null) {
				$("body").append("<div id='TB_overlay'></div><div id='TB_window'></div>");
				$("#TB_overlay").click(tb_removeFunc);
			}
		}

		if (tb_detectMacXFF()) {
			$("#TB_overlay").addClass("TB_overlayMacFFBGHack");
		} else {
			$("#TB_overlay").addClass("TB_overlayBG");
		}

		if (caption===null) {
			caption="";
		}
		$("body").append("<div id='TB_load'><img src='"+imgLoader.src+"' /></div>");
		$('#TB_load').show();

	    var baseURL;
	   if (thickBoxUrl.indexOf("?") != -1) {
			  baseURL = thickBoxUrl.substr(0, thickBoxUrl.indexOf("?"));
	   } else {
	   		baseURL = thickBoxUrl;
	   }

	   var urlString = /\.jpg$|\.jpeg$|\.png$|\.gif$|\.bmp$/;
	   var urlType = baseURL.toLowerCase().match(urlString);

		if(urlType == '.jpg' || urlType == '.jpeg' || urlType == '.png' || urlType == '.gif' || urlType == '.bmp')
		{

			tbPrevCaption = "";
			tbPrevURL = "";
			tbNextURL = "";
			tbNextHTML = "";
			tbNextCaption = "";
			tbimageCount = "";
			tbPrevHTML = "";
			tbFoundURL = false;
			if (imageGroup) {
				TB_TempArray = $("a[@rel="+imageGroup+"]").get();
				for (TB_Counter = 0; ((TB_Counter < TB_TempArray.length) && (tbNextHTML === "")); TB_Counter++) {
					var urlTypeTemp = TB_TempArray[TB_Counter].href.toLowerCase().match(urlString);
						if (!(TB_TempArray[TB_Counter].href == thickBoxUrl)) {
							if (tbFoundURL) {
								tbNextCaption = TB_TempArray[TB_Counter].title;
								tbNextURL = TB_TempArray[TB_Counter].href;
								tbNextHTML = "<span id='TB_next'>&nbsp;&nbsp;<a href='#'>Next &gt;</a></span>";
							} else {
								tbPrevCaption = TB_TempArray[TB_Counter].title;
								tbPrevURL = TB_TempArray[TB_Counter].href;
								tbPrevHTML = "<span id='TB_prev'>&nbsp;&nbsp;<a href='#'>&lt; Prev</a></span>";
							}
						} else {
							tbFoundURL = true;
							tbimageCount = "Image " + (TB_Counter + 1) +" of "+ (TB_TempArray.length);
						}
				 }
			}

			imgPreloader = new Image();

			imgPreloader.onload = function() {
				imgPreloader.onload = null;
				var pagesize = tb_getPageSize();
				var pageWidth = pagesize[0] - 150;
				var pageHeig = pagesize[1] - 150;
				var imageWidth = imgPreloader.width;
				var imageHeight = imgPreloader.height;
				if (imageWidth > pageWidth) {
					imageHeight = imageHeight * (pageWidth / imageWidth);
					imageWidth = pageWidth;
					if (imageHeight > pageHeig) {
						imageWidth = imageWidth * (pageHeig / imageHeight);
						imageHeight = pageHeig;
					}
				}
				else if (imageHeight > pageHeig) {
					imageWidth = imageWidth * (pageHeig / imageHeight);
					imageHeight = pageHeig;
					if (imageWidth > pageWidth) {
						imageHeight = imageHeight * (pageWidth / imageWidth);
						imageWidth = pageWidth;
				  }
			  }
				TB_WIDTH = imageWidth + 30;
				TB_HEIGHT = imageHeight + 60;
				$("#TB_window").append("<a href='' id='TB_ImageOff' title='Close'><img id='TB_Image' src='"+thickBoxUrl+"' width='"+imageWidth+"' height='"+imageHeight+"' alt='"+caption+"'/></a>" + "<div id='TB_caption'>"+caption+"<div id='TB_secondLine'>" + tbimageCount + tbPrevHTML + tbNextHTML + "</div></div><div id='TB_closeWindow'><a href='#' id='TB_closeWindowButton' title='Close'>[X]</a></div>");

				$("#TB_closeWindowButton").click(tb_removeFunc);

				if (!(tbPrevHTML === "")) {
					function goPrev(){
						if($(document).unbind("click",goPrev)){$(document).unbind("click",goPrev);}
						$("#TB_window").remove();
						$("body").append("<div id='TB_window'></div>");
						tb_show(tbPrevCaption, tbPrevURL, imageGroup);
						return false;
					}
					$("#TB_prev").click(goPrev);
				}

				if (!(tbNextHTML === "")) {
					function goNext(){
						$("#TB_window").remove();
						$("body").append("<div id='TB_window'></div>");
						tb_show(tbNextCaption, tbNextURL, imageGroup);
						return false;
					}
					$("#TB_next").click(goNext);

				}

				document.onkeydown = function(e) {
					if (e != null) {
						keycode = e.which;
					} else {
						keycode = event.keyCode;
					}
					if (keycode == 27) {
						tb_removeFunc();
					} else if(keycode == 190) {
						if (!(tbNextHTML == "")) {
							document.onkeydown = "";
							goNext();
						}
					} else if (keycode == 188) {
						if (!(tbPrevHTML == "")) {
							document.onkeydown = "";
							goPrev();
						}
					}
				};

				tb_positionFun();
				$("#TB_load").remove();
				$("#TB_ImageOff").click(tb_removeFunc);
				$("#TB_window").css({display:"block"});
			};
			imgPreloader.src = thickBoxUrl;

		} else {
			var queryString = thickBoxUrl.replace(/^[^\?]+\??/,'');
			var params = tb_parseQuery( queryString );

			TB_WIDTH = (params['width']*1) + 30 || 630;
			TB_HEIGHT = (params['height']*1) + 40 || 440;
			ajaxContenWid = TB_WIDTH - 30;
			ajaxContenHei = TB_HEIGHT - 45;

			if (thickBoxUrl.indexOf('TB_iframe') != -1) {
				urlNoQuery = thickBoxUrl.split('TB_');
				$("#TB_iframeContent").remove();
                
				if (params['modal'] != "true") {
                    $("#TB_title").remove();
				    $("#TB_window").append("<div id='TB_title'><div id='TB_ajaxWindowTitle'>"+caption+"</div><div id='TB_closeAjaxWindow'><a href='#' id='TB_closeWindowButton' title='Close'>[X]</a></div></div><iframe frameborder='0' hspace='0' src='"+urlNoQuery[0]+"' id='TB_iframeContent' name='TB_iframeContent"+Math.round(Math.random()*1000)+"' onload='tb_showIframe()' style='width:"+(ajaxContenWid + 29)+"px;height:"+(ajaxContenHei + 17)+"px;' > </iframe>");
                } else {
					
				    $("#TB_overlay").unbind();
					$("#TB_window").append("<iframe frameborder='0' hspace='0' src='"+urlNoQuery[0]+"' id='TB_iframeContent' name='TB_iframeContent"+Math.round(Math.random()*1000)+"' onload='tb_showIframe()' style='width:"+(ajaxContenWid + 29)+"px;height:"+(ajaxContenHei + 17)+"px;'> </iframe>");
				}
			} else {
				if ($("#TB_window").css("display") != "block") {
					if (params['modal'] != "true") {
				        $("#TB_title").remove();
						$("#TB_window").append("<div id='TB_title'><div id='TB_ajaxWindowTitle'>"+caption+"</div><div id='TB_closeAjaxWindow'><a href='#' id='TB_closeWindowButton'>[X]</a></div></div><div id='TB_ajaxContent' style='width:"+ajaxContenWid+"px;height:"+ajaxContenHei+"px'></div>");
					} else {
						$("#TB_overlay").unbind();
						$("#TB_window").append("<div id='TB_ajaxContent' class='TB_modal' style='width:"+ajaxContenWid+"px;height:"+ajaxContenHei+"px;'></div>");
					}
				} else {
					
					$("#TB_ajaxContent")[0].style.width = ajaxContenWid +"px";
					$("#TB_ajaxContent")[0].scrollTop = 0;
					$("#TB_ajaxContent")[0].style.height = ajaxContenHei +"px";
					$("#TB_ajaxWindowTitle").html(caption);
				}
			}

			$("#TB_closeWindowButton").click(tb_removeFunc);

				if (thickBoxUrl.indexOf('TB_inline') != -1) {
					$("#TB_ajaxContent").append($('#' + params['inlineId']).children());
					$("#TB_window").unload(function () {
						$('#' + params['inlineId']).append( $("#TB_ajaxContent").children() );
					});
					tb_positionFun();
					$("#TB_load").remove();
					$("#TB_window").css({display:"block"});
				} else if (thickBoxUrl.indexOf('TB_iframe') != -1) {
					tb_positionFun();
					if ( $.browser.safari ) {
						$("#TB_load").remove();
						$("#TB_window").css({display:"block"});
					}
				} else {
					$("#TB_ajaxContent").load(thickBoxUrl += "&random=" + (new Date().getTime()),function() {
						tb_positionFun();
						$("#TB_load").remove(); 
						tb_initFunc("#TB_ajaxContent a.thickbox");
						$("#TB_window").css({display:"block"});
					});
				}
		}

		if (!params['modal']) {
			document.onkeyup = function(e) {
				if (e != null) {
					keycode = e.which;
				} else {
					keycode = event.keyCode;
				}
				if (keycode == 27) {
					tb_removeFunc();
				}
			};
		}
	} catch(e) {
		/* nothing here */
	}
}

function tb_removeFunc() {
 	$("#TB_imageOff").unbind("click");
	$("#TB_closeWindowButton").unbind("click");
	$("#TB_window").fadeOut("fast",function(){
		$("#TB_iframeContent").remove();
		$('#TB_window,#TB_overlay,#TB_HideSelect').trigger("unload").unbind().remove();
		if ( typeof (CollectGarbage) == 'function' )
		{
			CollectGarbage();
		}

	});
	$("#TB_load").remove();
	
	if (typeof document.body.style.maxHeight == "undefined") {
		$("body","html").css({height: "auto", width: "auto"});
		$("html").css("overflow","");
	}
	document.onkeyup = "";
	document.onkeydown = "";
	return false;
}

function tb_getPageSize(){
	var doc = document.documentElement;
	var w = window.innerWidth || self.innerWidth || (doc&&doc.clientWidth) || document.body.clientWidth;
	var h = window.innerHeight || self.innerHeight || (doc&&doc.clientHeight) || document.body.clientHeight;
	arrayPageSize = [w,h];
	return arrayPageSize;
}

