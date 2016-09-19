homebinderControllers.controller('NoteFormCtrl', ['$scope', 'Note',
	function($scope, Note) {
		$scope.submitForm = function() {
			Note.create($scope.notes.resourceType, $scope.notes.resourceId, { "note" : $scope.form }).then(
				function(result) {
					$scope.refresh();
					$scope.form.content = null;
				}
			);
		};
	}]);