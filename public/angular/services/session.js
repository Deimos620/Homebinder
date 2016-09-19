/*
 * Service to handle the REST calls for sessions
 */
homebinderServices.factory('Session',['$window',
	function($window) {
		var JWT_TOKEN = "_hb.twj";
		var USER = "_hb.user";
		var BINDER = "_hb.binder";
		
		function setValue(key, value, remember) {
			// Set the value to session storage
			$window.sessionStorage[key] = JSON.stringify(value);
			
			// If we want to remember it set it to local storage as well
			if (remember) {
				$window.localStorage[key] = JSON.stringify(value);
			}
		}
		function getValue(key) {
			var value = $window.sessionStorage[key];
			if (value)
				return JSON.parse(value);
			value = $window.localStorage[key];
			return value ? JSON.parse(value) : undefined;
		}
		function clearValue(key) {
			$window.sessionStorage.removeItem(key);
			$window.localStorage.removeItem(key);
		}
		function clearAll() {
			$window.sessionStorage.clear();
			$window.localStorage.clear();
		}
		
		return {
			setJwt: function(jwt, remember) {
				setValue(JWT_TOKEN, jwt, remember);
			},
			getJwt: function(jwt) {
				return getValue(JWT_TOKEN);
			},
			setUser: function(user, remember) {
				setValue(USER, user, remember);
			},
			getUser: function() {
				return getValue(USER);
			},
			clearUser: function() {
				clearValue(USER);
			},
			setBinder: function(binder) {
				setValue(BINDER, binder, false);
			},
			getBinder: function() {
				return getValue(BINDER);
			},
			clearBinder: function() {
				clearValue(BINDER);
			},
			clearAll: function() {
				clearAll();
			}
		};
	}]);