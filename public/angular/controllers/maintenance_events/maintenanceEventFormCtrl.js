homebinderControllers.controller('MaintenanceEventFormCtrl', ['$scope', 'AppContext', 'MaintenanceEvent', 'BinderContractor',
	function($scope, AppContext, MaintenanceEvent, BinderContractor) {
		$scope.options = {};
		$scope.datepicker = {};
		$scope.datepicker.format="yyyy-MM-dd";
		$scope.datepicker.options={ 'show-button-bar': false };
		BinderContractor.all(AppContext.getCurrentBinderId()).then(
			function(result) {
				$scope.options.contractors = new Array();
				for (var k = 0; k < result.data.length; k++) {
					var bc = result.data[k];
					$scope.options.contractors.push({ id : bc.contractor.id, name : bc.contractor.name });
				}
			}
		);
		$scope.submitForm = function() {
			$scope.clearFormErrors();
			// The ResourceListCtrl adds a binder_id by default. We need to remove it here
			if ($scope.data.form.binder_id != undefined)
				delete $scope.data.form.binder_id;
				
			if ($scope.data.form.id == undefined) {
				MaintenanceEvent.create($scope.data.form).then(
					function(result) {
						$scope.views.activeForm = null;
						$scope.refresh();
					},
					function(error) {
						$scope.processErrors(error);
					}
				);
			} else {
				MaintenanceEvent.update($scope.data.form).then(
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