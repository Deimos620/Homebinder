homebinderControllers.controller('MaintenanceItemFormCtrl', ['$scope', 'AppContext', 'MaintenanceItem', 'MaintenanceCycle',
	function($scope, AppContext, MaintenanceItem, MaintenanceCycle) {
		$scope.options = {};
		$scope.datepicker = {};
		$scope.datepicker.format="yyyy-MM-dd";
		$scope.datepicker.options={ 'show-button-bar': false };
		MaintenanceCycle.all().then(
			function(result) {
				$scope.options.cycles = result.data;
			}
		);
		$scope.submitForm = function() {
			$scope.clearFormErrors();
				
			if ($scope.data.form.id == undefined) {
				MaintenanceItem.create({"maintenance_item" : $scope.data.form}).then(
					function(result) {
						$scope.views.activeForm = null;
						$scope.refresh();
					},
					function(error) {
						$scope.processErrors(error);
					}
				);
			} else {
				MaintenanceItem.update({"maintenance_item" : $scope.data.form}).then(
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