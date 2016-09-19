/*
 * Service to make REST calls for notes
 */
homebinderServices.factory('Note',['$http',
	function($http) {
		return {
			all: function(resourceType, resourceId) {
				return $http.get('/api/v1/' + resourceType + 's/' + resourceId + '/notes');
			},
			get: function(resourceType, resourceId, noteId) {
				return $http.get('/api/v1/' + resourceType + 's/' + resourceId + '/notes/' + noteId);
			},
			create: function(resourceType, resourceId, note) {
				return $http.post('/api/v1/' + resourceType + 's/' + resourceId + '/notes/', note);
			},
			update: function(resourceType, resourceId, note) {
				return $http.put('/api/v1/' + resourceType + 's/' + resourceId + '/notes/' + note.note.id, note);
			},
			destroy: function(resourceType, resourceId, noteId) {
				return $http.delete('/api/v1/' + resourceType + 's/' + resourceId + '/notes/' + noteId);
			}
		};
	}]);