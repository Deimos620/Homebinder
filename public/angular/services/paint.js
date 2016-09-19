'use strict';

/*
 * Service to make REST calls for paints
 */
homebinderServices.factory('Paint',['$http', 'Binder',
	function($http, Binder) {
		return {
			all: function() {
				return $http.get('/api/v1/paints?binder_id=' + Binder.getCurrent().id);
			},
			get: function(paintId) {
				return $http.get('/api/v1/paints/' + paintId);
			},
			create: function(paint) {
				return $http.post('/api/v1/paints/', {paint: paint});
			},
			update: function(paintId, paint) {
				return $http.put('/api/v1/paints/' + paintId, {paint: paint});
			},
			destroy: function(paintId) {
				return $http.delete('/api/v1/paints/' + paintId);
			}
		};
	}]);
	
homebinderServices.factory('PaintManufacturer',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/paint_manufacturers/');
			}
		};
	}]);
	
homebinderServices.factory('PaintType',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/paint_types/');
			}
		};
	}]);