var homebinderApp = angular.module('homebinderApp', [
	'ngRoute',
	'ngCookies',
	'ngSanitize',
	'ui.bootstrap',
	'xeditable',
	'checklist-model',
	'plupload.module',
    //'angular-intercom',
    'homebinderControllers',
	'homebinderServices',
	'homebinderDirectives',
	'homebinderAnimations',
	'Homebinder.Admin',
	'Homebinder.Filters']);

homebinderApp.config(['$routeProvider', /*'IntercomServiceProvider',*/
	function($routeProvider/*, IntercomServiceProvider*/){
		$routeProvider
			.when('/', {
				templateUrl: '/angular/views/landing/landing.html',
				controller: 'LandingCtrl',
				caseInsensitiveMatch: true
			})
			.when('/home', {
				templateUrl: '/angular/views/landing/landing_v1.html',
				caseInsensitiveMatch: true
			})
			.when('/register', {
				templateUrl: '/angular/views/registrations/form.html',
				controller: 'RegistrationFormCtrl',
				caseInsensitiveMatch: true
			})
			/*
			.when('/register/confirm_sent', {
				templateUrl: '/angular/views/registrations/confirm_sent.html',
				caseInsensitiveMatch: true
			})
			.when('/registrations/:token/confirm', {
				templateUrl: '/angular/views/registrations/confirm.html',
				controller: 'RegistrationConfirmCtrl',
				caseInsensitiveMatch: true
			})
			*/
			.when('/passwords/reset', {
				templateUrl: '/angular/views/passwords/reset.html',
				controller: 'PasswordResetFormCtrl',
				caseInsensitiveMatch: true
			})
			.when('/passwords/reset_sent', {
				templateUrl: '/angular/views/passwords/reset_sent.html',
				caseInsensitiveMatch: true
			})
			.when('/passwords/:token/update', {
				templateUrl: '/angular/views/passwords/update.html',
				controller: 'PasswordUpdateFormCtrl',
				caseInsensitiveMatch: true
			})
			.when('/login', {
				templateUrl: '/angular/views/sessions/login.html',
				controller: 'LoginCtrl',
				caseInsensitiveMatch: true
			})
			.when('/binders', {
				templateUrl: '/angular/views/binders/index.html',
				controller: 'BinderIndexCtrl',
				caseInsensitiveMatch: true
			})
			.when('/binders/new', {
				templateUrl: '/angular/views/binders/new.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/edit', {
				templateUrl: '/angular/views/binders/edit.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/transfer', {
				templateUrl: '/angular/views/transfers/new.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId', {
				templateUrl: '/angular/views/binders/binder.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/structures', {
				templateUrl: '/angular/views/structures/index.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/areas', {
				templateUrl: '/angular/views/areas/index.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/maintenance_items', {
				templateUrl: '/angular/views/maintenance_items/index.html',
				caseInsensitiveMatch: true
			})
			.when('/maintenance_items/:maintenanceItemId/maintenance_events', {
				templateUrl: '/angular/views/maintenance_events/index.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/projects', {
				templateUrl: '/angular/views/projects/index.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/binder_contractors', {
				templateUrl: '/angular/views/binder_contractors/index.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/appliances', {
				templateUrl: '/angular/views/appliances/index.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/finishes', {
				templateUrl: '/angular/views/finishes/index.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/paints', {
				templateUrl: '/angular/views/paints/index.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/inventory_items', {
				templateUrl: '/angular/views/inventory_items/index.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/receipts', {
				templateUrl: '/angular/views/receipts/index.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/documents', {
				templateUrl: '/angular/views/documents/index.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/images', {
				templateUrl: '/angular/views/images/index.html',
				caseInsensitiveMatch: true
			})
			.when('/sellerreport/:code', {
				templateUrl: '/angular/views/seller_reports/index.html',
				controller: 'SellerReportCtrl',
				caseInsensitiveMatch: true
			})
			.when('/sellerreport/:code/edit', {
				templateUrl: '/angular/views/seller_reports/form.html',
				controller: 'SellerReportFormCtrl',
				caseInsensitiveMatch: true
			})
			//-------Onboarding UI (Added by Jessica, SimpleFocus)--------------//
			.when('/binders/:binderId/onboarding_wizard/contractors', {
				templateUrl: '/angular/views/onboarding_wizard/steps/contractors.html',
				controller: 'OnboardingWizardCtrl',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/onboarding_wizard/appliances', {
				templateUrl: '/angular/views/onboarding_wizard/steps/appliances.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/onboarding_wizard/maintenance', {
				templateUrl: '/angular/views/onboarding_wizard/steps/maintenance.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/onboarding_wizard/improvements', {
				templateUrl: '/angular/views/onboarding_wizard/steps/home-improvements.html',
				caseInsensitiveMatch: true
			})
			.when('/binders/:binderId/onboarding_wizard/complete', {
				templateUrl: '/angular/views/onboarding_wizard/steps/complete.html',
				caseInsensitiveMatch: true
			})
			//-----------------End--------------------------------------------//
			.when('/binders/:binderId/overview', {
				templateUrl: '/angular/views/binders/binder.html',
				caseInsensitiveMatch: true
			})
			.when('/user_profiles/', {
				templateUrl: '/angular/views/user_profiles/show.html',
				caseInsensitiveMatch: true
			})
			.when('/user_profiles/:profileId/edit', {
				templateUrl: '/angular/views/user_profiles/edit.html',
				caseInsensitiveMatch: true
			})
			.when('/shares/', {
				templateUrl: '/angular/views/shares/index.html',
				caseInsensitiveMatch: true
			})
			.when('/shares/:id', {
				templateUrl: '/angular/views/shares/action.html',
				controller: 'ShareCtrl',
				caseInsensitiveMatch: true
			})
			.when('/subscriptions/', {
				templateUrl: '/angular/views/subscriptions/index.html',
				caseInsensitiveMatch: true
			})
			.when('/subscriptions/:subscriptionId/upgrade', {
				templateUrl: '/angular/views/subscriptions/form.html',
				caseInsensitiveMatch: true
			})
			.when('/subscriptions/:subscriptionId/update', {
				templateUrl: '/angular/views/subscriptions/form.html',
				caseInsensitiveMatch: true
			})
			.when('/buyers_reports/:code', {
				templateUrl: '/angular/views/buyers_reports/show.html',
				caseInsensitiveMatch: true
			})
			.when('/terms', {
				templateUrl: '/angular/views/landing/terms.html',
				caseInsensitiveMatch: true
			})
			.when('/privacy', {
				templateUrl: '/angular/views/landing/privacy.html',
				caseInsensitiveMatch: true
			})
			.when('/internal_error', {
				templateUrl: '/angular/views/landing/500.html'
			})
			.when('/forbidden', {
				templateUrl: '/angular/views/landing/403.html'
			})
			.when('/agents', {
				templateUrl: '/angular/views/agents/agents.html',
				controller: 'AgentsCtrl',
				caseInsensitiveMatch: true
			})
			.otherwise({
				redirectTo: '/'
			});
			/*
        IntercomServiceProvider
            .asyncLoading(true)
            // manually set url since there is no local server running
            .scriptUrl('https://static.intercomcdn.com/intercom.v1.js');
			*/
	}]);
	
// theme to use for xeditable
homebinderApp.run(function(editableOptions) {
  editableOptions.theme = 'bs3'; // bootstrap3 theme. Can be also 'bs2', 'default'
});

// startup operations
homebinderApp.run(['$injector', function($injector){
	var $rootScope = $injector.get('$rootScope');
	var $location = $injector.get('$location');
	var $routeParams = $injector.get('$routeParams');
	var $http = $injector.get('$http');
	var $modal = $injector.get('$modal');
	var Session = $injector.get('Session');
	var User = $injector.get('User');
	var Binder = $injector.get('Binder');
	var Config = $injector.get('Config');
    //var Intercom = $injector.get('Intercom');
	
	// Set the API Key
	$http.defaults.headers.common['HB-ApiKey'] = Config.getApiKey();
	
	// load the config options
	Config.load().success(function(result){
		Stripe.setPublishableKey(result.stripe.public_key);
		$rootScope.$broadcast('config.loaded');
	});

	$rootScope.$on('$locationChangeSuccess', function() {
        loadBinderFromPath();
    });
    
    $rootScope.$on('binder.all', function() {
    	loadBinderFromPath();
    });
	
	$rootScope.$on('global.showModal', function(e, params){
		var modalInstance = $modal.open({
			templateUrl: 'angular/views/application/modal.html',
			controller: 'ModalCtrl',
			backdrop: 'static',
			resolve: {
				title: function(){
					return params.title;
				},
				majorMessage: function(){
					return params.majorMessage;
				},
				minorMessage: function(){
					return params.minorMessage;
				},
				buttons: function(){
					return params.buttons;
				}
			}
		});
		
		modalInstance.result.then(
			function(result) {
				if (params.confirm)
					params.confirm(result);
			},
			function(reason) {
				if (params.cancel)
					params.cancel(reason);
			});
	});
	$rootScope.$on('global.confirmDelete', function(e, params){
		var modalInstance = $modal.open({
			templateUrl: 'angular/views/application/modal.html',
			controller: 'ModalCtrl',
			backdrop: 'static',
			resolve: {
				title: function(){
					return 'Confirm Delete';
				},
				majorMessage: function(){
					return undefined;
				},
				minorMessage: function(){
					return params.message;
				},
				buttons: function(){
					return [
						{
							label: 'Yes',
							isPrimary: true,
							isFocused: true,
							action: 'close',
							result: 'confirm'
						},
						{
							label: 'No',
							action: 'dismiss'
						}
					];
				}
			}
		});
            
		modalInstance.result.then(
			function(result) {
				if (params.confirm)
					params.confirm(result);
			},
			function(reason) {
				if (params.cancel)
					params.cancel(reason);
			});
    });

	var loadBinderFromPath = function() {
		// get the id from the path. $routeParams doesn't seem reliable here
		var pathParts = $location.path().split('/');
		var binder_id;
		for(var k = 0; k < pathParts.length; k++) {
			if (pathParts[k].toLowerCase() == 'binders') {
				if (pathParts.length >= k) {
					binder_id = pathParts[k+1];
					break;
				}
			}
		}

		// If there is no binder Id in the path clear current
		if (!binder_id) {
			if (!Binder.getCurrent()) {
				Binder.setCurrent(undefined);
			}
			return;
		}
		
		// if the current binder is the same as the one in the path we're done
		if (Binder.getCurrent() && Binder.getCurrent().id == binder_id) {
			return;
		}
		// try and select the binder
		var binders = Binder.binders();
		if (binders) {
			for(var k = 0; k < binders.length; k++) {
				if (binders[k].id == binder_id) {
					Binder.setCurrent(binders[k]);
					return;
				}
			}
		}
	};
	
	// Try and init the JWT and user
	User.init();
	Binder.init();
	//loadBinderFromPath();
	
	/* make jumbotrons lock to navbar when scrolling... 
	 * this requires the jumbotron-bar snippet to exist
	 * it should be replaced directly after the jumbotron
	 * and the title/links should be updated as needed
	 * 
	 * <div class="jumbotron-bar navbar navbar-default navbar-fixed-top" style="display:none;">
	 *	<div class="container-fluid">
	 *	 <a class="navbar-brand" href="#/binders/">My Binders</a>
	 *	 <a href="#/binders/new" class="btn btn-primary navbar-btn">Create new binder</a>
	 *	</div>
	 * </div>
	 * 
	 */
	$(function () {
	    $(document).on( 'scroll', function(){
	        if($(window).scrollTop() >= ($(".jumbotron").height() / 2)) { 
	        	$(".jumbotron-bar").fadeIn();
	        	$(".jumbotron").css("visibility", "hidden");
	        }
	        if($(window).scrollTop() < ($(".jumbotron").height() / 2)) { 
	        	$(".jumbotron-bar").fadeOut();
	        	$(".jumbotron").css("visibility", "visible");
	        }
	    });
	});	
}]);
	
/*
homebinderApp.config(['$httpProvider',
	function($httpProvider){
		var authToken = $("meta[name=\"csrf-token\"]").attr("content");
  		$httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken;
	}]);
*/
	