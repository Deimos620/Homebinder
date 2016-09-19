/*
 * Service to handle the REST calls for UserTokens
 */
homebinderServices.factory('UserToken',['$http',
	function($http) {
		return {
			create: function(credentials) {
				return $http.post('/api/v1/user_tokens', credentials);
			},
			destroy: function(token) {
				return $http.delete('/api/v1/user_tokens/' + token);
			}
		};
	}]);
