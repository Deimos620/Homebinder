homebinderServices.factory('Transfer',['$http',
	function($http) {
		return {
			create: function(transfer) {
				return $http.post('/api/v1/transfers/', {transfer: transfer});
			}
		};
	}]);