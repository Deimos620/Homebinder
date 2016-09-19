/*
 * Service to make REST calls for appliances
 */
homebinderServices.factory('Appliance',['$http', 'Binder',
	function($http, Binder) {
		return {
			all: function() {
				return $http.get('/api/v1/appliances?binder_id=' + Binder.getCurrent().id);
			},
			get: function(applianceId) {
				return $http.get('/api/v1/appliances/' + applianceId);
			},
			create: function(appliance) {
				return $http.post('/api/v1/appliances/', {appliance: appliance});
			},
			update: function(applianceId, appliance) {
				return $http.put('/api/v1/appliances/' + applianceId, {appliance: appliance});
			},
			destroy: function(applianceId) {
				return $http.delete('/api/v1/appliances/' + applianceId);
			}
		};
	}]);
	
/*
 * Service to make REST calls for appliance manufacturers
 */
homebinderServices.factory('ApplianceManufacturer',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/appliance_manufacturers/');
			}
		};
	}]);
	
/*
 * Service to make REST calls for appliance models
 */
homebinderServices.factory('ApplianceModel',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/appliance_models/');
			}
		};
	}]);