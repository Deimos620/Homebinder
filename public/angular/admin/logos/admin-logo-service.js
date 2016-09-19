'use strict';

angular.module('Homebinder.Admin')
.factory('AdminLogoService',[
	'$http',
	function($http) {
		return {
			all: function(partnerId, tag) {
				var url = '/admin/logos?partner_id=' + partnerId;
				if (tag != undefined) {
					url += '&tag=' + tag;
				}
				return $http.get(url);
			},
			create: function(logo) {
				return $http.post('/admin/logos/', {logo: logo});
			},
			destroy: function(logoId) {
				return $http.delete('/admin/logos/' + logoId);
			}
		};
	}]);