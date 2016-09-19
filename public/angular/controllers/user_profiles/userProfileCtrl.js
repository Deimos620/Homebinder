/*
 * Controller for user profile
 */
homebinderControllers.controller('UserProfileCtrl', ['$scope', 'UserProfile', 'User', 'Address',
	function($scope, UserProfile, User, Address){
		$scope.selectedTab = "user_profiles";
		$scope.profile = {};
		$scope.options = {};
		$scope.options.countries = Address.countries();
		$scope.options.subregions = Address.getSubregions('US');
		
		$scope.save = function() {
			var data = $scope.data;
			var id = data.id;
			data.address_attributes = data.address;
			delete data.id;
			delete data.address;
			
			UserProfile.update(id, data).success(
				function(result){
					$scope.data = result;
				}).error(
				function(error) {
					$scope.$broadcast('resource.error', error);
				});
		};
		
		$scope.refresh = function() {
			UserProfile.get().then(
				function(result) {
					$scope.data = result.data;
				});
		};
		
		$scope.$on('user.logon', function(){
			$scope.refresh();
		});
		
		if (User.isLoggedOn())
			$scope.refresh();
	}]);