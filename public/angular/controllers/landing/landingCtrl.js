'use strict';

angular.module('homebinderApp')
.controller('LandingCtrl', [
    '$scope',
    function($scope){
	  	$scope.next = function(){
			$('.testimonials li:visible').delay(5000).fadeOut('slow',function(){
				$(this).appendTo('.testimonials ul');
				$('.testimonials li:first').fadeIn('slow',$scope.next);
	    	});
	   	}
	   	
	   	$scope.startTestimonials = function(){
	   	  var items = (Math.floor(Math.random() * ($('.testimonials li').length)));
	  	  $('.testimonials li').hide().eq(items).show();
	  	  
	  	  $scope.next();
	   	}
	
		// monitor animation
		setInterval(function(){
		  $(".post").toggleClass("display");
		}, 12000);
		
		// testimonial slideshow
		setTimeout($scope.startTestimonials, 1000);
}]);