jQuery(function() {
    return $('#sortable').sortable({
      axis: 'y',
      handle: '.handle',
      update: function() {
        return $.post($(this).data('event-url'), $(this).sortable('serialize'));
      }
    });
});

$(document).ready(function(){
	$(document).ajaxComplete(function(){
		$('#sortable').sortable({
	      axis: 'y',
	      handle: '.handle',
	      update: function() {
	        return $.post($(this).data('event-url'), $(this).sortable('serialize'));
	      }
	    });

		// $(".widget").each(function(e){
		// 	e.stopPropagation();
		// 	e.preventDefault();
		// 	setWidget($(this));
		// });
	});

	// $(".widget").each(function(){
	// 	setWidget($(this));
	// });
});

function setWidget(widget){

	widget.hover(function() {
		if( $(this).find('.widget-setting').is(':hidden') ) {
			$(this).find('.edit').show();
		}	     
	},function(){
		if( $(this).find('.widget-setting').is(':hidden') ) {
	  		$(this).find('.edit').hide();
		}
	}); 
	
	widget.on('click', '.edit', function(e) {
		widget.find('.widget-setting').toggle();
		
		if(widget.find('.widget-setting').is(':visible')) {
			widget.find('.edit span').text('关闭设置');
		} else {
			widget.find('.edit span').text('设置');
		}
		
	});

	widget.find('.cancel').click(function(e) {
		e.preventDefault();
		widget.find('.widget-setting').hide();
		widget.find('.edit span').text('设置');
	});	
}