homebinderControllers.controller('BinderFormCtrl', ['$scope', 'Address', 'PropertyType', 'AdminPartnerService', 'User',
	function($scope, Address, PropertyType, AdminPartnerService, User) {
		$scope.options = {};
		$scope.options.countries = Address.countries();
		$scope.options.subregions = Address.getSubregions('US');
		$scope.permissions = {};
		$scope.permissions.assign_partner = 'admin';//User.current().user_role == 'admin';
		$scope.options.propertyTypes = ['Single Family','Multi Family','Condo'];
		
		/*
		PropertyType.all().success(
			function(result) {
				$scope.options.propertyTypes = result;
			}
		);
		*/
		if ($scope.permissions.assign_partner) {
			AdminPartnerService.all().success(
				function(result){
					$scope.options.partners = result;
				}
			);
		}
		$scope.submitForm = function() {
			if ($scope.data.form.errors) {
				delete $scope.data.form.errors;
			}
			
			var data = angular.copy($scope.data.form);
			
			if (data.partner) {
				data.tags_attributes = [
					{tag: 'partner_' + data.partner, auto_generated: true}
				];
				delete data.partner;
			}
			if (data.partner == null) {
				delete data.partner;
			}
			$scope.$emit('binder.save', data);
		};
		$scope.cancelForm = function() {
			$scope.$emit('binder.cancelForm');
		};
	}]);