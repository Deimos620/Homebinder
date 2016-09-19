/*
 * Service to make REST calls for config
 */
homebinderServices.factory('Config',['$http',
	function($http) {
		var config;
		var api_key = 'b3e6f2e29d67494882a48cc1f26579fa';
		return {
			load: function() {
				return $http.get('/api/v1/config/').success(function(result){
					config = result;
				});
			},
			getApiKey: function() {
				return api_key;
			},
			getS3: function() {
				return config == undefined ? undefined : config['s3'];
			},
			getStripe: function() {
				return config == undefined ? undefined : config['stripe'];
			}
		};
	}]);