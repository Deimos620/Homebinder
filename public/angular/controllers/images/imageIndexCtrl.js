/*
 * Controller for the document upload page
 */
homebinderControllers.controller('ImageIndexCtrl', ['$scope', '$interval', 'Config', 'Img', 'Binder',
	function($scope, $interval, Config, Img, Binder){
		var s3 = Config.getS3();
		
		$scope.selectedTab = 'images';
		$scope.status = {};
		$scope.upload = {};
		$scope.upload.url = s3 == undefined ? undefined : s3.url;
		$scope.upload.percent = '';
		$scope.upload.multiFiles = []; 
		$scope.upload.filters = [
			{title: "Image files", extensions: "jpg,jpeg,gif,png,bmp"},
			{title: "Video clips", extensions: "mov,mpg"}
		];
		$scope.data = {};
		$scope.data.images = [];
		
		$scope.setMultiPartParams = function() {
			if (s3 != undefined) {
				$scope.upload.multipart_params = {
					'key': 'binder' + Binder.getCurrent().id + '/images/${filename}',
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
		
		$scope.refresh = function() {
			$scope.status.isBusy = true;
			$scope.status.message = "Getting your images. One moment please...";
			var tagId = $scope.resource == undefined ? undefined : $scope.resource.tagId;
			Img.all(tagId).success(function(result){
				$scope.isBusy = false;
				$scope.data.images = result;
			}).error(function(error){
				$scope.isBusy = false;
			});
		};
		
		$scope.uploadFiles = function() {
			$scope.upload.uploader.start();
		};
		
		$scope.onFileUploaded = function(arg) {
			var img = {
				name:arg.file.name,
				binder_id:Binder.getCurrent().id,
				location:arg.response.Location,
				bucket:arg.response.Bucket,
				key:arg.response.Key,
				etag:arg.response.ETag,
				file_size: arg.file.size
			};
			
			if ($scope.resource != undefined && $scope.resource.tagId != undefined) {
				img.tags_attributes = [
					{tag: $scope.resource.tagId, auto_generated: true}
				];
			}
			
			Img.create(img).success(function(result) {
				$scope.data.images.push(result);
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
			console.log(err);
		};
		
		$scope.destroy = function(img) {
			if (confirm("Are you sure you want to delete?")) {
				Img.destroy(img.id).then(
					function(result) {
						for(var k = 0; k < $scope.data.images.length; k++){
							var current = $scope.data.images[k];
							if (current.id == img.id) {
								$scope.data.images.splice(k, 1);
								break;
							}
						}	
					}
				);	
			}
		};
		
		$scope.$on('binder.selected', function() {
			if (Config.getS3() != undefined) {
				$scope.setMultiPartParams();
			}
			$scope.refresh();
		});
		
		$scope.$on('config.loaded', function() {
			$scope.setMultiPartParams();
			if (Binder.getCurrent() != undefined) {
				$scope.refresh();
			}
		});
		
		if (Binder.getCurrent() != undefined) {
			$scope.setMultiPartParams();
			$scope.refresh();
		}
	}
]);