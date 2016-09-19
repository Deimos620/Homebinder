'use strict';

var homebinderApp = angular.module('homebinderApp', [
	'ngRoute',
	'ngCookies',
	'homebinderControllers',
	'ui.bootstrap',
	'ui.select2']);

homebinderApp.config(['$routeProvider',
	function($routeProvider){
		$routeProvider
			.when('/', {
				templateUrl: '/views/landing/landing.html'
			})
			.when('/login', {
				templateUrl: '/views/sessions/login.html',
				controller: 'LoginCtrl'
			})
			.when('/binders', {
				templateUrl: '/views/binders/binders.html',
				controller: 'BindersCtrl'
			})
			.when('/binders/new', {
				templateUrl: '/views/binders/new.html',
				controller: 'BindersCtrl'
			})
			.when('/binders/:binderId/edit', {
				templateUrl: '/views/binders/edit.html',
				controller: 'BindersCtrl'
			})
			.when('/binders/:binderId', {
				templateUrl: '/views/binders/binder.html',
				controller: 'BinderCtrl'
			})
			.when('/binders/:binderId/structures', {
				templateUrl: '/views/structures/index.html'
			})
			.when('/binders/:binderId/areas', {
				templateUrl: '/views/areas/index.html'
			})
			.when('/binders/:binderId/maintenance_items', {
				templateUrl: '/views/maintenance_items/index.html'
			})
			.when('/maintenance_items/:maintenanceItemId/maintenance_events', {
				templateUrl: '/views/maintenance_events/index.html'
			})
			.when('/binders/:binderId/projects', {
				templateUrl: '/views//projects/index.html'
			})
			.when('/binders/:binderId/binder_contractors', {
				templateUrl: '/views/binder_contractors/index.html'
			})
			.when('/binders/:binderId/appliances', {
				templateUrl: '/views/appliances/index.html'
			})
			.when('/binders/:binderId/finishes', {
				templateUrl: '/views/finishes/index.html'
			})
			.when('/binders/:binderId/paints', {
				templateUrl: '/views/paints/index.html'
			})
			.when('/binders/:binderId/inventory_items', {
				templateUrl: '/views/inventory_items/index.html'
			})
			.when('/user_profiles/', {
				templateUrl: '/views/user_profiles/show.html'
			})
			.when('/user_profiles/:profileId/edit', {
				templateUrl: '/views/user_profiles/edit.html'
			})
			.when('/shares/', {
				templateUrl: '/views/shares/index.html'
			})
			.when('/subscriptions/', {
				templateUrl: '/views/subscriptions/index.html'
			})
			.when('/account', {
				templateUrl: '/views/account/dashboard.html',
				controller: 'AccountDashboardCtrl'
			})
			.otherwise({
				redirectTo: '/binders'
			});
	}]);
/*
homebinderApp.config(['$httpProvider',
	function($httpProvider){
		var authToken = $("meta[name=\"csrf-token\"]").attr("content");
  		$httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken;
	}]);
*/
	