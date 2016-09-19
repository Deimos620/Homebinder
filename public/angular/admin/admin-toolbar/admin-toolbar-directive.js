'use strict';

angular.module('Homebinder.Admin')
.directive('hbAdminToolbar', function() {
	return {
		restrict: 'E',
		templateUrl: '/angular/admin/admin-toolbar/views/admin-toolbar.html',
		controller: function($scope, $element, $attrs, $injector) {
			var User = $injector.get('User');
			var $location = $injector.get('$location');
			
			$scope.logout = function() {
				User.logoff(function() {
					$location.path('/');
				});
			};
		}
	};
});