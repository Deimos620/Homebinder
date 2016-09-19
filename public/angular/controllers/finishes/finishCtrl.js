/*
 * Controller for a finish
 */
homebinderControllers.controller('FinishCtrl', ['$scope', '$location', 'Finish', 'FinishMake', 'FinishModel', 'Store', 'Structure', 'Area', 'Validation', 
	function($scope, $location, Finish, FinishMake, FinishModel, Store, Structure, Area, Validation){
		var form;
		$scope.datepicker = {};
		$scope.datepicker.format="yyyy-MM-dd";
		$scope.datepicker.options={ 'show-button-bar': false };
		$scope.typeahead = {};
		$scope.onShow = function() {
			FinishMake.all().success(
				function(result) {
					$scope.typeahead.makes = result;
				});
			FinishModel.all().success(
				function(result) {
					$scope.typeahead.models = result;
			});
			Store.all().success(
				function(result) {
					$scope.typeahead.stores = result;
				}
			);
			$scope.options = {};
			$scope.options.structures = [];
			$scope.options.areas = [];
			Structure.all().success(function(result) {
				for(var k = 0; k < result.length; k++) {
					$scope.options.structures.push({id: result[k].id, name: result[k].name});
				}
			});
			Area.all().success(function(result) {
				for(var k = 0; k < result.length; k++) {
					$scope.options.areas.push({id: result[k].id, name: result[k].name});
				}
			});
		};
		$scope.save = function(data) {
			$scope.errors = {};
			// send to the server
			angular.extend(data, {
				binder_id: $scope.resource.data.binder_id,
				purchase_attributes : {
					date: data.date,
					price: data.price,
					store: data.store
				}
			});
			delete data.date;
			delete data.price;
			delete data.store;

			var tags = [];
			if (data.structures != undefined) {
				for(var k = 0; k < data.structures.length; k++) {
					tags.push({tag: 'structure_' + data.structures[k].id, auto_generated: true});
				}
				delete data.structures;
			}
			if (data.areas != undefined) {
				for(var k = 0; k < data.areas.length; k++) {
					tags.push({tag: 'area_' + data.areas[k].id, auto_generated: true});
				}
				delete data.areas;
			}
			if (tags.length > 0) {
				angular.extend(data, {tags_attributes: tags});
			}
			
			if ($scope.resource.data.id == 0) {
				return Finish.create(data).success(function(result) {
					$scope.resource.data = result;
					$scope.resource.tagId = 'finish_' + result.id;
					$scope.formatPurchasePrice($scope.resource);
					$scope.getNameForDisplay($scope.resource);
				}).error(function(error) {
					$scope.$broadcast('resource.error', error);
				});
			} else {
				return Finish.update($scope.resource.data.id, data).success(function(result) {
					$scope.resource.data = result;
					$scope.formatPurchasePrice($scope.resource);
					$scope.getNameForDisplay($scope.resource);
				}).error(function(error) {
					$scope.$broadcast('resource.error', error);
				});
			}
		};
		$scope.showStructureTags = function() {
			var selected = [];
    		angular.forEach($scope.resource.data.structures, function(s) { 
			  	selected.push(s.name);
		    });
		    return selected.length ? selected.join(', ') : "";
		};
		$scope.showAreaTags = function() {
			var selected = [];
    		angular.forEach($scope.resource.data.areas, function(a) { 
			  	selected.push(a.name);
		    });
		    return selected.length ? selected.join(', ') : "";
		};
		
		$scope.getNameForDisplay = function(resource) {
			if(resource.data.make)
				resource.data.displayName = resource.data.name + " (" + resource.data.make + ")";
			else
				resource.data.displayName = resource.data.name;
		};

		$scope.formatPurchasePrice = function() {
			if ($scope.resource.data.purchase != undefined) {
				$scope.resource.data.purchase.price = ($scope.resource.data.purchase.price / 100).toFixed(2);
			}
		};
	}]);