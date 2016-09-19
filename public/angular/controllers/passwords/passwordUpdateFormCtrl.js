/*
 * Controller for password reset
 */
homebinderControllers.controller('PasswordUpdateFormCtrl',
[
	'$scope',
	'$location',
	'$routeParams',
	'User',
	'AfterLoginService',
	function($scope, $location, $routeParams, User, AfterLoginService) {
		$scope.data = {};
		$scope.submit = function() {
			var token = $routeParams.token;
			var data = {
				reset_password_token: token,
				password: $scope.data.password,
				confirm_password: $scope.data.password
			};
			User.updatePassword(data).success(function(result){
				AfterLoginService.go();
			}).error(function(error){
				$scope.data.error = error;
			});
		};
	}]);