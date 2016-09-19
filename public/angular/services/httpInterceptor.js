homebinderApp.config(['$httpProvider', function($httpProvider) { 
	$httpProvider.interceptors.push(function($q, $location, $injector) {
    	return {
      		'responseError': function(rejection) {
				if (rejection.status == 401) {
					if ($location.path() != '/login') {
						$location.path('/login');
					}
				} else if (rejection.status == 403) {
					$location.path('/forbidden');
					console.log(rejection.data);
				} else if (rejection.status == 500) {
					// Display an error message here
					$location.path('/internal_error');
					console.log(rejection.data);
				}
				return $q.reject(rejection);
		    }
		};
	});
}]);