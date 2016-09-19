'use strict';

angular.module('homebinderApp')
.controller('AgentFreeTrialCtrl', [
    '$scope',
    'FreeTrialService',
    '$modalInstance',
    'data',
    function($scope, FreeTrialService, $modalInstance, data) {
        $scope.form = {};
        $scope.form.partner_type = data.partner_type;
        $scope.form.trial_type = data.trial_type;
        $scope.form.status = 'request_for_info';
        $scope.status = {};
        $scope.status.done = false;
        
        $scope.onSubmit = function() {
            FreeTrialService.create($scope.form).then(
                function(result) {
                    $scope.status.done = true;
                    $scope.error = undefined;
                },
                function(error) {
                    $scope.error = 'Oops, something went wrong. Please verify the fields above are correct.';
                }
            );
        }
        
        $scope.onClose = function() {
            $modalInstance.close();
        }
        
        $scope.onCancel = function() {
            $modalInstance.dismiss('cancel');
        }
}]);