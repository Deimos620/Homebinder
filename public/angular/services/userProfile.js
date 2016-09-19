'use strict';

/*
 * Service to handle the REST calls for user profiles
 */
homebinderServices.factory('UserProfile',['$http',
	function($http) {
		return {
			get: function() {
				return $http.get('/api/v1/user_profiles/');
			},
			update: function(profileId, profile) {
				return $http.put('/api/v1/user_profiles/' + profileId, {user_profile: profile});
			}
		};
	}]);