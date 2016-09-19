/*
 * Controller for structures index
 */
homebinderControllers.controller('StructureIndexCtrl', ['$scope', '$interval', 'Binder', 'Structure',
	function($scope, $interval, Binder, Structure){
		$scope.selectedTab = 'structures';
		$scope.views.resource = '/angular/views/structures/structure.html';
		$scope.status.resourceType = 'Structures';
		
		$scope.$on('binder.selected', function() {
			$scope.refresh();	
		});
		
		$scope.$on('resource.new', function() {
			var struct = {
				id: 0,
				binder_id: Binder.getCurrent().id,
				name: ''
			};
			// Insert the pending new structure at the top of the list
			$scope.insertResource(0, struct, 'structure');
			// Need to give a little time for the form to be rendered. Would prefer
			// not to use a 'sleep' but haven't found a better way to do this
			var delay = $interval(function(){
				$interval.cancel(delay);
				// broadcast down to the child scopes to begin editing
				$scope.$broadcast('resource.edit', struct.id);		
			}, 250, 1);
		});
		
		$scope.refresh = function() {
			$scope.beginLoadResources();
			Structure.all().success(
				function(result) {
					$scope.pushResources(result, 'structure');
					for (var k = 0; k < $scope.data.resources.length; k++) {
						$scope.getNameForDisplay($scope.data.resources[k]);
					}
					$scope.endLoadResources();					
				}).error(
					function(error) {
						$scope.endLoadResources(true);
				}
			);
		};
		
		$scope.onEdit = function(resource) {
			var struct = resource.data;
			// broadcast down to the child scopes to begin editing
			$scope.$broadcast('resource.edit', struct.id);
		};
		
		$scope.onDestroy = function(resource) {
			$scope.$emit('global.confirmDelete', {
				message: 'Are you sure you want to delete the structure?',
				confirm: function() {
					Structure.destroy(resource.data.id).then(
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