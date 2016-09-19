homebinderControllers.controller('StructureFormCtrl', ['$scope', 'Structure', 'ConstructionStyle', 'ConstructionType', 'HeatType', 'HeatSource',
	function($scope, Structure, ConstructionStyle, ConstructionType, HeatType, HeatSource) {
		$scope.typeahead = {};
		ConstructionStyle.all().then(
			function(result) {
				$scope.typeahead.constructionStyles = result.data;
			}
		);
		ConstructionType.all().then(
			function(result) {
				$scope.typeahead.constructionTypes = result.data;
			}
		);
		HeatType.all().then(
			function(result) {
				$scope.typeahead.heatTypes = result.data;
			}
		);
		HeatSource.all().then(
			function(result) {
				$scope.typeahead.heatSources = result.data;
			}
		);
		$scope.submitForm = function() {
			$scope.clearFormErrors();
			
			if ($scope.data.form.id == undefined) {
				Structure.create({"structure" : $scope.data.form}).then(
					function(result) {
						$scope.views.activeForm = null;
						$scope.refresh();
					},
					function(error) {
						$scope.processErrors(error);
					}
				);
			} else {
				Structure.update({"structure" : $scope.data.form}).then(
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
