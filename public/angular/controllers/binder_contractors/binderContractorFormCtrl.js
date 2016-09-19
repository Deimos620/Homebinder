homebinderControllers.controller('BinderContractorFormCtrl', ['$scope', 'AppContext', 'BinderContractor', 'ContractorType',
	function($scope, AppContext, BinderContractor, ContractorType) {
		$scope.typeahead = {};
		ContractorType.all().then(function(result){
			$scope.typeahead.contractorTypes = result.data;
		});
		$scope.submitForm = function() {
			$scope.clearFormErrors();
			
			// Move the $scope.data.form.address_attributes to $scope.data.form.contractor_attributes.address_attributes
			$scope.data.form.contractor_attributes.address_attributes = $scope.data.form.address_attributes;
			if ($scope.data.form.contractor_attributes.address_attributes != undefined) {
				$scope.data.form.contractor_attributes.address_attributes.country = 'US';
				delete $scope.data.form.address_attributes;
			}
			
			if ($scope.data.form.id == undefined) {
				BinderContractor.create({"binder_contractor" : $scope.data.form}).then(
					function(result) {
						$scope.views.activeForm = null;
						$scope.refresh();
					},
					function(error) {
						$scope.processErrors(error);
					}
				);
			} else {
				BinderContractor.update({"binder_contractor" : $scope.data.form}).then(
					function(result) {
						$scope.views.activeForm = null;
						$scope.refresh();
					},
					function(error) {
						$scope.processErrors(error);
					}
				);
			}
		};
		$scope.cancelForm = function() {
			$scope.views.activeForm = null;
		};
	}]);