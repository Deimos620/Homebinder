/*
 * Service to handle the REST calls for projects
 */
homebinderServices.factory('Project',['$http', 'Binder',
	function($http, Binder) {
		return {
			all: function() {
				return $http.get('/api/v1/projects?binder_id=' + Binder.getCurrent().id);
			},
			get: function(projectId) {
				return $http.get('/api/v1/projects/' + projectId);
			},
			create: function(project) {
				return $http.post('/api/v1/projects/', {project: project});
			},
			update: function(projectId, project) {
				return $http.put('/api/v1/projects/' + projectId, {project: project});
			},
			destroy: function(projectId) {
				return $http.delete('/api/v1/projects/' + projectId);
			}
		};
	}]);
	
/*
 * Service to handle the REST calls for project types
 */
homebinderServices.factory('ProjectType',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/project_types/');
			}
		};
	}]);

/*
 * Service to handle the REST calls for project statuses
 */
homebinderServices.factory('ProjectStatus',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/project_statuses/');
			}
		};
	}]);