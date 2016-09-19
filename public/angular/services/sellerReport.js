/*
 * Service to handle the REST calls for Seller Report
 */
homebinderServices.factory('SellerReport',['$http',
	function($http) {
		return {
			get: function(reportCode, edit) {
				var url = '/api/v1/seller_reports/' + reportCode;
				if (edit)
					url += "?edit=yes";
				return $http.get(url);
			},
			create: function(report) {
				return $http.post('/api/v1/seller_reports/', {seller_report: report});
			},
			update: function(report) {
				return $http.put('/api/v1/seller_reports/' + report.seller_report.id, report);
			},
			updateDocsAndImages: function(id, data) {
				return $http.put('/api/v1/seller_reports/' + id, data);
			},
			destroy: function(reportCode) {
				return $http.delete('/api/v1/seller_reports/' + reportCode);
			}
		};
	}]);