homebinderControllers.controller('ShareFormCtrl', ['$scope', '$modalInstance', 'Binder', 'Share',
	function($scope, $modalInstance, Binder, Share) {
		$scope.form = {};
		$scope.form.role_name = 'reader';
		$scope.submit = function() {
			Share.create('binder', Binder.getCurrent().id, $scope.form).then(
				function(result) {
					$modalInstance.close();
				},
				function(error) {
					$scope.error = error.data;
				}
			);
		};
		$scope.cancel = function(){
			$modalInstance.dismiss('cancel');
		};
	}]);