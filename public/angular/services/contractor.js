/*
 * Service to make REST calls for contractors
 */
homebinderServices.factory('Contractor',['$http',
	function($http) {
		return {
			get: function(id) {
				return $http.get('/api/v1/contractors/' + id);
			}
		};
	}]);
	