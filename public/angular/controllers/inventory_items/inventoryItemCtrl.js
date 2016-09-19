/*
 * Controller for a finish
 */
homebinderControllers.controller('InventoryItemCtrl', ['$scope', '$location', 'InventoryItem', 'InventoryItemType', 'Validation', 'Errors', 
	function($scope, $location, InventoryItem, InventoryItemType, Store, Validation, Errors){
		$scope.onShow = function() {
			$scope.typeahead = {};
			InventoryItemType.all().then(
				function(result) {
					$scope.typeahead.inventoryTypes = result.data;
				});
		};
		$scope.save = function(data) {
			$scope.errors = {};
			// send to the server
			angular.extend(data, {binder_id: $scope.resource.data.binder_id});
			if ($scope.resource.data.id == 0) {
				return InventoryItem.create(data).success(function(result) {
					$scope.resource.data = result;
					$scope.resource.tagId = 'inventory_item_' + result.id;
					$scope.getNameForDisplay($scope.resource);
				}).error(function(error) {
					$scope.$broadcast('resource.error', error);
				});
			} else {
				return InventoryItem.update($scope.resource.data.id, data).success(function(result) {
					$scope.resource.data = result;
					$scope.getNameForDisplay($scope.resource);
				}).error(function(error) {
					$scope.$broadcast('resource.error', error);
				});
			}
		};
		$scope.getNameForDisplay = function(resource) {
			if(resource.data.inventory_item_type)
				resource.data.displayName = resource.data.name + " (" + resource.data.inventory_item_type + ")";
			else
				resource.data.displayName = resource.data.name;
		};
		
	}]);