'use strict';

angular.module('homebinderApp')
.controller('AgentsCtrl', [
    '$scope',
    'ModalService',
    function($scope, ModalService){
        $scope.requestTrial = function(trial_type) {
            ModalService.show({
                templateUrl: 'angular/views/agents/request-free-trial-form.html',
                controller: 'AgentFreeTrialCtrl',
                resolveData: {
                    partner_type: 'real_estate',
                    trial_type: trial_type
                }
            })
        }
        
        // monitor animation
        setInterval(function(){
		  $(".post").toggleClass("display");
		}, 12000);
}]);