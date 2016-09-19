homebinderControllers.controller('InventoryItemFormCtrl', ['$scope', 'AppContext', 'InventoryItem', 'InventoryItemType',
	function($scope, AppContext, InventoryItem, InventoryItemType) {
		$scope.typeahead = {};
		InventoryItemType.all().then(
			function(result) {
				$scope.typeahead.inventoryTypes = result.data;
			}
		);
		$scope.submitForm = function() {
			$scope.clearFormErrors();
				
			if ($scope.data.form.id == undefined) {
				InventoryItem.create({"inventory_item" : $scope.data.form}).then(
					function(result) {
						$scope.views.activeForm = null;
						$scope.refresh();
					},
					function(error) {
						$scope.processErrors(error);
					}
				);
			} else {
				InventoryItem.update({"inventory_item" : $scope.data.form}).then(
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