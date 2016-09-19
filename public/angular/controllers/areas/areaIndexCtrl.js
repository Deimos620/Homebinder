/*
 * Controller for areas index
 */
homebinderControllers.controller('AreaIndexCtrl', ['$scope', '$interval', 'Binder', 'Area',
	function($scope, $interval, Binder, Area){
		$scope.selectedTab = 'areas';
		$scope.views.resource = '/angular/views/areas/area.html';
		$scope.status.resourceType = 'Areas and Rooms';
		
		$scope.$on('binder.selected', function() {
			$scope.refresh();	
		});
		
		$scope.refresh = function() {
			$scope.beginLoadResources();
			Area.all().success(
				function(result) {
					$scope.pushResources(result, 'area');
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
			var area = {
				id: 0,
				binder_id: Binder.getCurrent().id,
				name: ''
			};
			// Insert the pending new area at the top of the list
			$scope.insertResource(0, area, 'area');
			// Need to give a little time for the form to be rendered. Would prefer
			// not to use a 'sleep' but haven't found a better way to do this
			var delay = $interval(function(){
				$interval.cancel(delay);
				// broadcast down to the child scopes to begin editing
				$scope.$broadcast('resource.edit', area.id);	
			}, 250, 1);
		});
		
		$scope.onEdit = function(resource) {
			var area = resource.data;
			// broadcast down to the child scopes to begin editing
			$scope.$broadcast('resource.edit', area.id);
		};
		
		$scope.onDestroy = function(resource) {
			$scope.$emit('global.confirmDelete', {
				message: 'Are you sure you want to delete the area?',
				confirm: function() {
					Area.destroy(resource.data.id).then(
						function(result) {
							$scope.removeResource(resource.data.id);
						})
				}
			});
		};
		
		$scope.getNameForDisplay = function(resource) {
			resource.data.displayName = resource.data.name;
		};
		
		if (Binder.getCurrent() != undefined)
			$scope.refresh();
	}]);