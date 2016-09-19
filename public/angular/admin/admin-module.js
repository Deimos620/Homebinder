'use strict';

angular.module('Homebinder.Admin',[
'ngRoute',
'plupload.module'])
.config(function($routeProvider){
    $routeProvider
		.when('/admin', {
			templateUrl: '/angular/admin/admin.html',
			caseInsensitiveMatch: true
		})
        .when('/admin/users/', {
            templateUrl: '/angular/admin/users/views/users.html',
			controller: 'Admin.UsersCtrl',
			caseInsensitiveMatch: true
		})
		.when('/admin/partners/', {
			templateUrl: '/angular/admin/partners/views/partners.html',
			controller: 'Admin.PartnersCtrl',
			caseInsensitiveMatch: true
		})
		.when('/admin/partners/new',{
			templateUrl: '/angular/admin/partners/views/partner-form.html',
			controller: 'Admin.PartnerFormCtrl',
			caseInsensitiveMatch: true
		})
		.when('/admin/partners/:partnerId/edit', {
			templateUrl: '/angular/admin/partners/views/partner-form.html',
			controller: 'Admin.PartnerFormCtrl',
			caseInsensitiveMatch: true
		})
		.when('/admin/partners/:partnerId', {
			templateUrl: '/angular/admin/partners/views/partner.html',
			controller: 'Admin.PartnerCtrl',
			caseInsensitiveMatch: true
		})
        .when('/admin/user-roles/assign', {
			templateUrl: '/angular/admin/user-roles/views/user-role-assign-form.html',
            controller: 'Admin.UserRoleAssignCtrl',
			caseInsensitiveMatch: true
        })
        .when('/admin/seller-reports', {
            templateUrl: '/angular/admin/seller-reports/views/seller-reports.html',
            controller: 'Admin.SellerReportsCtrl',
			caseInsensitiveMatch: true
        })
});