/*
 * Directive 
 */
homebinderDirectives.directive('applicationFooter', function() {
	return {
		restrict: 'E',
		templateUrl: '/angular/views/directives/applicationFooter.html',
		controller: function($scope, $element, $attrs, $injector) {
		}
	};
});