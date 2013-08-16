$(document).ready(function(){
	$(document).on("click", ".clickable", function(){
		if ($(this).children('iframe').length > 0) return;

		$(this).children().toggle(false);
		$(this).append('<iframe width="432" height="324" src="' + $(this).attr('src') + '?autoplay=1" frameborder="0"></iframe>'); 
	});	
});	



