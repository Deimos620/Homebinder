/*
 * Controller for projects index
 */
homebinderControllers.controller('ProjectIndexCtrl', ['$scope', '$interval', 'Binder', 'Project',
	function($scope, $interval, Binder, Project){
		$scope.selectedTab = 'projects';
		$scope.views.resource = '/angular/views/projects/project.html';
		$scope.status.resourceType = 'Projects';
		
		$scope.$on('binder.selected', function() {
			$scope.refresh();	
		});
		
		$scope.refresh = function() {
			$scope.beginLoadResources();
			Project.all().success(
				function(result) {
					$scope.pushResources(result, 'project');
					for (var k = 0; k < $scope.data.resources.length; k++) {
						$scope.data.resources[k].data.cost = ($scope.data.resources[k].data.cost / 100).toFixed(2);
						$scope.getNameForDisplay($scope.data.resources[k]);
					}
					$scope.endLoadResources();					
				}).error(
					function(error) {
						$scope.endLoadResources(true);
				});
		};
		$scope.$on('resource.new', function() {
			var project = {
				id: 0,
				binder_id: Binder.getCurrent().id,
				name: ''
			};
			// Insert the pending new area at the top of the list
			$scope.insertResource(0, project, 'project');
			// Need to give a little time for the form to be rendered. Would prefer
			// not to use a 'sleep' but haven't found a better way to do this
			var delay = $interval(function(){
				$interval.cancel(delay);
				// broadcast down to the child scopes to begin editing
				$scope.$broadcast('resource.edit', project.id);		
			}, 250, 1);
		});
		$scope.onEdit = function(resource) {
			var project = resource.data;
			// broadcast down to the child scopes to begin editing
			$scope.$broadcast('resource.edit', project.id);
		};
		
		$scope.onDestroy = function(resource) {
			$scope.$emit('global.confirmDelete', {
				message: 'Are you sure you want to delete the project?',
				confirm: function() {
					Project.destroy(resource.data.id).then(
						function(result) {
							$scope.removeResource(resource.data.id);
						})
				}
			});
		};
		
		$scope.getNameForDisplay = function(resource) {
			if(resource.data.status)
				resource.data.displayName = resource.data.name + " (" + resource.data.status + ")";
			else
				resource.data.displayName = resource.data.name;
		};

		if (Binder.getCurrent() != undefined)
			$scope.refresh();
	}]);