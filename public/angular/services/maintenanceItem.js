'use strict';

/*
 * Service to handle the REST calls for maintenance items
 */
homebinderServices.factory('MaintenanceItem',['$http', 'Binder',
	function($http, Binder) {
		return {
			all: function() {
				return $http.get('/api/v1/maintenance_items?binder_id=' + Binder.getCurrent().id);
			},
			get: function(itemId) {
				return $http.get('/api/v1/maintenance_items/' + itemId);
			},
			create: function(item) {
				return $http.post('/api/v1/maintenance_items/', {maintenance_item: item});
			},
			update: function(itemId, item) {
				return $http.put('/api/v1/maintenance_items/' + itemId, {maintenance_item: item});
			},
			destroy: function(itemId) {
				return $http.delete('/api/v1/maintenance_items/' + itemId);
			}
		};
	}]);
	
/*
 * Service to handle the REST calls for maintenance cyle
 */
homebinderServices.factory('MaintenanceCycle',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/maintenance_cycles');
			}
		};
	}]);
	