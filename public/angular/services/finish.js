/*
 * Service to make REST calls for finishes
 */
homebinderServices.factory('Finish',['$http', 'Binder',
	function($http, Binder) {
		return {
			all: function() {
				return $http.get('/api/v1/finishes?binder_id=' + Binder.getCurrent().id);
			},
			get: function(finishId) {
				return $http.get('/api/v1/finishes/' + finishId);
			},
			create: function(finish) {
				return $http.post('/api/v1/finishes/', {finish: finish});
			},
			update: function(finishId, finish) {
				return $http.put('/api/v1/finishes/' + finishId, {finish: finish});
			},
			destroy: function(finishId) {
				return $http.delete('/api/v1/finishes/' + finishId);
			}
		};
	}]);
	
/*
 * Service to make REST calls for finish makes
 */
homebinderServices.factory('FinishMake',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/finish_makes');
			}
		};
	}]);
	
/*
 * Service to make REST calls for finish makes
 */
homebinderServices.factory('FinishModel',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/finish_models');
			}
		};
	}]);