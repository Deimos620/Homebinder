/*
 * Service to make REST calls for images
 */
homebinderServices.factory('Img',['$http', 'Binder',
	function($http, Binder) {
		return {
			all: function(tag) {
				var url = '/api/v1/images?binder_id=' + Binder.getCurrent().id;
				if (tag != undefined) {
					url += '&tag=' + tag;
				}
				return $http.get(url);
			},
			allForBinder: function(id) {
				return $http.get('/api/v1/images?binder_id=' + id);
			},
			get: function(imageId) {
				return $http.get('/api/v1/images/' + imageId);
			},
			create: function(img) {
				return $http.post('/api/v1/images/', {image: img});
			},
			update: function(imgId, img) {
				return $http.put('/api/v1/images/' + imgId, {image: img});
			},
			destroy: function(imageId) {
				return $http.delete('/api/v1/images/' + imageId);
			}
		};
	}]);