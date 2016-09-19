 /*
 * Service to make REST calls for binder resources
 */
homebinderServices.factory('Receipt',['$http', 'Binder',
	function($http, Binder) {
		return {
			all: function() {
                return $http.get('/api/v1/receipts?binder_id=' + Binder.getCurrent().id);
			},
			get: function(id) {
				return $http.get('/api/v1/receipts/' + id);
			},
			create: function(receipt) {
				return $http.post('/api/v1/receipts/', {receipt: receipt});
			},
			update: function(id, receipt) {
				return $http.put('/api/v1/receipts/' + id, {receipt: receipt});
			},
			destroy: function(id) {
				return $http.delete('/api/v1/receipts/' + id);
			}
		};
	}]);