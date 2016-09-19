'use strict';

homebinderControllers.controller('PurchaseFormCtrl', ['$scope', 'Store',
	function($scope, Store) {
		$scope.typeahead = {};
		$scope.datepicker = {};
		$scope.datepicker.format="yyyy-MM-dd";
		$scope.datepicker.options={ 'show-button-bar': false };
		Store.all().then(
			function(result) {
				$scope.typeahead.stores = result.data;
			}
		);
	}]);