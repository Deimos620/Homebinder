/*
 * Controller for password reset
 */
homebinderControllers.controller('PasswordResetFormCtrl', ['$scope', '$location', 'User',
	function($scope, $location, User) {
		$scope.data = {};
		$scope.submit = function() {
			User.resetPassword($scope.data.email).success(function(result){
				$location.path('/passwords/reset_sent');
			}).error(function(error) {
				$scope.data.error = error;
			});
		};
	}]);