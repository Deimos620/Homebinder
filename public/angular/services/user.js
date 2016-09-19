/*
 * Service to make REST calls for binders
 */
homebinderServices.factory('User',
[
	'$http',
	'$rootScope',
	'$injector',
	'Errors',
    //'Intercom',
	function($http, $rootScope, $injector, Errors/*, Intercom*/) {
		var Session = $injector.get('Session');
		var $window = $injector.get('$window');
		function setCurrentUser(jwt) {
			var user = angular.fromJson($window.atob(jwt.split('.')[1]));
			Session.setJwt(jwt);
			Session.setUser(user);
			$http.defaults.headers.common['HB-UserToken'] = jwt;
			$rootScope.$broadcast('user.logon');
		}
		return {
			init: function() {
				// Try and get the JWT token from storage. If it doesn't exist
				// we're done. The user must logon again.
				var jwt = Session.getJwt();
				if (jwt) {
					setCurrentUser(jwt);
				}
			},
			logon: function(logonData) {
				return $http.post('/api/v1/user_tokens', {email: logonData.email, password: logonData.password}).success(
					function(result) {
						setCurrentUser(result);

                        // tract user logon with intercom
						/*
                        if(Session.getUser().user_role == "user")
                            Intercom.boot({
                                email: Session.getUser().email,
                                created_at: new Date().getTime(),
                                app_id: "1za6ik5d"
                            });
							*/
					});
			},
			logoff: function() {
				// Get the authentication token of the user
				var utoken = Session.getUser().user_token;

                // tract user logoff with intercom
				/*
                if(Session.getUser().user_role == "user")
                    Intercom.shutdown();
					*/
				
				// Clear the storage info
				Session.clearAll();
				
				// Delete the session
				return $http.delete('/api/v1/user_tokens/' + utoken).then(
					function(result) {
						delete $http.defaults.headers.common['HB-UserToken'];
						$rootScope.$broadcast('user.logoff');
					}
				);
			},
			register: function(user) {
				return $http.post('/api/v1/registrations', {user: user}).success(
					function(result){
						setCurrentUser(result);

                        // tract user logon with intercom
						/*
                        if(Session.getUser().user_role == "user")
                            Intercom.boot({
                                email: Session.getUser().email,
                                created_at: new Date().getTime(),
                                app_id: "1za6ik5d"
                            });
							*/
				});
			},
			resetPassword: function(email) {
				return $http.post('/api/v1/passwords', {user: {email: email}});
			},
			updatePassword: function(data) {
				return $http.put('/api/v1/passwords/update', {user: data}).success(
					function(result) {
						setCurrentUser(result);
					});
			},
			current: function() {
				return Session.getUser();
			},
			isLoggedOn: function() {
				return Session.getUser();
			}
		};
	}]);