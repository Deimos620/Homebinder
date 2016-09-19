/*
 * Service to make REST calls for stores
 */
homebinderServices.factory('Store',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/stores/');
			}
		};
	}]);