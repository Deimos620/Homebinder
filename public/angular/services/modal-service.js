'use strict';

angular.module('homebinderApp')
.factory('ModalService', ['$modal', function($modal){
    return {
        show: function(modalOptions) {
            var modalInstance = $modal.open({
                templateUrl: modalOptions.templateUrl,
                controller: modalOptions.controller,
                resolve: {
                    data: function() {
                        return modalOptions.resolveData;
                    }
                }
            }).result.then(
                function(resultData){
                    // modal was closed
                    if (modalOptions.closed) {
                        modalOptions.closed(resultData);    
                    }
                },
                function() {
                    // modal was rejected
                    if (modalOptions.rejected) {
                        modalOptions.rejected();    
                    }
                }
            );
        },
        alert: function(notifyOptions) {
            
        },
        warn: function(warnOptions) {
            
        }
    }
}]);