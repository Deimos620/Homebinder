'use strict';

/*
 * The Errors service parse errors from the response of
 * an HTTP service call.
 */
homebinderServices.factory('Errors', 
	function(){
		 function addUnknownError(error) {
			var errors = new Array();
			errors.push('An unexpected error has occurred. If the issue persists please contact support');
			return errors;
		};
		
		function parseUnprocessableEntity(error) {
			var errorArray = new Array();
			var propErrors = error;
			for (var prop in propErrors) {
				var errors = propErrors[prop];
				for (var err in errors) {
					errorArray.push(prop + " - " + errors[err]);
				}
			}
			return errorArray;
		};
		
		return {
			parseErrors: function(error) {
               var errors = parseUnprocessableEntity(error);
               if (errors.length == 0) {
                    errors.push(error);
               }
               return errors;
               /*
				switch(error.status)
				{
					case 422:
						return parseUnprocessableEntity(error);
					default:
						return addUnknownError(error);
				}
                */
			}
		};
	});