/*
 * Service to handle the REST calls for subscriptions
 */
homebinderServices.factory('Subscription',['$http', 'User', 'Binder',
	function($http, User, Binder) {
		return {
			all: function() {
				return $http.get('/api/v1/subscriptions?binder_id=' + Binder.getCurrent().id);
			},
			allForUser: function() {
				return $http.get('/api/v1/subscriptions?user=x');
			},
			get: function(subscriptionId) {
				return $http.get('/api/v1/subscriptions/' + subscriptionId);
			},
			create: function(subscription) {
				return $http.post('/api/v1/subscriptions/', {subscription: subscription});
			},
			update: function(subscriptionId, subscription) {
				return $http.put('/api/v1/subscriptions/' + subscriptionId, {subscription: subscription});
			},
			destroy: function(subscriptionId) {
				return $http.delete('/api/v1/subscriptions/' + subscriptionId);
			},
			save: function(action, subscription, card, coupon) {
				var data = {
					subscription_action: action,
					subscription: subscription,
					card: card,
					coupon: coupon
				};
				
				return $http.put('/api/v1/subscriptions/' + subscription.id, data);
			}
		};
	}]);
	

homebinderServices.factory('Plan',['$http',
	function($http) {
		return {
			get: function(planId) {
				return $http.get('/api/v1/plans/' + planId);
			}
		};
	}]);
	
homebinderServices.factory('Coupon',['$http',
	function($http) {
		return {
			get: function(couponId) {
				return $http.get('/api/v1/coupons/' + couponId);
			}
		};
	}]);