/*
 * Controller for a receipt
 */
homebinderControllers.controller('ReceiptCtrl', ['$scope', '$modal', 'Receipt', 'Store', 'Validation', 
	function($scope, $modal, Receipt, Store, Validation){
		var form;
		$scope.datepicker = {};
		$scope.datepicker.format="yyyy-MM-dd";
		$scope.datepicker.options={ 'show-button-bar': false };
		$scope.onShow = function() {
			$scope.typeahead = {};
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
					price: data.price,
					store: data.store
				}
			});
			delete data.date;
			delete data.price;
			delete data.store;
			
			if ($scope.resource.data.id == 0) {
				return Receipt.create(data).success(function(result) {
					$scope.resource.data = result;
					$scope.resource.tagId = 'receipt_' + result.id;
					$scope.formatPurchasePrice($scope.resource);
					$scope.getNameForDisplay($scope.resource);
				}).error(function(error) {
					$scope.$broadcast('resource.error', error);
				});
			} else {
				return Receipt.update($scope.resource.data.id, data).success(function(result) {
					$scope.resource.data = result;
					$scope.formatPurchasePrice($scope.resource);
					$scope.getNameForDisplay($scope.resource);
				}).error(function(error) {
					$scope.$broadcast('resource.error', error);
				});
			}
		};
		
		$scope.getNameForDisplay = function(resource) {
			if(resource.data.manufacturer)
				resource.data.displayName = resource.data.name + " (" + resource.data.manufacturer + ")";
			else
				resource.data.displayName = resource.data.name;
		}

		$scope.formatPurchasePrice = function(resource) {
			if ($scope.resource.data.purchase != undefined) {
				$scope.resource.data.purchase.price = ($scope.resource.data.purchase.price / 100).toFixed(2);
			}
		}
		
		$scope.showTaxInfo = function() {
			$modal.open({
				templateUrl: '/angular/views/receipts/taxInfo.html',
				controller: function($scope, $modalInstance) {
					$scope.close = function() {
						$modalInstance.dismiss('close');
					}
				}
			});
		}
	}]);