homebinderControllers.controller('SellerReportCtrl', ['$scope', '$location', '$anchorScroll', '$routeParams', '$injector',
	function($scope, $location, $anchorScroll, $routeParams, $injector) {
		var code = $routeParams['code'];
		var SellerReport = $injector.get('SellerReport');
		$scope.data = {};

		SellerReport.get(code).success(function(result){
			$scope.data.binder = result.binder;
			$scope.data.appliances = result.appliances;
			$scope.data.contractors = result.binder_contractors;
			$scope.data.maintenance = result.maintenance_items;
			$scope.data.improvements = result.projects;
			$scope.data.paints = result.paints;
			$scope.data.finishes = result.finishes;
			$scope.data.documents = result.documents;
            $scope.data.images = result.images;
			$scope.data.binder.seller_report_url = '/api/v1/seller_report_pdfs/' + result.code;
			$scope.data.binder.logo_url = result.binder.partner ? result.binder.partner.seller_report_logo.location : undefined;
		});

		$scope.scrollToElement = function (element){
		    // set the location.hash to the id of
		    // the element you wish to scroll to.
		    $location.hash(element);
		 
		    // call $anchorScroll()
		    $anchorScroll();
		};
	}
]);