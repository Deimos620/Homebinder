'use strict';

var homebinderControllers = angular.module('homebinderControllers',[]);	

/*
 * Controller for the main application
 */
homebinderControllers.controller('AppCtrl', ['$scope', '$location', '$cookieStore',
	function($scope, $location, $cookieStore){
		console.log('AppCtrl');
	}]);

