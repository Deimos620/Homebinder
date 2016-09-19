/*
 * Service to make REST calls for user_roles
 */
homebinderServices.factory('UserRole',['$http', 'Binder',
	function($http, Binder) {
		return {
			create: function(role_info) {
				return $http.post('/api/v1/user_roles/', {role: role_info});
			}
		};
	}]);