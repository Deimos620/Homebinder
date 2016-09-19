'use strict';

/*
 * Service to make REST calls for inventory items
 */
homebinderServices.factory('InventoryItem',['$http', 'Binder',
	function($http, Binder) {
		return {
			all: function() {
				return $http.get('/api/v1/inventory_items?binder_id=' + Binder.getCurrent().id);
			},
			get: function(inventoryItemId) {
				return $http.get('/api/v1/inventory_items/' + inventoryItemId);
			},
			create: function(inventoryItem) {
				return $http.post('/api/v1/inventory_items/', {inventory_item: inventoryItem});
			},
			update: function(inventoryItemId, inventoryItem) {
				return $http.put('/api/v1/inventory_items/' + inventoryItemId, {inventory_item: inventoryItem});
			},
			destroy: function(inventoryItemId) {
				return $http.delete('/api/v1/inventory_items/' + inventoryItemId);
			}
		};
	}]);
	
/*
 * Service to make REST calls for inventory item types
 */
homebinderServices.factory('InventoryItemType',['$http',
	function($http) {
		return {
			all: function() {
				return $http.get('/api/v1/inventory_item_types/');
			}
		}
	}]);