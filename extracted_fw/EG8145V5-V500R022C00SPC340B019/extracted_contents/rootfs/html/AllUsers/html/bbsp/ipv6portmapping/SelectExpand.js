
(function($){
    $.extend($.fn,{
        SelectExpand:function(option){
            $(document).click(function(e) {
                    var elem=$(e.target);
                    if ($(".SelectExpand_s").is(":visible") && elem.attr("class")!="SelectExpand_i" && !elem.parent(".SelectExpand_s").length) {
                        $('.SelectExpand_s').hide();
                    }
            });

            return this.each(function(index, element) {

                var expand_obj = $.data( this, "SelectExpandObj" );
                if ( expand_obj ) {
                        return expand_obj;
                    }
                    var expand_obj=new $.SelectExpandClass(option,this);
                    $.data( this, "SelectExpandObj", expand_obj );
            });
        }
    });
}(jQuery));

$.SelectExpandClass = function( option, select ) {
  this.settings = $.extend( true, {}, $.SelectExpandClass.defaults, option );
  this.currInput = null;
  this.currSelect = select;
	this.init();
};

$.extend($.SelectExpandClass,{
	defaults:{
		select_size:6
	},
	prototype:{
		init:function(){
			this.createInput();
			$(this.currSelect).hide();
			$(this.currSelect).attr("size",this.settings.select_size);
			$(this.currSelect).bind("click",this.__bind(this.onSelectClick,this));
			$(this.currInput).bind("click",this.__bind(this.onInputClick,this));
			$(this.currInput).bind("dblclick",this.__bind(this.onInputDblClick,this));
		},
		__bind:function(fn,me){
			return function(){
				return fn.apply(me,arguments);
				};
		},
		createInput:function(){
			var input_obj=$('<input type="text"  id="InternalClient" class="SelectExpand_i" size="20" maxlength="256"/>').css({"width":this.currSelect.getAttribute("textwidth")-4}).insertBefore(this.currSelect);
			this.currInput=input_obj[0];
		},
		onSelectClick:function(evt){
			$(this.currInput).val($(this.currSelect).find("option:selected").val());
			$(this.currInput).attr("title",$(this.currInput).val());
			$(this.currSelect).hide();
		},
		onInputClick:function(evt){
			var scr_left=document.documentElement.scrollLeft| window.scrollX;
			var scr_top=document.documentElement.scrollTop| window.scrollY;
			var rect=this.currInput.getBoundingClientRect();
			var x= rect.left+scr_left;
       		var y =rect.top+scr_top+this.currInput.offsetHeight;
			$(this.currSelect).css({"left":x,"top":y});
			$(this.currSelect).addClass("SelectExpand_s");
			$(".SelectExpand_s:visible").hide();
			$(this.currSelect).show();
		},
		onInputDblClick:function(evt){
			$(this.currSelect).hide();
		}
	}
	
	
});
