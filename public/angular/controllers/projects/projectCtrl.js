/*
 * Controller for a project
 */
homebinderControllers.controller('ProjectCtrl', ['$scope', '$location', 'Project', 'ProjectType', 'ProjectStatus', 'Validation', 'Errors', 
	function($scope, $location, Project, ProjectType, ProjectStatus, Validation, Errors){
		$scope.datepicker = {};
		$scope.datepicker.format="yyyy-MM-dd";
		$scope.datepicker.options={ 'show-button-bar': false };
		$scope.onShow = function() {
			$scope.typeahead = {};
			ProjectType.all().then(
				function(result) {
					$scope.typeahead.projectTypes = result.data;
				}
			);
			$scope.options = {};
			ProjectStatus.all().then(
				function(result) {
					$scope.options.statuses = result.data;
				}
			);
		};
		$scope.save = function(data) {
			$scope.errors = {};
			// send to the server
			angular.extend(data, {binder_id: $scope.resource.data.binder_id});
			if ($scope.resource.data.id == 0) {
				return Project.create(data).success(function(result) {
					$scope.resource.data = result;
					$scope.resource.tagId = 'project_' + result.id;
					$scope.formatCost($scope.resource);
					$scope.getNameForDisplay($scope.resource);
				}).error(function(error) {
					$scope.$broadcast('resource.error', error);
				});
			} else {
				return Project.update($scope.resource.data.id, data).success(function(result) {
					$scope.resource.data = result;
					$scope.formatCost($scope.resource);
					$scope.getNameForDisplay($scope.resource);
				}).error(function(error) {
					$scope.$broadcast('resource.error', error);
				});
			}
		};
		
		$scope.getNameForDisplay = function(resource) {
			if(resource.data.status)
				resource.data.displayName = resource.data.name + " (" + resource.data.status + ")";
			else
				resource.data.displayName = resource.data.name;
		}

		$scope.formatCost = function(resource) {
			resource.data.cost = (resource.data.cost / 100).toFixed(2);
		}
	}]);