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
//= require jquery_nested_form
//= require reveal
//= require bootstrap
//= require jquery-plugins
//= require redactor-rails
//= require social-share-button
//= require_tree .


$(document).ready(function(){

	$("#load_more_content a").click(function(){
    	$("#load_more_link").hide();
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

	$(".user-nav").click(function(e){
		e.stopPropagation();
		$(this).find(".user-nav-popup").toggle();
		
	});	

	$('body').click(function() {
		$('.user-nav-popup:visible').fadeOut();

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

function setWidget(widget){
	widget.find('.widget-actions').hide();
	widget.find('.widget-setting').hide();

	widget.find('.widget-setting-link').click(function(e) {
		e.preventDefault();
		$(this).parents('.widget-actions').next().toggle();
	});

	widget.find('.panel').hover(function() {
		$(this).find('.widget-actions:hidden').toggle();     
	},function(){
		if( $(this).find('.widget-setting').is(':hidden') ) {
	  		$(this).find('.widget-actions').toggle();
		}
	});
}

// $(document).ready(function(){
//   //min font size
//   var min=11;

//   //max font size
//   var max=21;

//   var COOKIE_NAME = "Page-Fontsize";

//   // alert('current fontsize:'+$.cookie(COOKIE_NAME)+'px')

//   if ($.cookie(COOKIE_NAME)) {
//   	var fontsize =  parseFloat($.cookie(COOKIE_NAME), 10);  	
//   	$('body').css('font-size', fontsize);
//   } else {
//   	$.cookie(COOKIE_NAME, 14), { path: '/' };
//   }

//   // Reset Font Size
//   $(".resetFont").click(function(){
//     $('body').css('font-size', 14);
//     // $.cookie(COOKIE_NAME, 14);
//     $.removeCookie(COOKIE_NAME, { path: '/' });
//   });

//   // Increase Font Size
//   $(".increaseFont").click(function(){
//     var currentFontSize = $('body').css('font-size');
//     var currentFontSizeNum = parseFloat(currentFontSize, 10);
//     var newFontSize = currentFontSizeNum*1.1;
//     if (newFontSize <= max) {
//     	$('body').css('font-size', newFontSize);
//     	$.cookie(COOKIE_NAME, newFontSize);
//     }    	
//     // alert('after increase fontsize:'+$.cookie(COOKIE_NAME)+'px')
//     return false;
//   });

//   // Decrease Font Size
//   $(".decreaseFont").click(function(){
//     var currentFontSize = $('body').css('font-size');
//     var currentFontSizeNum = parseFloat(currentFontSize, 10);
//     var newFontSize = currentFontSizeNum*0.8;
//     if (newFontSize >= min){
//     	$('body').css('font-size', newFontSize);
//     	$.cookie(COOKIE_NAME, newFontSize);
//     }    
//     // alert('after derease fontsize:'+$.cookie(COOKIE_NAME)+'px')
//     return false;
//   });
// });