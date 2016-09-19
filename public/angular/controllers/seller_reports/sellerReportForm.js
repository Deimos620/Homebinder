homebinderControllers.controller('SellerReportFormCtrl', ['$scope', '$location', '$anchorScroll', '$routeParams', '$injector',
	function($scope, $location, $anchorScroll, $routeParams, $injector) {
        var code = $routeParams['code'];
		var SellerReport = $injector.get('SellerReport');
        var Document = $injector.get('Document');
        var Img = $injector.get('Img');
		$scope.data = {};
		
		SellerReport.get(code, true).success(function(result){
			$scope.data.report = result;
		
			Document.allForBinder($scope.data.report.binder.id).success(
				function(result) {
					$scope.data.documents = result;
				}
			);
			
			Img.allForBinder($scope.data.report.binder.id).success(
				function(result) {
					$scope.data.images = result;
				}
			);
		});

        $scope.save = function() {
            var data = {
				public: $scope.data.report.public,
				documents: [],
				images: []
			};
			
			angular.forEach($scope.data.documents, function(doc) {
				if (doc.seller_report_item && doc.seller_report_item.include) {
					data.documents.push(doc.id);
				}
			});
			
			angular.forEach($scope.data.images, function(img) {
				if (img.seller_report_item && img.seller_report_item.include) {
					data.images.push(img.id);
				}
			});
			
			SellerReport.updateDocsAndImages($scope.data.report.id, data).success(
				function(result) {
					$location.path('/binders/' + $scope.data.report.binder.id);
				}
			);
        };
        
        $scope.cancel = function() {
            $location.path('/binders/' + $scope.data.report.binder.id);
        };
    }]);