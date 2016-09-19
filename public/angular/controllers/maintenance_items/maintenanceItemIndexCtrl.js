/*
 * Controller for maintenance item index
 */
homebinderControllers.controller('MaintenanceItemIndexCtrl', ['$scope', '$interval', '$filter', 'Binder', 'MaintenanceItem',
	function($scope, $interval, $filter, Binder, MaintenanceItem){
		$scope.selectedTab = 'maintenance';
		$scope.views.resource = '/angular/views/maintenance_items/maintenance_item.html';
		$scope.status.resourceType = 'Maintenance Items';
		
		$scope.$on('binder.selected', function() {
			$scope.refresh();	
		});
		
		$scope.refresh = function() {
			$scope.beginLoadResources();
			MaintenanceItem.all().success(
				function(result) {
					$scope.pushResources(result, 'maintenance_item');
					for (var k = 0; k < $scope.data.resources.length; k++) {
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
				name: ''
			};
			// Insert the pending new area at the top of the list
			$scope.insertResource(0, item, 'maintenance_item');
			// Need to give a little time for the form to be rendered. Would prefer
			// not to use a 'sleep' but haven't found a better way to do this
			var delay = $interval(function(){
				$interval.cancel(delay);
				// broadcast down to the child scopes to begin editing
				$scope.$broadcast('resource.edit', item.id);		
			}, 250, 1);
		});
		
		$scope.onEdit = function(resource) {
			var item = resource.data;
			// broadcast down to the child scopes to begin editing
			$scope.$broadcast('resource.edit', item.id);
		};
		
		$scope.onDestroy = function(resource) {
			$scope.$emit('global.confirmDelete', {
				message: 'Are you sure you want to delete the maintenance item?',
				confirm: function() {
					MaintenanceItem.destroy(resource.data.id).then(
						function(result) {
							$scope.removeResource(resource.data.id);
						})
				}
			});
		};
		
		$scope.getNameForDisplay = function(resource) {
			if(resource.data.do_date)
				resource.data.displayName = resource.data.name + " (Next Due: " + $filter('date')(resource.data.do_date, "MMMM dd, yyyy") + ")";
			else
				resource.data.displayName = resource.data.name;
		};

		if (Binder.getCurrent() != undefined)
			$scope.refresh();
	}]);