homebinderControllers.controller('SubscriptionIndexCtrl', ['$scope', '$location', 'User', 'Subscription',
	function($scope, $location, User, Subscription) {
		// Set the view to show
		$scope.selectedTab = "subscriptions";
		$scope.subscriptions = {};

		$scope.refresh = function() {
			Subscription.allForUser().success(function(result){
				$scope.subscriptions.list = result;
			});
		};
		
		$scope.cancel = function(subscription) {
			
			var data = { 
				plan_id:"free",
				payment_status: "",
				action:'cancel'
			};
			
			if (confirm("Are you sure you want to cancel the subscription?")) {
				Subscription.save('cancel', {id: subscription.id}).success(
					function(result) {
						$scope.refresh();
					}
				)
			}
		};
		
		$scope.$on('user.logon', function() {
			$scope.refresh();
		});
		
		if (User.isLoggedOn()) {
			$scope.refresh();
		}
	}]);