/*
 * Service to make REST calls for areas
 */
homebinderServices.factory('Area',['$http', 'Binder',
	function($http, Binder) {
		return {
			all: function() {
				return $http.get('/api/v1/areas?binder_id=' + Binder.getCurrent().id);
			},
			get: function(areaId) {
				return $http.get('/api/v1/areas/' + areaId);
			},
			create: function(area) {
				return $http.post('/api/v1/areas/', {area: area});
			},
			update: function(areaId, area) {
				return $http.put('/api/v1/areas/' + areaId, {area: area});
			},
			destroy: function(areaId) {
				return $http.delete('/api/v1/areas/' + areaId);
			}
		};
	}]);
	
/*
 * Service to make REST calls for area types
 */
homebinderServices.factory('AreaType',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/area_types/');
			}
		};
	}]);
