/*
 * Service to handle the REST calls for structures
 */
homebinderServices.factory('Structure',['$http', 'Binder',
	function($http, Binder) {
		return {
			all: function() {
				return $http.get('/api/v1/structures?binder_id=' + Binder.getCurrent().id);
			},
			get: function(structureId) {
				return $http.get('/api/v1/structures/' + structureId);
			},
			create: function(structure) {
				return $http.post('/api/v1/structures/', {structure: structure});
			},
			update: function(structureId, structure) {
				return $http.put('/api/v1/structures/' + structureId, {structure: structure});
			},
			destroy: function(structureId) {
				return $http.delete('/api/v1/structures/' + structureId);
			}
		};
	}]);
	
	
/*
 * Service to handle the REST calls for Construction Styles
 */
homebinderServices.factory('ConstructionStyle',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/construction_styles/');
			}
		};
	}]);
	
/*
 * Service to handle the REST calls for Construction Types
 */
homebinderServices.factory('ConstructionType',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/construction_types/');
			}
		};
	}]);
	
/*
 * Service to handle the REST calls for Heat Types
 */
homebinderServices.factory('HeatType',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/heat_types/');
			}
		};
	}]);
	
/*
 * Service to handle the REST calls for Heat Sources
 */
homebinderServices.factory('HeatSource',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/heat_sources/');
			}
		};
	}]);
