'use strict';

angular.module('Homebinder.Admin')
.controller('Admin.PartnerFormCtrl', [
	'$scope',
	'$location',
	'$routeParams',
	'AdminPartnerService',
	'AdminLogoService',
	function($scope, $location, $routeParams, AdminPartnerService, AdminLogoService) {
		$scope.data = {};
		$scope.options = {};
		$scope.labels = {};
		$scope.options.partner_types = ['broker'];
		var partnerId = $routeParams['partnerId'];
		$scope.labels.title = partnerId ? "Edit Partner" : "New Partner";
		if (partnerId) {
			AdminPartnerService.get(partnerId).success(
				function(result){
					$scope.data.form = result;
					delete $scope.data.form.binder_logo;
					delete $scope.data.form.seller_report_logo;
			});
			AdminLogoService.all(partnerId).success(function(result){
				$scope.logos = result;
			});
		}
		
		$scope.submitForm = function() {
			if ($scope.data.form.errors != undefined) {
				delete $scope.data.form.errors;
			}
			
			if (partnerId) {
				AdminPartnerService.update(partnerId, $scope.data.form).success(function(result) {
					$location.path('/admin/partners/' + result.id);
				}).error(function(error){
					$scope.data.form.errors = error;
				});
			} else {
				AdminPartnerService.create($scope.data.form).success(function(result){
					$location.path('/admin/partners/' + result.id);
				}).error(function(error){
					$scope.data.form.errors = error;
				});
			}
		};
		$scope.cancelForm = function() {
			if (partnerId) {
				$location.path('/admin/partners/' + partnerId);
			} else {
				$location.path('/admin/partners');
			}
		};
	}]);