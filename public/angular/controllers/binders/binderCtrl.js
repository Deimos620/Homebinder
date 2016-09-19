'use strict';

/*
 * Controller for the binder page
 */
homebinderControllers.controller('BinderCtrl', ['$scope', '$injector',
	function($scope, $injector){
		var Binder = $injector.get('Binder');
		var MaintenanceItem = $injector.get('MaintenanceItem');
		var Project = $injector.get('Project');
		var BinderContractor = $injector.get('BinderContractor');
		
		$scope.data = {};
		$scope.projects = {};
		$scope.maintenance_items = {};
		$scope.contractors = {};
		$scope.selectedTab = 'overview';
		
		// for date comparisons for maintenance list
		var today		= new Date(),
			now 		= today.getTime(),
			fourteen 	= today.setDate(today.getDate() + 14);
		
		function loadProjects() {
			$scope.projects.isBusy = true;
			Project.all().success(function(result){
				$scope.projects.items = result;
				$scope.projects.isBusy = false;
			}).error(function(error){
				$scope.projects.isBusy = false;
			});
		}
		
		function loadMaintenanceItems() {
			$scope.maintenance_items.isBusy = true;
			MaintenanceItem.all().success(function(result){
				//$scope.maintenance_items.items = result;
				//$scope.maintenance_items.isBusy = false;
				
				$scope.maintenance_items.items = [];
				
				angular.forEach(result, function(item){
					var due = new Date(item.next_event_date).getTime();
					
					if (now > due)
		  				item.rowclass = 'danger';
					else if (fourteen > due)
		  				item.rowclass = 'warning';
					else
		  				item.rowclass = '';
		  			
		  			var currItems 	= $scope.maintenance_items.items,
		  				newList		= currItems.concat(item);
		  				
					$scope.maintenance_items.items = newList;
				});
				
				$scope.maintenance_items.isBusy = false;
			}).error(function(error){
				$scope.maintenance_items.isBusy = false;
			});
		}
		
		function loadContractors() {
			$scope.contractors.isBusy = true;
			BinderContractor.all().success(function(result){
				$scope.contractors.items = result;
				$scope.contractors.isBusy = false;	
			}).error(function(error){
				$scope.contractors.isBusy = false;
			});
		}
		
		function refresh() {
			$scope.binder = {};
			$scope.binder = Binder.getCurrent();
			loadProjects();
			loadMaintenanceItems();
			loadContractors();
		}
		
		$scope.$on('binder.selected', function(){
			refresh();
		});
		
		if (Binder.getCurrent() != undefined) {
			refresh();
		}
	}]);
