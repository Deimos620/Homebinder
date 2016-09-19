'use strict';

angular.module('Homebinder.Admin')
.controller('Admin.PartnersCtrl', [
	'$scope',
	'$location',
	'AdminPartnerService',
	'User',
	function($scope, $location, AdminPartnerService, User) {
		$scope.data = {};
		
		function refresh() {
			if (!User.isLoggedOn()){
				return;
			}
			
			$scope.data.isBusy = true;
			AdminPartnerService.all().success(function(result){
				$scope.data.partners = result;
				$scope.data.isBusy = false;
			}).error(function(error){
				$scope.data.isBusy = false;
			});
		}
		
		$scope.$on('user.logon', function() {
			refresh();
		});
		
		$scope.deletePartner = function(partner) {
			if (confirm("Are you sure you want to delete the partner - " + partner.name + "? This action can not be undone.")){
				AdminPartnerService.destroy(partner.id).success(function(success){
					$location.path('/admin/partners');
				});
			}
		};
		
		refresh();
	}]);