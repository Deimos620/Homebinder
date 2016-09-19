'use strict';

homebinderControllers.controller('ApplianceFormCtrl', ['$scope', 'AppContext', 'Appliance', 'ApplianceManufacturer',
	function($scope, AppContext, Appliance, ApplianceManufacturer) {
		$scope.typeahead = {};
		ApplianceManufacturer.all().then(
			function(result) {
				$scope.typeahead.manufacturers = result.data;
			}
		);
		$scope.submitForm = function() {
			$scope.clearFormErrors();
				
			if ($scope.data.form.id == undefined) {
				Appliance.create({"appliance" : $scope.data.form}).then(
					function(result) {
						$scope.views.activeForm = null;
						$scope.refresh();
					},
					function(error) {
						$scope.processErrors(error);
					}
				);
			} else {
				Appliance.update({"appliance" : $scope.data.form}).then(
					function(result) {
						$scope.views.activeForm = null;
						$scope.refresh();
					},
					function(error) {
						$scope.processErrors(error);
					}
				);
			}
		};
		$scope.cancelForm = function() {
			$scope.views.activeForm = null;
		};
	}]);