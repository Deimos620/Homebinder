/*
 * Service to handle the REST calls for UserTokens
 */
homebinderServices.factory('Validation',[
	function() {
		return {
			isInteger: function(value) {
				var INTEGER_REGEXP = /^\-?\d+$/;
				if (value == undefined || value == null)
					return null;
				if (!INTEGER_REGEXP.test(value))
					return "Value must be a number.";
			},
			isFloat: function(value) {
				var FLOAT_REGEXP = /^\-?\d+((\.|\,)\d+)?$/;
				if (value == undefined || value == null)
					return null;
				if (!FLOAT_REGEXP.test(value))
					return "Value must be a number";
			}
		};
	}]);