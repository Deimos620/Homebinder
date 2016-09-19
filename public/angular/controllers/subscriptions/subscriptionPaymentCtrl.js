homebinderControllers.controller('SubscriptionPaymentCtrl', ['$scope', '$routeParams', 'Subscription', 'Coupon', 'Plan',
	function($scope, $routeParams, Subscription, Coupon, Plan) {
		// Set the view to show
		$scope.selectedTab = "subscriptions";
		// Flags to show hide parts of the page
		$scope.showPlans = false;
		$scope.showCouponForm = false;
		$scope.showCCForm = false;
		$scope.showTotals = false;
		// Storage for the coupon form
		$scope.coupon = {};
		// Storgae for the CC form
		$scope.cc = {};
		// Storage for the totals
		$scope.totals = {};
		// The subscription we're working with
		$scope.subscription = {};
		// Storage for the status of the page
		$scope.status = {};
		$scope.status.busy = false;
		// Options for the Month/Year on the CC form
		$scope.options = {};
		$scope.options.months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
		$scope.options.years = [];
		// Current year
		currentYear = new Date().getFullYear();
		
		for(var k = 0; k < 10; k++) {
			$scope.options.years.push(currentYear + k);
		}
		
		function getSubscription() {
			// We are busy
			setStatus(true, 'Retrieving your subscription. One moment please...');
			// Get the subscription
			Subscription.get($routeParams.subscriptionId).success(function(result){
				// Not busy anymore
				setStatus(false);
				// Store the result
				$scope.subscription = result;
				$scope.isUpgrade = $scope.subscription.plan == 'free';
				$scope.showPlans = $scope.isUpgrade ? true : false;
				$scope.showCouponForm = $scope.isUpgrade ? true : false;
				$scope.showCCForm = $scope.isUpgrade ? false : true;
				$scope.showTotals = $scope.isUpgrade ? true : false;
				// Store the totals for dislay
				$scope.totals.subtotal = $scope.subscription.subtotal;
				$scope.totals.discount = $scope.subscription.discount;
				$scope.totals.total = $scope.totals.subtotal;
				// Format the totals
				if (!$scope.isUpgrade) {
					 updateTotals();
				}
			}).error(function(error){
				setStatus(false);
				$scope.error = error;
			});
		}
		
		function updateTotals() {
			$scope.totals.subtotal = ($scope.totals.subtotal / 100).toFixed(2);
			$scope.totals.discount = ($scope.totals.discount / 100).toFixed(2);
			$scope.totals.total = ($scope.totals.total / 100).toFixed(2);
		}
		
		function setStatus(busy, msg) {
			$scope.status.busy = busy;
			$scope.status.msg = busy ? msg : undefined;
		}
		
		function updateSubscription() {
			var action = $scope.subscription.plan == 'free' ? 'upgrade' : 'update';
			Subscription.save(action, $scope.subscription, $scope.cc, $scope.coupon.value)
				.success(function(result) {
					setStatus(false);
					$scope.showCCForm = false;
					$scope.status.complete = true;
					$scope.status.completeMsg = $scope.isUpgrade ? 
						'The subscription on your binder has been upgraded.' : 
						'Your payment information has been updated';
				})
				.error(function(error) {
					setStatus(false);
					$scope.error = error;
				});
		}
		
		$scope.submitCouponForm = function() {
			var coupon = $scope.coupon.value;
			var hasCoupon = !(coupon == undefined || coupon.match(/^\s*$/));
			
			setStatus(true, hasCoupon ? "Applying coupon..." : "One moment please...");
			$scope.error = undefined;
			
			Plan.get('standard').success(function(result){
				$scope.totals.subtotal = result.amount;
				$scope.totals.discount = 0;
				$scope.totals.total = result.amount;
				
				// Check if the user entered a coupon. If they didn't show the CC form
				if (!hasCoupon) {
					// No coupon entered
					setStatus(false);
					updateTotals();
					$scope.showCouponForm = false;
					$scope.showCCForm = true;
				} else {
					// Get the coupon
					Coupon.get(coupon).success(function(result){
						// Update the totals
						// If the amount off is null it is percent off.
						if (result.amount_off == null){
							$scope.totals.discount = $scope.totals.subtotal * (result.percent_off / 100);
						} else {
							$scope.totals.discount = result.amount_off;	
						}
						$scope.totals.total = $scope.totals.subtotal - $scope.totals.discount;
						// Format the totals
						updateTotals();
						// Hide the coupon form
						$scope.showCouponForm = false;
						// If the total is zero for a year or forever upgrade
						if ($scope.totals.total == 0 && (result.duration == 'forever' || result.duration == 'once')){
							updateSubscription();
						} else {
							setStatus(false);
							$scope.showCCForm = true;
						}
					}).error(function(error){
						setStatus(false);
						$scope.error = error;
					});
				}
			}).error(function(error){
				// Error getting the plan. This should never happen
				console.log(error.data);
			});
		};
		
		$scope.submitCCForm = function() {
			// clear any errors
			$scope.error = undefined;
			// Let the user know we're doing an upgrade
			setStatus(true, $scope.isUpgrade ?
				"Upgrading your subscription. One moment please..." :
				"Updating your payment information. One moment please...");
			// Update the subscription
			updateSubscription();
		};
		
		getSubscription();
	}]);