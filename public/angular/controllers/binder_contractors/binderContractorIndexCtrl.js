/*
 * Controller for binder contractors index
 */
homebinderControllers.controller('BinderContractorIndexCtrl', ['$scope', '$interval', 'Binder', 'BinderContractor',
	function($scope, $interval, Binder, BinderContractor){
		$scope.selectedTab = 'contractors';
		$scope.views.resource = '/angular/views/binder_contractors/binder_contractor.html';
		$scope.status.resourceType = 'Contractors';
		
		$scope.$on('binder.selected', function() {
			$scope.refresh();	
		});
		
		$scope.refresh = function() {
			$scope.beginLoadResources();
			BinderContractor.all().success(
				function(result) {
					$scope.pushResources(result, 'binder_contractor');
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
			var bc = {
				id: 0,
				binder_id: Binder.getCurrent().id,
				name: '',
				contractor: {
					address: {}
				}
			};
			// Insert the pending new area at the top of the list
			$scope.insertResource(0, bc, 'binder_contractor');
			// Need to give a little time for the form to be rendered. Would prefer
			// not to use a 'sleep' but haven't found a better way to do this
			var delay = $interval(function(){
				$interval.cancel(delay);
				// broadcast down to the child scopes to begin editing
				$scope.$broadcast('resource.edit', bc.id);		
			}, 250, 1);
		});
		
		$scope.onEdit = function(resource) {
			var binderContractor = resource.data;
			// broadcast down to the child scopes to begin editing
			$scope.$broadcast('resource.edit', binderContractor.id);
		};
		
		$scope.onDestroy = function(resource) {
			$scope.$emit('global.confirmDelete', {
				message: 'Are you sure you want to delete the contractor?',
				confirm: function() {
					BinderContractor.destroy(resource.data.id).then(
						function(result) {
							$scope.removeResource(resource.data.id);
						})
				}
			});
		};
		
		$scope.getNameForDisplay = function(resource) {
			if(resource.data.contractor.contractor_type)
				resource.data.displayName = resource.data.contractor.name + " (" + resource.data.contractor.contractor_type + ")";
			else
				resource.data.displayName = resource.data.contractor.name;
		};
		
		if (Binder.getCurrent() != undefined)
			$scope.refresh();
	}]);