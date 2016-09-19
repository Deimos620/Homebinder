'use strict';

angular.module('Homebinder.Admin')
.factory('AdminUserService', ['$http', function($http){
    return {
      get: function() {
        return $http.get('/admin/users');
      },
      destroy: function(id) {
        return $http.delete('/admin/users/' + id);
      }
    };
}]);