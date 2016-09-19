/*
 * Directive 
 */
homebinderDirectives.directive('applicationHeader', function() {
	return {
		restrict: 'E',
		templateUrl: '/angular/views/directives/applicationHeader.html',
		controller: function($scope, $element, $attrs, $injector) {
			var User = $injector.get('User');
			var Binder = $injector.get('Binder');
			var Share = $injector.get('Share');
			var $location = $injector.get('$location');
			var $modal = $injector.get('$modal');
			
			$scope.data = {};
			$scope.data.settings_tooltip = "Your Settings";
			
			function setCurrentUser() {
				$scope.data.user = User.current();
				$scope.data.is_admin = $scope.data.user == undefined ? undefined : $scope.data.user.global_role == 'admin';
			}
			
			function setPendingShares() {
				Share.sharedWith().then(
					function(result) {
						var count = 0;
						angular.forEach(result.data, function(share){
							if (share.status == 'pending')
							count++;
						});
						$scope.data.pending_shares = count;
						$scope.data.settings_tooltip = count == 0 ? "Your Settings" : "A binder(s) is being shared with you.";
					}
				);
			}
			
			function setBinders() {
				var binders = Binder.binders();
				if (binders) {
					$scope.data.binders = binders;
				} else {
					Binder.all().then(
						function(result) {
							$scope.data.binders = result.data;
						}
					);
				}
			}
			
			function setBinder() {
				$scope.data.binder = Binder.getCurrent();
			}
			
			$scope.$on('user.logon', function() {
				setCurrentUser();
				setPendingShares();
			});
			$scope.$on('binder.all', function() {
				setBinders();
			});
			$scope.$on('binder.selected', function() {
				setBinder();
			});
			$scope.$on('share.refresh', function() {
				setPendingShares();
			});
			$scope.logout = function() {
				User.logoff(function() {
					$location.path('/');
				});
			};
			$scope.roleManagement = function() {
				var modalInstance = $modal.open({
					templateUrl : "/angular/views/admin/user_roles/form.html",
					controller : 'UserRoleFormCtrl'
				});
			};
			$scope.selectBinder = function(binder) {
				Binder.setCurrent(binder);
				$location.path('/binders/' + binder.id);
			};
			
			setCurrentUser();
			setPendingShares();
			setBinders();
			setBinder();
		}
	};
});