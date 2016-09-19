/*
 * Service to make REST calls for shares
 */
homebinderServices.factory('Share',['$http',
	function($http) {
		return {
			all: function(resourceType, resourceId) {
				return $http.get('/api/v1/' + resourceType + 's/' + resourceId + '/shares');
			},
			sharedBy: function() {
				return $http.get('/api/v1/shares?shared_by=x');
			},
			sharedWith: function() {
				return $http.get('/api/v1/shares?shared_with=x');
			},
			get: function(shareId) {
				return $http.get('/api/v1//shares/' + shareId);
			},
			create: function(resourceType, resourceId, share) {
				return $http.post('/api/v1/' + resourceType + 's/' + resourceId + '/shares/', {share: share});
			},
			update: function(shareId, share) {
				return $http.put('/api/v1/shares/' + shareId, {share: share});
			},
			destroy: function(shareId) {
				return $http.delete('/api/v1/shares/' + shareId);
			}
		};
	}]);
	