/*
 * Parent controller for inline forms
 */
homebinderControllers.controller('InlineFormCtrl', ['$scope', 'Validation',
	function($scope, Validation){
		var form;
		$scope.$on('resource.edit', function(e, id) {
			if ($scope.resource.data.id == id) {
				form = form == undefined ? $scope['form' + $scope.resource.data.id] : form;
				form.$show();
			}
		});
		$scope.$on('resource.error', function(e, error){
			for(field in error){
				var name = field;
				if (name.indexOf('.') > -1) {
					var splits = name.split(".");
					name = splits[splits.length-1];
				}
				form.$setError(name, error[field][0]);
			}
		});
		$scope.cancelForm = function() {
			form.$cancel();
		};
		$scope.cancelEdit = function() {
			$scope.cancelForm();
			if ($scope.resource.data.id == 0) {
				$scope.$emit('resource.remove', 0);
			}
		};
		$scope.isFloat = function(value) {
			return Validation.isFloat(value);
		};
		$scope.isInteger = function(data) {
			return Validation.isInteger(data);
		};
	}]);