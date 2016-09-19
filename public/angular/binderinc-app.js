'use strict';

angular.module('BinderInc.App', [
	'ngRoute',
	'ngCookies',
	'ngSanitize',
	'ui.bootstrap',
    'ui.router',
	'xeditable',
	'checklist-model',
	'plupload.module',
    'BinderInc.Home'])
.config([
    '$stateProvider',
    '$urlRouterProvider',
    function($urlRouterProvider){
        // The default route is home
        $urlRouterProvider.otherwise('/');
        
        $stateProvider
            .state('home', {
                url: '/',
                templateUrl: '/angular/common/static/views/landing.html'
            })
            .state('home2', {
                url: '/home',
                templateUrl: '/angular/common/static/views/landing_v1.html'
            })
            .state('login', {
                url: '/login',
                templateUrl: '/angular/common/account/views/login.html',
                controller: 'BinderInc.LoginCtrl'
            })
            .state('register', {
                url: '/register',
                templateUrl: '/angular/common/account/views/register.html',
                controller: 'BinderInc.RegisterCtrl'
            })
            .state('change-password', {
                url: '/change-password',
                templateUrl: '/angular/common/account/views/change-password.html',
                controller: 'BinderInc.ChangePasswordCtrl'
            })
            .state('update-password', {
                url: '/update-password',
                templateUrl: '/angular/common/account/views/update-password.html',
                controller: 'BinderInc.UpdatePasswordCtrl'
            })
            .state('privacy', {
                url: '/privacy',
                templateUrl: '/angular/common/static/views/privacy.html'
            })
            .state('terms', {
                url: '/terms',
                templateUrl: '/angular/common/static/views/terms.html'
            })
            .state('401', {
                url: '/401',
                templateUrl: '/angular/common/static/views/401.html'
            })
            .state('403', {
                url: '/403',
                templateUrl: '/angular/common/static/views/403.html'
            })
            .state('404', {
                url: '/404',
                templateUrl: '/angular/common/static/views/404.html'
            })
            .state('422', {
                url: '/422',
                templateUrl: '/angular/common/static/views/422.html'
            })
            .state('500', {
                url: '/500',
                templateUrl: '/angular/common/static/views/500.html'
            })
}])
.run(['$state', function($state) {
    $state.go('home-signed-in.binders');
}]);