homebinderControllers.controller('ProjectFormCtrl', ['$scope', 'Project', 'ProjectType', 'ProjectStatus',
	function($scope, Project, ProjectType, ProjectStatus) {
		$scope.typeahead = {};
		$scope.datepicker = {};
		$scope.datepicker.format="yyyy-MM-dd";
		$scope.datepicker.options={ 'show-button-bar': false };
		
		ProjectType.all().then(
			function(result) {
				$scope.typeahead.projectTypes = result.data;
			}
		);
		ProjectStatus.all().then(
			function(result) {
				$scope.options = {};
				$scope.options.projectStatuses = result.data;
			}
		);
		$scope.submitForm = function() {
			$scope.clearFormErrors();
				
			if ($scope.data.form.id == undefined) {
				Project.create({"project" : $scope.data.form}).then(
					function(result) {
						$scope.views.activeForm = null;
						$scope.refresh();
					},
					function(error) {
						$scope.processErrors(error);
					}
				);
			} else {
				Project.update({"project" : $scope.data.form}).then(
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