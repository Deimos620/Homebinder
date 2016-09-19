/*
 * Service to handle the REST calls for maintenance events
 */
homebinderServices.factory('MaintenanceEvent',['$http',
	function($http) {
		return {
			all: function(forMaintenanceItem) {
				return $http.get('/api/v1/maintenance_events?maintenance_item_id=' + forMaintenanceItem);
			},
			get: function(eventId) {
				return $http.get('/api/v1/maintenance_events/' + eventId);
			},
			create: function(maintenanceEvent) {
				return $http.post('/api/v1/maintenance_events/', {maintenance_event: maintenanceEvent});
			},
			update: function(maintenanceEventId, maintenanceEvent) {
				return $http.put('/api/v1/maintenance_events/' + maintenanceEventId, {maintenance_event: maintenanceEvent});
			},
			destroy: function(eventId) {
				return $http.delete('/api/v1/maintenance_events/' + eventId);
			}
		};
	}]);