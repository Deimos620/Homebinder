'use strict';

/*
 * Controller for the main application
 */
homebinderControllers.controller('UserProfileFormCtrl', ['$scope', '$location', 'UserProfile',
	function($scope, $location, UserProfile){
		$scope.data = {};
		$scope.datepicker = {};
		$scope.datepicker.format="yyyy-MM-dd";
		$scope.datepicker.options={ 'show-button-bar': false };
		
		// Set the view to show
		$scope.views = {};
		$scope.views.currentView = '/views/user_profiles/form.html';
		
		// Get the User Profile
		UserProfile.get().then(
			function(result) {
				$scope.data.form = result.data;
				$scope.data.form.address_attributes = $scope.data.form.address;
				delete $scope.data.form.address;

				// If there is no country set US
				if ($scope.data.form.address_attributes.country == undefined ||
					$scope.data.form.address_attributes.country == null) {
					$scope.data.form.address_attributes.country = 'US';
				}
			}
		);
		
		$scope.submitForm = function() {
			UserProfile.update({user_profile: $scope.data.form}).then(
				function(result) {
					$location.path('/user_profiles');
				},
				function(error) {
					console.log(error.data);
				}
			);
		};
	}]);