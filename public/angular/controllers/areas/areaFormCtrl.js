homebinderControllers.controller('AreaFormCtrl', ['$scope', 'AppContext', 'Area', 'Structure', 'AreaType',
	function($scope, AppContext, Area, Structure, AreaType) {
		$scope.typeahead = {};
		AreaType.all().then(
			function(result) {
				$scope.typeahead.areaTypes = result.data;
			}
		);
		Structure.all(AppContext.getCurrentBinderId()).then(
			function(result) {
				$scope.options = {};
				$scope.options.structures = result.data;
			}
		);
		$scope.submitForm = function() {
			$scope.clearFormErrors();
				
			if ($scope.data.form.id == undefined) {
				Area.create({"area" : $scope.data.form}).then(
					function(result) {
						$scope.views.activeForm = null;
						$scope.refresh();
					},
					function(error) {
						$scope.processErrors(error);
					}
				);
			} else {
				Area.update({"area" : $scope.data.form}).then(
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