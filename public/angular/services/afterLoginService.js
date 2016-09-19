homebinderServices.factory('AfterLoginService',
[
    '$location',
    'Binder',
    function($location, Binder){
        return {
            go: function() {
                Binder.all().then(
                    function(result) {
                        if (result.data.length == 0) {
                            // Go to new binder
                            $location.path('/binders/new');
                        } else if (result.data.length == 1) {
                            // Only 1 binder go to it
                            Binder.setCurrent(result.data[0]);
                            $location.path('/binders/' + result.data[0].id);
                        } else {
                            // check for a primary binder. If there is 1 go to it
                            angular.forEach(result.data, function(binder) {
                                if (binder.primary) {
                                    Binder.setCurrent(binder);
                                    $location.path('/binders/' + binder.id);
                                    return;
                                }
                            });
                            
                            // Go to the list of binders
                            $location.path('/binders');
                        }
                    }
                )
            }
        }
}]);