/*
 * Service to make REST calls for contractors
 */
homebinderServices.factory('BinderContractor',['$http', 'Binder',
	function($http, Binder) {
		return {
			all: function() {
				return $http.get('/api/v1/binder_contractors?binder_id=' + Binder.getCurrent().id);
			},
			get: function(binderContractorId) {
				return $http.get('/api/v1/binder_contractors/' + binderContractorId);
			},
			create: function(binderContractor) {
				return $http.post('/api/v1/binder_contractors/', {binder_contractor: binderContractor});
			},
			update: function(binderContractorId, binderContractor) {
				return $http.put('/api/v1/binder_contractors/' + binderContractorId, {binder_contractor: binderContractor});
			},
			destroy: function(binderContractorId) {
				return $http.delete('/api/v1/binder_contractors/' + binderContractorId);
			}
		};
	}]);
	
/*
 * Service to make REST calls for contractor types
 */
homebinderServices.factory('ContractorType',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/contractor_types/');
			}
		};
	}]);