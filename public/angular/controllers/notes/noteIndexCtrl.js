/*
 * Controller for notes index
 */
homebinderControllers.controller('NoteIndexCtrl', ['$scope', 'Note',
	function($scope, Note){
		$scope.notes.status = {};
		$scope.notes.views = {};
		$scope.form = {};
		$scope.notes.views.form = '/views/notes/form.html';
		$scope.notes.views.resource = '/views/notes/note.html';
		
		$scope.refresh = function() {
			$scope.notes.status.isBusy = true;
			$scope.notes.status.message = "Getting your notes. One moment please...";
			if ($scope.notes.list == undefined) {
				$scope.notes.list = new Array();
			}
			$scope.notes.list.length = 0;
			Note.all($scope.notes.resourceType, $scope.notes.resourceId).then(
				function(result) {
					$scope.notes.status.isBusy = false;
					$scope.notes.list = result.data;
				},
				function(error) {
					
				}
			);
		};
		
		$scope.onDestroy = function(note) {
			if (confirm("Are you sure you want to delete?")) {
				Note.destroy($scope.notes.resourceType, $scope.notes.resourceId, note.id).then(
					function(result) {
						for (var k = 0; k < $scope.notes.list.length; k++) {
							var n = $scope.notes.list[k];
							if (n.id == note.id) {
								$scope.notes.list.splice(k, 1);
								break;
							}
						}	
					}
				);	
			}
		};

		$scope.refresh();
	}]);