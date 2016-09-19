homebinderControllers.controller('NewBinderCtrl', ['$scope', '$location', 'Binder', 'PropertyType', 'Address',
	function($scope, $location, Binder, PropertyType, Address) {
		$scope.data = {};
		$scope.data.form = {};
		$scope.data.form.primary = Binder.binders() == undefined || Binder.binders().length == 0 ? true : false;
		$scope.data.form.property_attributes = {};
		$scope.data.form.property_attributes.country = Address.countries()[0].value;
		$scope.data.form.property_attributes.property_type = 'Single Family';
		$scope.$on('binder.save', function(e, formData) {
			Binder.create(formData).success(function(result){
				Binder.setCurrent(result);
				$location.path('/binders/' + result.id + '/onboarding_wizard/contractors');
			}).error(function(error) {
				$scope.data.form.errors = error;
			});
		});
		$scope.$on('binder.cancelForm', function() {
			$location.path('/binders/');
		});
	}]);