/*
 * Controller for paint index
 */
homebinderControllers.controller('PaintIndexCtrl', ['$scope', '$interval', 'Binder', 'Paint',
	function($scope, $interval, Binder, Paint){
		$scope.selectedTab = 'paints';
		$scope.views.resource = '/angular/views/paints/paint.html';
		$scope.status.resourceType = 'Paints';
		
		$scope.$on('binder.selected', function() {
			$scope.refresh();	
		});
		
		$scope.refresh = function() {
			$scope.beginLoadResources();
			Paint.all().success(
				function(result) {
					$scope.pushResources(result, 'paint');
					for (var k = 0; k < $scope.data.resources.length; k++) {
						if ($scope.data.resources[k].data.purchase != undefined) {
							$scope.data.resources[k].data.purchase.price = ($scope.data.resources[k].data.purchase.price / 100).toFixed(2);
						}
						$scope.getNameForDisplay($scope.data.resources[k]);
					}
					$scope.endLoadResources();											
				}).error(
					function(error) {
						$scope.endLoadResources(true);
				});
		};
		
		$scope.$on('resource.new', function() {
			var paint = {
				id: 0,
				binder_id: Binder.getCurrent().id,
				name: '',
				purchase: {}
			};
			// Insert the pending new area at the top of the list
			$scope.insertResource(0, paint, 'paint');
			// Need to give a little time for the form to be rendered. Would prefer
			// not to use a 'sleep' but haven't found a better way to do this
			var delay = $interval(function(){
				$interval.cancel(delay);
				// broadcast down to the child scopes to begin editing
				$scope.$broadcast('resource.edit', paint.id);	
			}, 250, 1);
		});
		
		$scope.onEdit = function(resource) {
			var paint = resource.data;
			// broadcast down to the child scopes to begin editing
			$scope.$broadcast('resource.edit', paint.id);
		};
		
		$scope.onDestroy = function(resource) {
			$scope.$emit('global.confirmDelete', {
				message: 'Are you sure you want to delete the paint?',
				confirm: function() {
					Paint.destroy(resource.data.id).then(
						function(result) {
							$scope.removeResource(resource.data.id);
						})
				}
			});
		};
		
		$scope.getNameForDisplay = function(resource) {
			if(resource.data.manufacturer)
				resource.data.displayName = resource.data.name + " (" + resource.data.manufacturer + ")";
			else
				resource.data.displayName = resource.data.name;
		};
		
		if (Binder.getCurrent() != undefined)
			$scope.refresh();
	}]);