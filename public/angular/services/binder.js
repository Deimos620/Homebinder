/*
 * Service to make REST calls for binders
 */
homebinderServices.factory('Binder', ['$http', '$rootScope', 'Session', 'Errors',
	function($http, $rootScope, Session, Errors) {
		var binders = [];
		var currentBinder;
		
		function clearCurrentBinder() {
			currentBinder = undefined;
		}
		
		function setCurrentBinder(binder) {
			if (binder == undefined) {
				Session.clearBinder();
				clearCurrentBinder();
			} else {
				currentBinder = binder;
				Session.setBinder(binder);
				$rootScope.$broadcast('binder.selected');
			}
		}
		
		$rootScope.$on('user.logoff', function() {
			clearCurrentBinder();
			binders.length = 0;
		});
		
		return {
			init: function() {
				setCurrentBinder(Session.getBinder());	
			},
			all: function() {
				return $http.get('/api/v1/binders/').success(
					function(result) {
						binders = result;
						$rootScope.$broadcast('binder.all');
					});
			},
			get: function(binderId) {
				return $http.get('/api/v1/binders/' + binderId);
			},
			create: function(binder) {
				return $http.post('/api/v1/binders', {binder: binder});
			},
			update: function(binderId, binder) {
				return $http.put('/api/v1/binders/' + binderId, {binder: binder});
			},
			destroy: function(binderId) {
				return $http.delete('/api/v1/binders/' + binderId);
			},
			binders: function() {
				return binders;
			},
			getCurrent: function() {
				return currentBinder;
			},
			setCurrent: function(binder) {
				setCurrentBinder(binder);
			}
		};
	}]);

/*
 * Service to make REST calls for property types
 */
homebinderServices.factory('PropertyType', ['$http', 
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/property_types/');
			}
		};
	}]);