/*
 * Directive 
 */
homebinderDirectives.directive('tabbedResource', function() {
	return {
		restrict: 'E',
		templateUrl: '/angular/views/directives/tabbedResource.html',
		scope: {
			resource: '=',
			service: '=',
			tagId: '=',
			edit: '&onEdit',
			destroy: '&onDestroy'
		},
		controller: function($scope, $element, $attrs, $injector) {
			$scope.resource.detailsStatus = "active";
			$scope.view = {};
			$scope.view.current = $scope.resource.showPartial;
			$scope.notes = {};
			$scope.notes.resourceType = $scope.resource.resourceType;
			$scope.notes.resourceId = $scope.resource.data.id;
			$scope.resource.detailsToggleTip = 'Show Details'; // default
			$scope.resource.detailsToggleIcon = 'glyphicon glyphicon-chevron-down'; // default
			
			/*
			 * toggleDetails - toggles the details view of the tabbed resource
			 */
			$scope.toggleDetails = function() {
				$scope.resource.showDetails = !$scope.resource.showDetails;
				$scope.resource.detailsToggleTip = $scope.resource.showDetails ?
					'Hide Details' : 'Show Details';
				$scope.resource.detailsToggleIcon = $scope.resource.showDetails ?
					'glyphicon glyphicon-chevron-up' : 'glyphicon glyphicon-chevron-down';
			};
			
			$scope.showOnEdit = function() {
				if($scope.resource.showDetails == false) {
					$scope.resource.showDetails			= true;
					$scope.resource.detailsToggleTip  	= 'Hide Details';
					$scope.resource.detailsToggleIcon 	= 'glyphicon glyphicon-chevron-up';
				}
			};
			
			$scope.selectTab = function(tab) {
				switch(tab){
					case "details":
						$scope.resource.detailsStatus = "active";
						$scope.view.current = $scope.resource.showPartial;
						$scope.resource.galleryStatus = undefined;
						$scope.resource.documentsStatus = undefined;
						$scope.resource.notesStatus = undefined;
						break;
					case "gallery":
						$scope.resource.detailsStatus = undefined;
						$scope.resource.galleryStatus = "active";
						$scope.view.current = "/angular/views/images/index.html";
						$scope.resource.documentsStatus = undefined;
						$scope.resource.notesStatus = undefined;
						break;
					case "documents":
						$scope.resource.detailsStatus = undefined;
						$scope.resource.galleryStatus = undefined;
						$scope.resource.documentsStatus = "active";
						$scope.view.current = "/angular/views/documents/index.html";
						$scope.resource.notesStatus = undefined;
						break;
					case "notes":
						$scope.resource.detailsStatus = undefined;
						$scope.resource.galleryStatus = undefined;
						$scope.resource.documentsStatus = undefined;
						$scope.resource.notesStatus = "active";
						$scope.view.current = "/angular/views/notes/index.html";
						break;
				}
			};
		}
	};
});
