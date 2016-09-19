/*
 * Controller for an area
 */
homebinderControllers.controller('AreaCtrl', ['$scope', '$location', 'Area', 'AreaType', 'Structure', 'Validation', 'Errors', 
	function($scope, $location, Area, AreaType, Structure, Validation, Errors){
		$scope.onShow = function() {
			$scope.typeahead = {};
			AreaType.all().success(function(result) {
					$scope.typeahead.areaTypes = result;
				}
			);
			$scope.options = {};
			$scope.options.structures = [];
			Structure.all().success(function(result) {
				for(var k = 0; k < result.length; k++) {
					$scope.options.structures.push({id: result[k].id, name: result[k].name});
				}
			});
		};
		$scope.save = function(data) {
			$scope.errors = {};
			// send to the server
			angular.extend(data, {binder_id: $scope.resource.data.binder_id});
			if (data.structures != undefined) {
				var tags = [];
				for(var k = 0; k < data.structures.length; k++) {
					tags.push({tag: 'structure_' + data.structures[k].id, auto_generated: true});
				}
				if (tags.length > 0) {
					angular.extend(data, {tags_attributes: tags});
				}
				delete data.structures;
			}
			
			if ($scope.resource.data.id == 0) {
				return Area.create(data).success(function(result){
					$scope.resource.data = result;
					$scope.resource.tagId = 'area_' + result.id;
					$scope.getNameForDisplay($scope.resource);
				}).error(function(error){
					$scope.$broadcast('resource.error', error);
				});
			} else {
				return Area.update($scope.resource.data.id, data).success(function(result) {
					$scope.resource.data = result;
					$scope.getNameForDisplay($scope.resource);
				}).error(function(error){
					$scope.$broadcast('resource.error', error);
				});
			}
		};
		$scope.showTags = function() {
			var selected = [];
    		angular.forEach($scope.resource.data.structures, function(s) { 
			  	selected.push(s.name);
		    });
		    return selected.length ? selected.join(', ') : "";
		};
        $scope.getNameForDisplay = function(resource) {
            resource.data.displayName = resource.data.name;
        };
	}]);