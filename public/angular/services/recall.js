/*
 * Service to handle the REST calls for recalls
 */
homebinderServices.factory('Recall',['$http',
	function($http) {
		return {
			all: function(applianceId, page) {
				var url = '/api/v1/recalls?appliance_id=' + applianceId;
				if (page) {
					url += '&page=' + page;
				}
				return $http.get(url);
			}
		};
	}]);