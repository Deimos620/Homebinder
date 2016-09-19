/*
 * Service to make REST calls for documents
 */
homebinderServices.factory('Document',['$http', 'Binder',
	function($http, Binder) {
		return {
			all: function(tag) {
				var url = '/api/v1/documents?binder_id=' + Binder.getCurrent().id;
				if (tag != undefined){
					url += '&tag=' + tag;
				}
				
				return $http.get(url);
			},
			allForBinder: function(id) {
				return $http.get('/api/v1/documents?binder_id=' + id);	
			},
			get: function(documentId) {
				return $http.get('/api/v1/documents/' + documentId);
			},
			create: function(doc) {
				return $http.post('/api/v1/documents/', {document: doc});
			},
			update: function(docId, doc) {
				return $http.put('/api/v1/documents/' + docId, {document: doc});
			},
			destroy: function(documentId) {
				return $http.delete('/api/v1/documents/' + documentId);
			}
		};
	}]);