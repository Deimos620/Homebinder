/*
 * Parent controller for busy modal
 */
homebinderControllers.controller('BusyModalCtrl', ['$scope', '$modalInstance', 'title', 'msg',
	function($scope, $modalInstane, title, msg){
		$scope.title = title;
		$scope.msg = msg;
	}]);