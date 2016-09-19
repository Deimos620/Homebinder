/*
 * Directive 
 */
homebinderDirectives.directive('accountMaster', function() {
	return {
		restrict: 'E',
		transclude: true,
		templateUrl: '/angular/views/directives/accountMaster.html',
		scope: {
			selectedTab: '='
		},
		controller: function($scope, $element, $attrs, $injector) {
			$scope.nav = {};
			
			// Get the services we need
			
			function setTab() {
				if ($scope.selectedTab == "user_profiles") {
					$scope.nav.profileClass = 'active';
				} else if ($scope.selectedTab == "shares") {
					$scope.nav.sharesClass = 'active';
				} else if ($scope.selectedTab == "subscriptions") {
					$scope.nav.subscriptionsClass = 'active';	
				}
			}

			setTab();
		}
	};
});