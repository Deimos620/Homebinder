homebinderControllers.controller('EditBinderCtrl', ['$scope', '$location', '$routeParams', 'Binder',
	function($scope, $location, $routeParams, Binder) {
		$scope.data = {};
		$scope.data.form = {};
		var binderId = $routeParams['binderId'];
		Binder.get(binderId).success(function(result){
			var binder = {
				id: result.id,
				name: result.name,
				primary: result.primary,
				partner: result.partner ? result.partner.id : undefined,
				property_attributes: result.property
			};
			$scope.data.form = binder;
		});
		$scope.$on('binder.save', function(e, formData) {
			var id = $scope.data.form.id;
			delete formData.id;
			Binder.update(id, formData).success(function(result) {
				Binder.setCurrent(result);
				$location.path('/binders/' + result.id);
			}).error(function(error){
				$scope.data.form.errors = error;
			});
		});
		$scope.$on('binder.cancelForm', function() {
			$location.path('/binders/' + Binder.getCurrent().id);
		});
	}]);