'use strict';

angular.module('homebinderApp')
.factory('FreeTrialService', ['$http', function($http) {
    return {
        create: function(request) {
            return $http.post('/api/v1/free_trials', {free_trial: request});
        }
    }
}]);