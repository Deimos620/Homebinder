/*
 * Directive 
 */
homebinderDirectives.directive('binderMaster', function() {
	return {
		restrict: 'E',
		transclude: true,
		templateUrl: '/angular/views/directives/binderMaster.html',
		scope: {
			selectedTab: '=',
			resourceCount: '=',
			buttons: '='
		},
		controller: function($scope, $element, $attrs, $injector) {
			// Get the services we need
			var $location = $injector.get('$location');
			var $modal = $injector.get('$modal');
			var $window = $injector.get('$window');
			var $sce = $injector.get('$sce');
			var BinderTabs = $injector.get('BinderTabs');
			var Binder = $injector.get('Binder');
			var Config = $injector.get('Config');
			var User = $injector.get('User');
			var SellerReport = $injector.get('SellerReport');
			
			function setTab() {
				var tabId = $scope.selectedTab;
				for (var k = 0; k < $scope.tabs.list.length; k++) {
					var tab = $scope.tabs.list[k];
					if (tab.id == tabId) {
						tab.statusClass = "active";
						$scope.tabs.active = tab;
					} else {
						tab.statusClass = null;
					}
				}
			}
			
			function setBinderInfo() {
				if (Binder.getCurrent() != undefined) {
					$scope.binder.id = Binder.getCurrent().id;
					$scope.binder.seller_report_exists = Binder.getCurrent().seller_report != undefined;
					$scope.subscription.id = Binder.getCurrent().subscription.id;
					$scope.subscription.text = Binder.getCurrent().plan_id == 'free' ? 'Upgrade' : 'Standard';
					$scope.subscription.url = Binder.getCurrent().plan_id == 'free' ? 
						"#/subscriptions/" + $scope.subscription.id + "/upgrade" :
						"#/subscriptions/" + $scope.subscription.id + "/update";
					$scope.subscription.failed = Binder.getCurrent().subscription.payment_status == 'failed';
					$scope.subscription.visible = Binder.getCurrent().subscription.plan_id == 'free';
					$scope.permissions.can_share = Binder.getCurrent().can_share;
					$scope.permissions.can_subscribe = Binder.getCurrent().can_subscribe;
					$scope.permissions.can_report = Binder.getCurrent().can_view_master_report;
					$scope.permissions.can_create_seller_report = Binder.getCurrent().can_create_seller_report && Binder.getCurrent().seller_report == undefined;
					$scope.permissions.can_edit_seller_report = Binder.getCurrent().can_edit_seller_report && Binder.getCurrent().seller_report != undefined;
					$scope.permissions.can_transfer = Binder.getCurrent().can_transfer;
					$scope.binder.transfer_url = Binder.getCurrent() ? '#/binders/' + Binder.getCurrent().id + '/transfer' : undefined;
					$scope.binder.report_url = "/api/v1/reports?binder_id=" + Binder.getCurrent().id;
					$scope.binder.report_url += "&api_key=" + Config.getApiKey();
					//$scope.binder.report_url += "&user_token="+ User.current().authentication_token;
					$scope.binder.report_url += "&user_token="+ "aa";
					$scope.binder.seller_report_url = Binder.getCurrent().seller_report == undefined ? 
						undefined : 
						"#/SellerReport/" + Binder.getCurrent().seller_report.code;
					$scope.binder.edit_seller_report_url = Binder.getCurrent().seller_report == undefined ? 
						undefined : 
						"#/SellerReport/" + Binder.getCurrent().seller_report.code + "/edit";
					$scope.binder.logo_url = Binder.getCurrent().partner && Binder.getCurrent().partner.binder_logo ?  
						Binder.getCurrent().partner.binder_logo.location :
						"/assets/landing/flatlogo.png";
				}
			}
			
			$scope.permissions = {};
			$scope.subscription = {};
			$scope.tabs = {};
			$scope.tabs.list = BinderTabs.tabs();
			
			$scope.binder = {};
			
			$scope.$on('binder.selected', function() {
				setBinderInfo();	
			});
			
			$scope.clickToolbarButton = function(button) {
				button.click();
			};
			
			$scope.share = function() {
				var modalInstance = $modal.open({
					templateUrl : "/angular/views/shares/form.html",
					controller : 'ShareFormCtrl'
				});
			};
			
			$scope.createSellerReport = function() {
				SellerReport.create({'binder_id': Binder.getCurrent().id, 'public': true}).success(function(result){
					$location.path('/SellerReport/' + result.code);
				}).error(function(error){
					console.log(error.data);
				});
			};
			
			setTab();
			setBinderInfo();
		}
	};
});