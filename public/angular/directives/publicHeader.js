/*
 * Directive 
 */
homebinderDirectives.directive('publicHeader', function() {
	return {
		restrict: 'E',
		templateUrl: '/angular/views/directives/publicHeader.html',
		controller: function($scope, $element, $attrs, $injector) {
		}
	};
});