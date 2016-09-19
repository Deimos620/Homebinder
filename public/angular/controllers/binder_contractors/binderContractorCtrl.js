/*
 * Controller for an area
 */
homebinderControllers.controller('BinderContractorCtrl', ['$scope', '$location', 'BinderContractor', 'ContractorType', 'Address', 'Validation', 'Errors', 
	function($scope, $location, BinderContractor, ContractorType, Address, Validation, Errors){
		$scope.options = {};
		$scope.options.countries = Address.countries();
		$scope.options.subregions = Address.getSubregions('US');
		$scope.onShow = function() {
			$scope.typeahead = {};
			ContractorType.all().then(function(result){
				$scope.typeahead.contractorTypes = result.data;
			});
		};
		$scope.save = function(data) {
			$scope.errors = {};
			// send to the server
			var contractor = {
				binder_id: $scope.resource.data.binder_id,
				account_number: data.account_number,
				contact: data.contact,
				details: data.details,
				contractor_attributes: {
					name: data.name,
					contractor_type: data.contractor_type,
					phone: data.phone,
					email: data.email,
					url: data.url,
					address_attributes: {
						address1: data.address1,
						address2: data.address2,
						city: data.city,
						state: data.state,
						zip: data.zip
					}
				}
			};
			
			if ($scope.resource.data.id == 0) {
				return BinderContractor.create(contractor).success(function(result) {
					$scope.resource.data = result;
					$scope.resource.tagId = 'binder_contractor_' + result.id;
					$scope.getNameForDisplay($scope.resource);
				}).error(function(error) {
					$scope.$broadcast('resource.error', error);
				});
			} else {
				return BinderContractor.update($scope.resource.data.id, contractor).success(function(result) {
					$scope.resource.data = result;
					$scope.getNameForDisplay($scope.resource);
				}).error(function(error) {
					$scope.$broadcast('resource.error', error);
				});
			}
		};
		
		$scope.getNameForDisplay = function(resource) {
			if(resource.data.contractor.contractor_type)
				resource.data.displayName = resource.data.contractor.name + " (" + resource.data.contractor.contractor_type + ")";
			else
				resource.data.displayName = resource.data.contractor.name;
		};
	}]);