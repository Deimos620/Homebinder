homebinderDirectives.directive('addthisToolbox', ['$timeout', function($timeout) {
  return {
    restrict : 'A',
	  transclude : true,
	  replace : true,
	  template : '<div ng-transclude></div>',
	  link : function($scope, element, attrs) {
		$timeout(function () {
          addthis.init();
          addthis.toolbox($(element).get(), {}, {
            url: attrs.url,
            title : "My Home is for Sale! Click the following link to see the HomeBinder Report for my home.",
            description : 'Click the following link to see the HomeBinder Report for my home. ' + attrs.url,
            icon: 'http://www.homebinder.com/img/flatlogo.png'        
          });
        });
	  }
	};
}]);