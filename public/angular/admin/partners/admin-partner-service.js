'use strict';

angular.module('Homebinder.Admin')
.factory('AdminPartnerService',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/admin/partners');
			},
			get: function(partnerId) {
				return $http.get('/admin/partners/' + partnerId);
			},
			create: function(partner) {
				return $http.post('/admin/partners/', {partner: partner});
			},
			update: function(partnerId, partner) {
				return $http.put('/admin/partners/' + partnerId, {partner: partner});
			},
			destroy: function(partnerId) {
				return $http.delete('/admin/partners/' + partnerId);
			}
		};
	}]);