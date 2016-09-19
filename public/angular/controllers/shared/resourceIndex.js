/*
 * Base controller inherited from by the resource index controllers
 */
homebinderControllers.controller('ResourceIndexCtrl', ['$scope', 'BinderTabs', 'Binder', 'Errors',
	function($scope, BinderTabs, Binder, Errors){
		var expanded = false;
		var loading = false;
		
		$scope.views = {};
		$scope.status = {};
		$scope.data = {};
		$scope.data.currentBinderId = Binder.getCurrent() == undefined ? undefined : Binder.getCurrent().id;
		$scope.data.resources = [];

		$scope.toolbar = {};
		$scope.toolbar.buttons = [
			{ 
				id: "new", 
				text: "New",
			    show: true, 
			    icon: "glyphicon glyphicon-plus",
			    click: function() {
			    	newResource();
			    }
			},
			{ 
				id: "toggleDetails", 
				text: "Expand All", 
				show: true, 
				icon: "glyphicon glyphicon-chevron-down",
				click: function() {
					toggleAllDetails();
				}
			}
		];
		
		function wrapResource(resource, resourceType, showDetails) {
			return {
				data: resource,
				resourceType: resourceType,
				tagId: resource.id > 0 ? resourceType + '_' + resource.id : undefined,
				showDetails: showDetails,
				detailsToggleTip: 'Show Details',
				detailsToggleIcon: 'icon-chevron-down',
				showPartial: $scope.views.resource
			};
		}
		
		function newResource() {
			// broadcast a message down through the child scopes we want to create a new resource
			$scope.$broadcast('resource.new');
		};
		
		function toggleAllDetails() {
			expanded = !expanded;
			for (var k = 0; k < $scope.data.resources.length; k++) {
				$scope.data.resources[k].showDetails = expanded;
				
				$scope.data.resources[k].detailsToggleTip = expanded ? 'Hide Details' : 'Show Details';
				$scope.data.resources[k].detailsToggleIcon = expanded ? 'glyphicon glyphicon-chevron-up' : 'glyphicon glyphicon-chevron-down';
			}
			$scope.toolbar.buttons[1].text = expanded ? "Collapse All" : "Expand All";
			$scope.toolbar.buttons[1].icon = expanded ? "glyphicon glyphicon-chevron-up" : "glyphicon glyphicon-chevron-down";
		};
		
		$scope.pushResources = function(resources, resourceType) {
			for (var k = 0; k < resources.length; k++)
				$scope.pushResource(resources[k], resourceType);
		};
		
		$scope.pushResource = function(resource, resourceType) {
			$scope.data.resources.push(wrapResource(resource, resourceType, false));
		};
		
		$scope.insertResource = function(index, resource, resourceType) {
			$scope.data.resources.splice(index, 0, wrapResource(resource, resourceType, true));
		};
		
		$scope.removeResource = function(resourceId) {
			for (var k = 0; k < $scope.data.resources.length; k++) {
				var r = $scope.data.resources[k];
				if (r.data.id == resourceId) {
					$scope.data.resources.splice(k, 1);
					break;
				}
			}
		};
		
		$scope.beginLoadResources = function() {
			loading = true;
			$scope.data.resources.length = 0;
		};
		
		$scope.endLoadResources = function(isError) {
			loading = false;
			var resourceType = $scope.status.resourceType;
			if (isError) {
				$scope.status.message = "There was an error loading your " + resourceType + ". Please try again.";
			} else {
				$scope.status.message = $scope.data.resources.length == 0 ? 
					"You currently have no " + resourceType + ". Click the 'New' button to add a " + resourceType + "." :
					undefined;
			}
		};
		
		$scope.$watchCollection('data.resources', function(newValue,oldValue){
			var resourceType = $scope.status.resourceType;
			if (loading){
				$scope.status.message = "Loading your " + resourceType + ". One moment please.";
			} else {
				$scope.status.message = $scope.data.resources.length == 0 ? 
					"You currently have no " + resourceType + ". Click the 'New' button to add a " + resourceType + "." :
					undefined;
			}
		});
		
		$scope.$on('binder.selected', function() {
			$scope.data.currentBinderId = Binder.getCurrent().id;
		});
		
		$scope.$on('resource.remove', function(e, id){
			$scope.removeResource(id);
		});
	}]);