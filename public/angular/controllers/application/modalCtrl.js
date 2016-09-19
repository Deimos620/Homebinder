homebinderControllers.controller('ModalCtrl', ['$scope', '$modalInstance', 'title', 'majorMessage', 'minorMessage', 'buttons',
	function($scope, $modalInstance, title, majorMessage, minorMessage, buttons){
        $scope.title = title;
        $scope.majorMessage = majorMessage;
        $scope.minorMessage = minorMessage;
        $scope.buttons = buttons;
        angular.forEach($scope.buttons, function(button){
            if (button.isPrimary) {
                button.cls = "btn btn-primary";
            } else if (button.isDanger){
                button.cls = "btn btn-danger";
            } else {
                button.cls = "btn btn-default";
            }
        });
        
        $scope.click = function(button){
            if (button.action == 'close') {
                $modalInstance.close(button.result);
            } else {
                $modalInstance.dismiss(button.reason ? button.reason : undefined);
            }
        }
    }]);