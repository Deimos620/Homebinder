homebinderControllers.controller('RegistrationFormCtrl', ['$scope', '$location', 'User', 'AfterLoginService', 'Errors',
	function($scope, $location, User, AfterLoginService, Errors) {
		$scope.data = {};
		$scope.register = function() {
			$scope.data.errors = undefined;
			$scope.data.hasErrors = false;
			
			var register = {email: $scope.data.email, password: $scope.data.password};
			User.register(register).success(
				function(result){
					AfterLoginService.go();
				}).error(function(error) {
					$scope.data.errors = Errors.parseErrors(error);
					$scope.data.hasErrors = true;
				});
		};
	}]);