homebinderControllers.controller('FinishFormCtrl', ['$scope', 'AppContext', 'Finish', 'FinishMake', 'FinishModel',
	function($scope, AppContext, Finish, FinishMake, FinishModel) {
		$scope.typeahead = {};
		FinishMake.all().then(
			function(result) {
				$scope.typeahead.makes = result.data;
			}
		);
		FinishModel.all().then(
			function(result) {
				$scope.typeahead.models = result.data;
			}
		);
		$scope.submitForm = function() {
			$scope.clearFormErrors();
				
			if ($scope.data.form.id == undefined) {
				Finish.create({"finish" : $scope.data.form}).then(
					function(result) {
						$scope.views.activeForm = null;
						$scope.refresh();
					},
					function(error) {
						$scope.processErrors(error);
					}
				);
			} else {
				Finish.update({"finish" : $scope.data.form}).then(
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