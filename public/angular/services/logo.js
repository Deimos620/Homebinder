/*
 * Service to make REST calls for logos
 */
homebinderServices.factory('Logo',['$http',
	function($http) {
		return {
			all: function(partnerId, tag) {
				var url = '/api/v1/logos?partner_id=' + partnerId;
				if (tag != undefined) {
					url += '&tag=' + tag;
				}
				return $http.get(url);
			},
			create: function(logo) {
				return $http.post('/api/v1/logos/', {logo: logo});
			},
			destroy: function(logoId) {
				return $http.delete('/api/v1/logos/' + logoId);
			}
		};
	}]);