'use strict';

angular.module('Homebinder.Admin')
.controller('Admin.UserRoleAssignCtrl', [
   '$scope',
   '$window',
   function($scope, $window){
		$scope.form = {};
		$scope.form.action = 'add';
		$scope.partner_code_required = false;
		$scope.$watch('form.role_name', function(newValue, oldValue){
			$scope.partner_code_required = $scope.form.role_name == 'broker';
		});
		$scope.submit = function() {
			var role = {
				action: $scope.form.action,
				apply_to: $scope.form.apply_to,
				role_name: $scope.form.role_name,
				partner_code: $scope.form.partner_code
			};
			
			if (role.apply_to == undefined) {
				$scope.form.errors = "Enter the user's email";
			} else if (role.role_name == undefined) {
				$scope.form.errors = "Select a role";
			}
			
			if (role.role_name == 'broker' && role.partner_code == undefined)
			{
				$scope.form.errors = 'Enter the partner code';
			}
			
			if ($scope.form.errors != undefined) {
				return;
			}
			
			$scope.form.errors = undefined;
			UserRole.create(role).success(function(result){
				$window.history.back();
			}).error(function(error){
				$scope.form.errors = error;
			});
		};
		$scope.cancel = function(){
			$window.history.back();
		};
}]);