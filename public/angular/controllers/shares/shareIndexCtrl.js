homebinderControllers.controller('ShareIndexCtrl', ['$scope', '$rootScope', '$location', 'Share', 'Binder', 'User',
	function($scope, $rootScope, $location, Share, Binder, User) {
		// Set the view to show
		$scope.selectedTab = "shares";
		
		$scope.sharedByMe = {};
		$scope.getSharedByMe = function() {
			$scope.sharedByMe.isBusy = true;
			if ($scope.sharedByMe.list != undefined) {
				$scope.sharedByMe.list.length = 0;
			}
			Share.sharedBy().then(
				function(result) {
					$scope.sharedByMe.list = result.data;
					$scope.sharedByMe.isBusy = false;
					for (var k = 0; k < $scope.sharedByMe.list.length; k++) {
						$scope.getNameForDisplay($scope.sharedByMe.list[k]);
					}					
				}
			);
		};
		$scope.sharedWithMe = {};
		$scope.getSharedWithMe = function() {
			$scope.sharedWithMe.isBusy = true;
			if ($scope.sharedWithMe.list != undefined) {
				$scope.sharedWithMe.list.length = 0;
			}
			Share.sharedWith().then(
				function(result) {
					$scope.sharedWithMe.list = result.data;
					$scope.sharedWithMe.isBusy = false;
					for (var k = 0; k < $scope.sharedWithMe.list.length; k++) {
						$scope.getNameForDisplay($scope.sharedWithMe.list[k]);
					}					
				}
			);
		};
		$scope.cancelShare = function(share) {
			Share.destroy(share.id).then(
				function(result) {
					$scope.getSharedByMe();
				},
				function(result) {
					$scope.getSharedByMe();
				}
			);
		};
		$scope.acceptShare = function(share) {
			var data = { status: 'accepted' };
			Share.update(share.id, data).then(
				function(result) {
					Binder.get(result.data.sharable_id).then(
						function(result2) {
							Binder.setCurrent(result2.data);
							$location.path('/binders/' + result2.data.id);
						}
					);
					$rootScope.$broadcast('share.refresh');
				},
				function(error) {
					
				}
			);
		};
		$scope.declineShare = function(share) {
			var data = { id: share.id, status: 'rejected' };
			Share.update(share.id, data).then(
				function(result) {
					$scope.getSharedWithMe();
				},
				function(error) {
					
				}
			);
			$rootScope.$broadcast('share.refresh');
		};
		
		$scope.getNameForDisplay = function(share){
			if(share.role_name == 'co_owner') share.roleDisplayName	= 'Co-Owner';
			else if(share.role_name == 'reader') share.roleDisplayName	= 'Viewer';
		};
			
		$scope.refresh = function() {
			$scope.getSharedByMe();
			$scope.getSharedWithMe();
		};
		$scope.$on('user.logon', function(){
			$scope.refresh();
		});
		if (User.isLoggedOn())
			$scope.refresh();
	}]);