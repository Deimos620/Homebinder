/*
 * Controller for maintenance events index
 */
homebinderControllers.controller('MaintenanceEventIndexCtrl', ['$scope', '$routeParams', 'MaintenanceEvent', 'Contractor',
	function($scope, $routeParams, MaintenanceEvent, Contractor){
		var maintenanceItemId = $routeParams.maintenanceItemId;
		$scope.views.form = '/views/maintenance_events/form.html';
		$scope.views.resource = '/views/maintenance_events/maintenance_event.html';
		
		$scope.refresh = function() {
			$scope.status.isBusy = true;
			$scope.status.message = "Getting your maintenance events. One moment please...";
			$scope.data.resources.length = 0;
			MaintenanceEvent.all(maintenanceItemId).then(
				function(result) {
					$scope.status.isBusy = false;
					$scope.pushResources(result.data, 'maintenance_event');
					
					for (var k = 0; k < $scope.data.resources.length; k++) {
						var e = $scope.data.resources[k].data;
						if (e.contractor_id == undefined)
							continue;
						Contractor.get(e.contractor_id).then(
							function(result) {
								e.contractor_name = result.data.name;
							}
						);
					}
				},
				function(error) {
					
				}
			);
		};
		
		$scope.onEdit = function(resource) {
			var item = resource.data;
			$scope.data.form = {
				id: item.id,
				maintenance_item_id: item.maintenance_item_id,
				contractor_id: item.contractor_id,
				do_date: item.do_date,
				completed_date: item.completed_date
			};
			$scope.views.activeForm = 'form' + item.id;
		};
		
		$scope.onDestroy = function(resource) {
			$scope.$emit('global.confirmDelete', {
				message: 'Are you sure you want to delete the maintenance event?',
				confirm: function() {
					MaintenanceEvent.destroy(resource.data.id).then(
						function(result) {
							$scope.removeResource(resource.data.id);
						})
				}
			});
		};
		
		$scope.setActiveTab('maintenance');
		$scope.refresh();
	}]);