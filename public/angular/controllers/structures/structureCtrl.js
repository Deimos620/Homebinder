/*
 * Controller a structure
 */
homebinderControllers.controller('StructureCtrl', ['$scope', '$location', 'Structure', 'ConstructionStyle', 'ConstructionType', 'HeatType', 
	'HeatSource', 'Validation', 'Errors', function($scope, $location, Structure, ConstructionStyle, ConstructionType, HeatType, HeatSource,
		Validation, Errors){
		$scope.onShow = function() {
			$scope.typeahead = {};
			ConstructionStyle.all().then(
				function(result) {
					$scope.typeahead.constructionStyles = result.data;
				}
			);
			ConstructionType.all().then(
				function(result) {
					$scope.typeahead.constructionTypes = result.data;
				}
			);
			HeatType.all().then(
				function(result) {
					$scope.typeahead.heatTypes = result.data;
				}
			);
			HeatSource.all().then(
				function(result) {
					$scope.typeahead.heatSources = result.data;
				}
			);
		};
		$scope.save = function(data) {
			$scope.errors = {};
			// send to the server
			angular.extend(data, {binder_id: $scope.resource.data.binder_id});
			if ($scope.resource.data.id == 0) {
				return Structure.create(data).success(function(result) {
					$scope.resource.data = result;
					$scope.resource.tagId = 'structure_' + result.id;
					$scope.getNameForDisplay($scope.resource);
				}).error(function(error) {
					$scope.$broadcast('resource.error', error);
				});
			} else {
				return Structure.update($scope.resource.data.id, data).success(function(result) {
					$scope.resource.data = result;
					$scope.getNameForDisplay($scope.resource);
				}).error(function(error) {
					$scope.$broadcast('resource.error', error);
				});
			}
		};
		$scope.getNameForDisplay = function(resource) {
			resource.data.displayName = resource.data.name;
		};
		
	}]);
