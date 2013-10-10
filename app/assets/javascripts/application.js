// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.sortable
//= require jquery.ui.autocomplete
//= require jquery.ui.datepicker
//= require jquery_nested_form
//= require reveal
//= require bootstrap
//= require jquery-plugins
//= require redactor-rails/redactor.min
//= require redactor
//= require social-share-button
//= require masonry
//= require_tree .


$(document).ready(function(){

	$("#load_more_link a").on("click", function(){
    	$("#load_more_link").hide();
  	});

  	$("#load_more_stream a").on("click", function(){
    	$("#load_more_stream").hide();
  	});
	// hide it first
	$("#spinner").hide();

	// when an ajax request starts, show spinner
	$(document).ajaxStart(function(){
	    $("#spinner").show();
	});

	// when an ajax request complets, hide spinner    
	$(document).ajaxStop(function(){
		$("#spinner").hide();
	});

	

	$(".my-community").click(function(){
	   window.location=$(this).find("a").attr("href"); 
	   return false;
	});

	$("#user-nav").click(function(e){
		$(".user-notify-popup").hide();
		$(this).find(".user-nav-popup").toggle();
		$(this).find(".icon-caret-down").toggleClass('caret-hide');
		$(this).find(".icon-caret-up").toggleClass('caret-hide');		
	});	

	$("#user-notifications").click(function(e){
		$(".user-nav-popup").hide();
		$(this).find(".user-notify-popup").toggle();
		
	});


	$('.switch-record').click(function() {
		$(this).next().toggle();
		$(this).find(".icon").toggleClass("icon-chevron-down", 1);
		$(this).find(".icon").toggleClass("icon-chevron-up", 0);
	});

	$('.how-it-works').click(function(e) {
          e.preventDefault();
	  $('#how-it-works').reveal();
    });

    $('.send-message').click(function(e) {
          e.preventDefault();
	  $('#send_message').reveal();
    });

    $('.add-conditions').click(function(e) {
          e.preventDefault();
	  $('#add-conditions').reveal();
    });

	$('.add-symptoms').click(function(e) {
          e.preventDefault();
	  $('#add-symptoms').reveal();
    });

	$('.add-treatments').click(function(e) {
          e.preventDefault();
	  $('#add-treatments').reveal();
    });


	(function($) {
	    
	  var allPanels = $('.accordion dd').hide();
	  var allPanelHeaders = $('.accordion dt > h4');
	  var allPanelIcons = $('.accordion h4 > span');
	    
	  $('.accordion dt > h4').click(function() {
	      $this = $(this);
	      $target =  $this.parent().next();	      
	      $icon = $this.find('.icon');

	      if (!$this.hasClass('active')){
	      	allPanelHeaders.removeClass('active');
	        $this.addClass('active');

	      	allPanelIcons.removeClass("icon-chevron-up");
	      	allPanelIcons.addClass("icon-chevron-down");

	      	$icon.removeClass("icon-chevron-down");
	      	$icon.addClass("icon-chevron-up");

	      } 

	      if(!$target.hasClass('active')){
	         allPanels.removeClass('active').slideUp();
	         $target.addClass('active').slideDown();
	      }	      
	      
	    return false;
	  });

	})(jQuery);

	$('.settings').click(function() {
		$(".slidediv").slideToggle();
	});

});





