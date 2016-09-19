/*
 * Service to handle the REST calls for partners
 */
homebinderServices.factory('Partner',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/partners');
			},
			get: function(partnerId) {
				return $http.get('/api/v1/partners/' + partnerId);
			},
			create: function(partner) {
				return $http.post('/api/v1/partners/', {partner: partner});
			},
			update: function(partnerId, partner) {
				return $http.put('/api/v1/partners/' + partnerId, {partner: partner});
			},
			destroy: function(partnerId) {
				return $http.delete('/api/v1/partners/' + partnerId);
			}
		};
	}]);