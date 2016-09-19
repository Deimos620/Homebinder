'use strict';

angular.module('Homebinder.Admin')
.controller('Admin.SellerReportsCtrl', [
    '$scope',
    'AdminSellerReportService',
    'User',
    function($scope, AdminSellerReportService, User){
        $scope.data = {};
        $scope.sort = {};
        $scope.sort.column = 'id';
        $scope.sort.reverse = false;
           
        function refresh() {
            if (!User.isLoggedOn()) {
                return;
            }
            
            $scope.data.isBusy = true;
            AdminSellerReportService.all().success(
                function(result){
                    console.log(result);
                    $scope.data.reports = result;
                    $scope.data.isBusy = false;
                }
            ).error(
                function(error){
                    $scope.data.isBusy = false;
                }
            );
        }
        
        $scope.$on('user.logon', function() {
            refresh();
        });
        
        $scope.orderBy = function(column) {
            if (column == $scope.sort.column) {
                $scope.sort.reverse = !$scope.sort.reverse;
                return;
            }
            
            $scope.sort.column = column;
            $scope.sort.reverse = false;
        };
        
        refresh();
}]);