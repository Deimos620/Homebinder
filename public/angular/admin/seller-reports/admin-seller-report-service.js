'use strict';

angular.module('Homebinder.Admin')
.factory('AdminSellerReportService', ['$http', function($http){
    return {
        all: function() {
            return $http.get('/admin/seller_reports');
        }
    }
}]);