/*
 * Controller for the document upload page
 */
homebinderControllers.controller('DocumentIndexCtrl', ['$scope', '$interval', 'Config', 'Document', 'Binder',
	function($scope, $interval, Config, Document, Binder){
		var s3 = Config.getS3();
		
		$scope.selectedTab = 'documents';
		$scope.status = {};
		$scope.upload = {};
		$scope.upload.url =  s3 == undefined ? undefined : s3.url;
		$scope.upload.percent = '';
		$scope.upload.multiFiles = []; 
		$scope.upload.filters = [
			{title: "Document files", extensions: "pdf,ppt,pptx,doc,docx,xls,xlsx,txt"},
	      	{title: "Compressed files", extensions: "rar,zip"}
		];
		$scope.data = {};
		$scope.data.documents = [];
		
		$scope.setMultiPartParams = function() {
			if (s3 != undefined) {
				$scope.upload.multipart_params = {
					'key': 'binder' + Binder.getCurrent().id + '/documents/${filename}',
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
			$scope.status.message = "Getting your documents. One moment please...";
			var tagId = $scope.resource == undefined ? undefined : $scope.resource.tagId;
			Document.all(tagId).success(function(result){
				$scope.isBusy = false;
				$scope.data.documents = result;
			}).error(function(error){
				$scope.isBusy = false;
			});
		};
		
		$scope.newDocument = function() {
			// create a new document object and insert it at the top of the list
			var doc = {
				id: 0,
				binder_id: Binder.getCurrent().id,
				name: 'New Document'
			};
			
			$scope.data.documents.splice(0,0,doc);
			// Need to give a little time for the form to be rendered. Would prefer
			// not to use a 'sleep' but haven't found a better way to do this
			var delay = $interval(function(){
				$interval.cancel(delay);
				// broadcast down to the child scopes to begin editing
				$scope.$broadcast('document.edit', finish.id);
			}, 250, 1);
		};
		
		$scope.uploadFiles = function() {
			$scope.upload.uploader.start();
		};
		
		$scope.onFileUploaded = function(arg) {
			var doc = {
				name:arg.file.name,
				binder_id:Binder.getCurrent().id,
				location:arg.response.Location,
				bucket:arg.response.Bucket,
				key:arg.response.Key,
				etag:arg.response.ETag,
				file_size: arg.file.size
			};
			
			if ($scope.resource != undefined && $scope.resource.tagId != undefined) {
				doc.tags_attributes = [
					{tag: $scope.resource.tagId, auto_generated: true}
				];
			}
			
			Document.create(doc).success(function(result) {
				$scope.data.documents.push(result);
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
		
		$scope.destroy = function(doc) {
			if (confirm("Are you sure you want to delete?")) {
				Document.destroy(doc.id).then(
					function(result) {
						for(var k = 0; k < $scope.data.documents.length; k++){
							var current = $scope.data.documents[k];
							if (current.id == doc.id) {
								$scope.data.documents.splice(k, 1);
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