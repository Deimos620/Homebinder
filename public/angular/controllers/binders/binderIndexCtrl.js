/*
 * Controller for the list of binders page
 */
homebinderControllers.controller('BinderIndexCtrl',
[
	'$scope',
	'$location',
	'$routeParams',
	'Binder',
	'User',
	function($scope, $location, $routeParams, Binder, User){
		$scope.data = {};
		$scope.clickBinder = function(binder) {
			Binder.setCurrent(binder);
			$location.path('/binders/' + binder.id);
		};
		$scope.$on('user.logon', function(){
			loadBinders();
		});
		$scope.deleteBinder = function(binder) {
			$scope.$emit('global.confirmDelete', {
				message: 'Are you sure you want to delete the binder - ' + binder.name + "? WARNING, This action can not be undone.",
				confirm: function() {
					Binder.destroy(binder.id).success(
						function(result) {
							Binder.setCurrent(undefined);
							loadBinders();
						});
				}
			});
		};
		
		function loadBinders() {
			$scope.data.isBusy = true;
			Binder.all().success(function(result){
				$scope.data.isBusy = false;
				$scope.data.binders = Binder.binders();
			}).error(function(error){
				// Anything to do here? Display an error?
				$scope.data.isBusy = false;
				console.log(error);
			});
		}
		
		if (User.isLoggedOn()) {
			loadBinders();
		}
	}]);
