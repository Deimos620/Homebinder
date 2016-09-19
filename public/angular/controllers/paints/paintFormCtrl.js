homebinderControllers.controller('PaintFormCtrl', ['$scope', 'AppContext', 'Paint', 'PaintManufacturer', 'PaintType', 'Area',
	function($scope, AppContext, Paint, PaintManufacturer, PaintType, Area) {
		$scope.typeahead = {};
		$scope.options = {};
		PaintManufacturer.all().then(
			function(result) {
				$scope.typeahead.manufacturers = result.data;
			}
		);
		PaintType.all().then(
			function(result) {
				$scope.typeahead.paintTypes = result.data;
			}
		);
		Area.all(AppContext.getCurrentBinderId()).then(
			function(result) {
				$scope.options.areas = result.data;
			}
		);
		$scope.submitForm = function() {
			$scope.clearFormErrors();
				
			if ($scope.data.form.id == undefined) {
				Paint.create({"paint" : $scope.data.form}).then(
					function(result) {
						$scope.views.activeForm = null;
						$scope.refresh();
					},
					function(error) {
						$scope.processErrors(error);
					}
				);
			} else {
				Paint.update({"paint" : $scope.data.form}).then(
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