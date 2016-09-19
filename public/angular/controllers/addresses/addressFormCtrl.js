'use strict';

homebinderControllers.controller('AddressFormCtrl', ['$scope', 'Address',
	function($scope, Address) {
		$scope.options = {};
		$scope.options.countries = Address.countries();
		$scope.options.subregions = Address.getSubregions('US');
	}]);