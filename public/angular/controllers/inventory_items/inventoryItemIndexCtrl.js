/*
 * Controller for inventory item index
 */
homebinderControllers.controller('InventoryItemIndexCtrl', ['$scope', '$interval', 'Binder', 'InventoryItem',
	function($scope, $interval, Binder, InventoryItem){
		$scope.selectedTab = 'inventory';
		$scope.views.resource = '/angular/views/inventory_items/inventory_item.html';
		$scope.status.resourceType = 'Inventory Items';
		
		$scope.$on('binder.selected', function() {
			$scope.refresh();	
		});
		
		$scope.refresh = function() {
			$scope.beginLoadResources();
			InventoryItem.all().success(
				function(result) {
					$scope.pushResources(result, 'inventory_item');
					for (var k = 0; k < $scope.data.resources.length; k++) {
						$scope.data.resources[k].data.value = ($scope.data.resources[k].data.value / 100).toFixed(2);
						$scope.getNameForDisplay($scope.data.resources[k]);
					}
					$scope.endLoadResources();
				}).error(
					function(error) {
						$scope.endLoadResources(true);
				});
		};
		
		$scope.$on('resource.new', function() {
			var item = {
				id: 0,
				binder_id: Binder.getCurrent().id,
				name: '',
				purchase: {}
			};
			// Insert the pending new area at the top of the list
			$scope.insertResource(0, item, 'inventory_item');
			// Need to give a little time for the form to be rendered. Would prefer
			// not to use a 'sleep' but haven't found a better way to do this
			var delay = $interval(function(){
				$interval.cancel(delay);
				// broadcast down to the child scopes to begin editing
				$scope.$broadcast('resource.edit', item.id);		
			}, 250, 1);
		});
		
		$scope.onEdit = function(resource) {
			var inventoryItem = resource.data;
			// broadcast down to the child scopes to begin editing
			$scope.$broadcast('resource.edit', inventoryItem.id);
		};
		
		$scope.onDestroy = function(resource) {
			$scope.$emit('global.confirmDelete', {
				message: 'Are you sure you want to delete the inventory item?',
				confirm: function() {
					InventoryItem.destroy(resource.data.id).then(
						function(result) {
							$scope.removeResource(resource.data.id);
						})
				}
			});
		};
		
		$scope.getNameForDisplay = function(resource) {
			if(resource.data.inventory_item_type)
				resource.data.displayName = resource.data.name + " (" + resource.data.inventory_item_type + ")";
			else
				resource.data.displayName = resource.data.name;
		};

		if (Binder.getCurrent() != undefined)
			$scope.refresh();
	}]);