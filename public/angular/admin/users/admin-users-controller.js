'use strict';

angular.module('Homebinder.Admin')
.controller('Admin.UsersCtrl', [
	'$scope',
	'$location',
	'AdminUserService',
	'User',
	function($scope, $location, AdminUserService, User) {
		$scope.data = {};
		$scope.sort = {};
		$scope.sort.column = 'id';
		$scope.sort.reverse = false;
		
		function refresh() {
			if (!User.isLoggedOn()) {
				return;
			}
			$scope.data.isBusy = true;
			AdminUserService.get().success(function(result){
				$scope.data.users = result;
				$scope.data.isBusy = false;
			}).error(function(error){
				$scope.data.isBusy = false;
			});
		}
		
		$scope.$on('user.logon', function() {
			refresh();
		});
		
		$scope.deleteUser = function(user) {
			if (confirm("Are you sure you want to delete the user - " + user.email + "? This action can not be undone.")){
				AdminUserService.destroy(user.id).success(function(success){
					for (var k = 0; k < $scope.data.users.length; k++) {
						if ($scope.data.users[k].id == user.id) {
							$scope.data.users.splice(k, 1);
							break;
						}
					}
				});
			}
		};
		
		$scope.orderBy = function(column) {
			if (column == $scope.sort.column) {
                $scope.sort.reverse = !$scope.sort.reverse;
                return;
            }
            
            $scope.sort.column = column;
            $scope.sort.reverse = false;	
		};
		
		refresh();
	}]);