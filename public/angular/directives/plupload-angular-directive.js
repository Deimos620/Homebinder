'use strict';

angular.module('plupload.module', [])
	.directive('plUpload', ['$parse', function ($parse, Config) {
		return {
			restrict: 'A',
			scope: {
				'plProgressModel': '=',
				'plFilesModel': '=',
				'plFiltersModel': '=',
				'plMultiParamsModel':'=',
				'plInstance': '=',
				'plErrorsModel': '=',
				'plUrl' : '='
			},
			link: function ($scope, iElement, iAttrs) {
				$scope.randomString = function(len, charSet) {
					charSet = charSet || 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
					var randomString = '';
					for (var i = 0; i < len; i++) {
						var randomPoz = Math.floor(Math.random() * charSet.length);
						randomString += charSet.substring(randomPoz,randomPoz+1);
					}
					return randomString;
				};
				$scope.$watch('plMultiParamsModel', function(newValue,oldValue){
					if (uploader != undefined) {
						uploader.settings.multipart_params = newValue;
					}
				});
				$scope.$watch('plUrl', function(newValue,oldValue){
					if (uploader != undefined) {
						uploader.settings.url = $scope.plUrl;
					}
				});

				if(!iAttrs.id){
					var randomValue = $scope.randomString(5);
					iAttrs.$set('id', randomValue);	
				}
				if(!iAttrs.plAutoUpload){
					iAttrs.$set('plAutoUpload','true');
				}
				if(!iAttrs.plMaxFileSize){
					iAttrs.$set('plMaxFileSize','10485760');
				}
				if(!iAttrs.plFlashSwfUrl){
					iAttrs.$set('plFlashSwfUrl','../javascripts/plupload/plupload.flash.swf');
				}
				if(!iAttrs.plSilverlightXapUrl){
					iAttrs.$set('plSilverlightXapUrl','../javascripts/plupload/plupload.flash.silverlight.xap');
				}
				if(typeof $scope.plFiltersModel=="undefined"){
					$scope.filters = [{title : "Image files", extensions : "jpg,jpeg,gif,png,tiff,pdf"}];
				} else{
					$scope.filters = $scope.plFiltersModel;
				}

				var options = {
					runtimes : 'html5,flash,silverlight',
					browse_button : iAttrs.id,
					multi_selection: false,
					max_file_size : iAttrs.plMaxFileSize,
					url : iAttrs.plUrl,
					flash_swf_url : iAttrs.plFlashSwfUrl,
					silverlight_xap_url : iAttrs.plSilverlightXapUrl,
					filters : $scope.filters
				};

				if($scope.plMultiParamsModel){
					options.multipart_params = $scope.plMultiParamsModel;
				}

				var uploader = new plupload.Uploader(options);
				uploader.init();

				uploader.bind('Error', function(up, err) {
					if(iAttrs.onFileError){
						var fn = $parse(iAttrs.onFileError);
						fn($scope.$parent, {$error: err});
					}
					
					up.refresh(); // Reposition Flash/Silverlight
 				});

				uploader.bind('FilesAdded', function(up,files) {
					$scope.$apply(function() {
						if(iAttrs.plFilesModel) {
							angular.forEach(files, function(file,key) {
								$scope.plFilesModel.push(file);
							});
						}
							
						if(iAttrs.onFileAdded){
							$scope.$parent.$eval(iAttrs.onFileAdded);
						}
					});

					if(iAttrs.plAutoUpload=="true"){
						uploader.start();
					}
				});

				uploader.bind('FileUploaded', function(up, file, res) {
					var x2js = new X2JS();
					var jsonRes = x2js.xml_str2json(res.response);

					if(iAttrs.onFileUploaded) {
					 	if(iAttrs.plFilesModel) {
					 		$scope.$apply(function() {
					 			angular.forEach($scope.plFilesModel, function(file,key) {
					 				$scope.allUploaded = false;
									if(file.percent==100)
										$scope.allUploaded = true;
								});

								if($scope.allUploaded) {
									var fn = $parse(iAttrs.onFileUploaded);
									fn($scope.$parent, {$response: {file: file, response: jsonRes.PostResponse}});
								}

					 		});
						} else {
							var fn = $parse(iAttrs.onFileUploaded);
							$scope.$apply(function(){
								fn($scope.$parent, {$response: {file: file, response: jsonRes.PostResponse}});
							});
						}
					}
				});

				uploader.bind('UploadProgress',function(up,file){
					if(!iAttrs.plProgressModel){
						return;
					}
					
					if(iAttrs.plFilesModel){
						$scope.$apply(function() {
							$scope.sum = 0;

							angular.forEach($scope.plFilesModel, function(file,key) {
								$scope.sum = $scope.sum + file.percent;
							});

							$scope.plProgressModel = $scope.sum/$scope.plFilesModel.length;
						});
					} else {
						$scope.$apply(function() {
							$scope.plProgressModel = file.percent;
						});
					}


					if(iAttrs.onFileProgress){
						$scope.$parent.$eval(iAttrs.onFileProgress);
					}
				});

				if(iAttrs.plInstance){
					$scope.plInstance = uploader;	
				}
			}
		};
	}]);
