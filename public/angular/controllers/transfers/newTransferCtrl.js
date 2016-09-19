homebinderControllers.controller('NewTransferCtrl', ['$scope', '$injector',
	function($scope, $injector){
		var $routeParams = $injector.get('$routeParams');
		var binderId = $routeParams['binderId'];
		$scope.data = {};
		$scope.data.invalid = true;
		$scope.data.binder_url = "#/binders/" + binderId;
		$scope.data.transferType = 'ownership';
		
		$scope.transfer = function() {
            var data = {
				binder_id: binderId,
				transfer_to: $scope.data.transferTo,
				transfer_type: $scope.data.transferType
			};
			
			var Transfer = $injector.get('Transfer');
			Transfer.create(data).success(function(result) {
					$scope.$emit('global.showModal', {
						title: 'Transfer Successful',
						minorMessage: 'Your binder has been transfered to ' + data.transfer_to,
						buttons: [
							{
								label: 'OK',
								isPrimary: true,
								action: 'close',
								result: 'ok',
							}
						],
						confirm: function(){
							var $location = $injector.get('$location');
							if (data.transfer_type == 'ownership') {
								$location.path('/binders/');
							} else {
								$location.path('/binders/' + binderId);
							}
						}
					});
				}).error(function(error) {
					$scope.data.error = error;
				});
        }
	}]);