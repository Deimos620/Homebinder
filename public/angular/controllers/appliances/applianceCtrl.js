/*
 * Controller for an appliance
 */
homebinderControllers.controller('ApplianceCtrl', ['$scope', '$location', 'Appliance', 'ApplianceManufacturer', 'Recall', 'Store', 'Binder', 'Validation', 'Errors', 
	function($scope, $location, Appliance, ApplianceManufacturer, Recall, Store, Binder, Validation, Errors){
		var form;
		$scope.datepicker = {};
		$scope.datepicker.format="yyyy-MM-dd";
		$scope.datepicker.options={ 'show-button-bar': false };
		$scope.recalls = {};
		$scope.recalls.canCheckRecall = Binder.getCurrent().subscription.plan_id != 'free';
		$scope.recalls.url = '/api/v1/recalls?appliance_id=' + $scope.resource.data.id;
		
		$scope.formatPurchasePrice = function(appliance) {
			if (appliance.purchase) {
				appliance.purchase.price = (appliance.purchase.price / 100).toFixed(2);
			}
		};
		
        $scope.getNameForDisplay = function(resource) {
            if(resource.data.manufacturer)
                resource.data.displayName = resource.data.name + " (" + resource.data.manufacturer + ")";
            else
                resource.data.displayName = resource.data.name;
        };
		
		$scope.onShow = function() {
			$scope.typeahead = {};
			ApplianceManufacturer.all().then(
				function(result) {
					$scope.typeahead.manufacturers = result.data;
				});
			Store.all().then(
				function(result) {
					$scope.typeahead.stores = result.data;
				}
			);
		};
		$scope.save = function(data) {
			$scope.errors = {};
			// send to the server
			angular.extend(data, {
				binder_id: $scope.resource.data.binder_id,
				purchase_attributes: {
					date: data.date,
					store: data.store,
					price: data.price
				}
			});
			delete data.date;
			delete data.store;
			delete data.price;
			
			if ($scope.resource.data.id == 0) {
				return Appliance.create(data).success(function(result){
                    $scope.resource.data = result;
					$scope.resource.tagId = 'Appliance_' + result.id;
                    $scope.formatPurchasePrice($scope.resource);
                    $scope.getNameForDisplay($scope.resource);
				}).error(function(error){
					$scope.$broadcast('resource.error', error);
				});
			} else {
				return Appliance.update($scope.resource.data.id, data).success(function(result){
                    $scope.resource.data = result;
                    $scope.formatPurchasePrice($scope.resource);
                    $scope.getNameForDisplay($scope.resource);
				}).error(function(error){
					$scope.$broadcast('resource.error', error);
				});
			}
		};
				
		$scope.checkForRecalls = function() {
			$scope.recalls.show = true;
			Recall.all($scope.resource.data.id).success(function(result){
				$scope.recalls.data = result;
			}).error(function(error){
				console.log(error.data);
			});
		};
		
		$scope.nextRecallPage = function() {
			
		};
	}]);