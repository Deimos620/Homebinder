/*
 * Controller for a maintenance item
 */
homebinderControllers.controller('MaintenanceItemCtrl', ['$scope', '$location', 'MaintenanceItem', 'MaintenanceCycle', 'MaintenanceEvent',
	'BinderContractor', 'Validation', 'Errors', 
	function($scope, $location, MaintenanceItem, MaintenanceCycle, MaintenanceEvent, BinderContractor, Validation, Errors){
		$scope.datepicker = {};
		$scope.datepicker.format="yyyy-MM-dd";
		$scope.datepicker.options={ 'show-button-bar': false };
		$scope.history = {};
		$scope.history.show = false;
		$scope.history.list = {};
		$scope.onShow = function() {
			$scope.options = {};
			MaintenanceCycle.all().then(
				function(result) {
					$scope.options.cycles = result.data;
				}
			);
		};
		$scope.save = function(data) {
			$scope.errors = {};
			// send to the server
			angular.extend(data, {binder_id: $scope.resource.data.binder_id});
			if ($scope.resource.data.id == 0) {
				return MaintenanceItem.create(data).success(function(result) {
					$scope.resource.data = result;
					$scope.resource.tagId = 'maintenance_item_' + result.id;
					$scope.getNameForDisplay($scope.resource);
				}).error(function(error) {
					$scope.$broadcast('resource.error', error);
				});
			} else {
				return MaintenanceItem.update($scope.resource.data.id, data).success(function(result) {
					$scope.resource.data = result;
					$scope.getNameForDisplay($scope.resource);
				}).error(function(error) {
					$scope.$broadcast('resource.error', error);
				});
			}
		};
		$scope.toggleHistory = function() {
			$scope.history.show = !$scope.history.show;
			if ($scope.history.show) {
				$scope.refreshHistory();
				
				if ($scope.event_options == undefined) {
					BinderContractor.all().then(
						function(result) {
							$scope.event_options = {};
							$scope.event_options.contractors = result.data;
						});
				}
			}
		};
		$scope.refreshHistory = function() {
			MaintenanceEvent.all($scope.resource.data.id).then(
				function(result) {
					$scope.history.list = result.data;
				}
			);
		};
		$scope.saveEvent = function(data, id) {
			return MaintenanceEvent.update(id, data).success(function(result){
				$scope.refreshHistory();
			});
		};
		
		$scope.getNameForDisplay = function(resource) {
			if(resource.data.do_date)
				resource.data.displayName = resource.data.name + " (Next Due: " + $filter('date')(resource.data.do_date, "MMMM dd, yyyy") + ")";
			else
				resource.data.displayName = resource.data.name;
		};
	}]);