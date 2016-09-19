'use strict';

angular.module('Homebinder.Admin')
.controller('Admin.PartnerCtrl', [
	'$scope',
	'$location',
	'$routeParams',
	'AdminPartnerService',
	'AdminLogoService',
	'Config',
	function($scope, $location, $routeParams, Partner, Logo, Config) {
		var s3 = Config.getS3();
		var partnerId = $routeParams['partnerId'];
		
		$scope.data = {};
		$scope.upload = {};
		$scope.upload.url = s3 == undefined ? undefined : s3.url;
		$scope.upload.percent = '';
		$scope.upload.multiFiles = []; 
		$scope.upload.filters = [
			{title: "Image files", extensions: "jpg,jpeg,gif,png,bmp"},
			{title: "Video clips", extensions: "mov,mpg"}
		];
		$scope.data = {};
		$scope.data.logos = [];
		
		function setMultiPartParams() {
			if (s3 != undefined) {
				$scope.upload.multipart_params = {
					'key': 'partner' + partnerId + '/logos/${filename}',
				    'Filename': '${filename}', 
				  	'acl': s3.acl,
				    'Content-Type': 'multipart/mixed',
				    'success_action_status': '201',
				    'AWSAccessKeyId' : s3.access_key_id,
				    'policy': s3.policy,
				    'signature': s3.signature
				};
			}
		};
		
		function refresh() {
			$scope.data.isBusy = true;
			Partner.get(partnerId).success(function(result){
				$scope.partner = result;
				$scope.data.isBusy = false;
				setMultiPartParams();
			}).error(function(error){
				$scope.data.isBusy = false;
			});
			
			Logo.all(partnerId).success(function(result){
				$scope.data.logos = result;
			}).error(function(error){
				console.log(error.data);
			});
		}
		
		$scope.$on('user.logon', function() {
			refresh();
		});
		
		$scope.$on('config.loaded', function() {
			setMultiPartParams();
		});
		
		$scope.onFileUploaded = function(arg) {
			var logo = {
				partner_id:$scope.partner.id,
				name:arg.file.name,
				location:arg.response.Location,
				bucket:arg.response.Bucket,
				key:arg.response.Key,
				etag:arg.response.ETag
			};
			
			Logo.create(logo).success(function(result) {
				$scope.data.logos.push(result);
				for (var k = 0; k < $scope.upload.multiFiles.length; k++) {
					var uploaded = $scope.upload.multiFiles[k];
					if (uploaded.name == result.name) {
						$scope.upload.multiFiles.splice(k, 1);
						return;
					}
				}
			});
		};
		
		$scope.onFileError = function(err) {
			console.log(err.data);
		};
		
		$scope.deletePartner = function(partner) {
			if (confirm("Are you sure you want to delete the partner - " + partner.name + "? This action can not be undone.")){
				Partner.destroy(partner.id).success(function(success){
					$location.path('/partners');
				});
			}
		};
		
		$scope.deleteLogo = function(logo) {
			
		};
		
		refresh();
	}]);