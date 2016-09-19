homebinderControllers.controller('OnboardingWizardCtrl', ['$scope', '$location', '$routeParams', '$window', '$injector',
	function($scope, $location, $routeParams, $window, $injector) {
		var currentBinderId = $routeParams['binderId'];
		var currentIndex = 0;
		var Binder = $injector.get('Binder');
		var BinderContractor = $injector.get('BinderContractor');
		var Appliance = $injector.get('Appliance');
		var MaintenanceItem = $injector.get('MaintenanceItem');
		var Project = $injector.get('Project');
		var SellerReport = $injector.get('SellerReport');
		
		$scope.data = {};
		$scope.options = {};
		$scope.options.years = [];
		var currentYear = new Date().getFullYear();
		for (var k = currentYear; k > currentYear - 50; k--) {
			$scope.options.years.push(k);
		}
		$scope.nextpage = "none";
		$scope.steps= [
			{
				label: 'Contractors',
				path: '/onboarding_wizard/contractors'
			},
			{
				label: 'Appliances',
				path: '/onboarding_wizard/appliances'
			},
			{
				label: 'Maintenance Items',
				path: '/onboarding_wizard/maintenance'
			},
			{
				label: 'Completed Projects',
				path: '/onboarding_wizard/improvements'
			},
			{
				label: 'Complete',
				path: '/onboarding_wizard/complete'
			}
		];
		$scope.datepicker = {};
		$scope.datepicker.format="yyyy-MM-dd";
		$scope.datepicker.options={ 'show-button-bar': false };
		
		function getCurrentStep() {
			var parts = $location.path().split('/');
			return parts[parts.length-1];
		}
		
		function moveToNextPage() {
			for (var i=0; i<$scope.steps.length; i++) {
		        if ($location.path().indexOf($scope.steps[i].path) >= 0) {
					$location.path('/binders/'+currentBinderId+$scope.steps[i+1].path);
					break;
		         }
		    }
		}
		
		function init() {
			current_step = getCurrentStep();
			if (current_step == 'contractors') {
				initContractors();
				loadContractorTypeaheads();
			} else if (current_step == 'appliances') {
				initAppliances();
				loadApplianceTypeaheads();
			} else if (current_step == 'maintenance') {
				initMaintenance();
				loadMaintenanceTypeaheads();
			} else if (current_step == 'improvements') {
				initProjects();
			} else if (current_step == 'complete') {
				$scope.complete = {};
				$scope.complete.binder_url = '#/binders/' + currentBinderId;
			}
		}
		
		function loadContractorTypeaheads() {
			$scope.typeahead = {};
			var ContractorType = $injector.get('ContractorType');
			ContractorType.all().success(function(result){
				$scope.typeahead.contractor_types = result;
			});
		}
		function initContractors() {
			$scope.forms = [];
			for (var k = 0; k < 4; k++) {
				$scope.forms.push({
					name: undefined
				});
			}
		}
		
		function loadApplianceTypeaheads() {
			$scope.typeahead = {};
			var ApplianceManufacturer = $injector.get('ApplianceManufacturer');
			ApplianceManufacturer.all().success(function(result){
				$scope.typeahead.appliance_manufacturers = result;
			});
		}
		
		function initAppliances() {
			var year = new Date().getFullYear();
			$scope.forms = [
				{
					name: 'Refrigerator',
					install_date_year: year
				},
				{
					name: 'Dishwasher',
					install_date_year: year
				},
				{
					name: 'Microwave',
					install_date_year: year
				},
				{
					name: 'Stove',
					install_date_year: year
				},
				{
					name: 'Washer',
					install_date_year: year
				},
				{
					name: 'Dryer',
					install_date_year: year
				}
			];
			
		}
		
		function loadMaintenanceTypeaheads() {
			$scope.options = {};
			var MaintenanceCycle = $injector.get('MaintenanceCycle');
			MaintenanceCycle.all().success(function(result){
				$scope.options.maintenance_cycles = result;
			});
		}
		
		function initMaintenance() {
			$scope.forms = [];
			for (var k = 0; k < 4; k++) {
				$scope.forms.push({
					name: undefined,
					interval: 1,
					maintenance_cycle: 'Years'
				});
			}
		}
		
		function initProjects() {
			$scope.forms = [];
			for (var k = 0; k < 4; k++) {
				$scope.forms.push({
					name: undefined,
					end_date_year: new Date().getFullYear()
				});
			}
		}
		
		function moveToNextForm() {
			$scope.forms[currentIndex].disabled = true;
			currentIndex++;
			saveForms();	
		}
		
		function saveForms(index) {
			if (currentIndex == $scope.forms.length) {
				moveToNextPage();
				return;
			}
			
			var form = $scope.forms[currentIndex];
			if (form.name == undefined || form.name == "") {
				moveToNextForm();
				return;
			}
			
			if (getCurrentStep() == 'contractors') {
				BinderContractor.create(
					{
						binder_id: currentBinderId,
						details: form.details,
						contractor_attributes: {
							name: form.name,
							contractor_type: form.type,
							phone: form.phone,
							email: form.email
						}
					}
				).success(function(result){
					moveToNextForm();
				}).error(function(error){
					// TODO: Deal with errors. Probably from bad phone number
				});
			} else if (getCurrentStep() == 'appliances') {
				Appliance.create(
					{
						binder_id: currentBinderId,
						name: form.name,
						manufacturer: form.manufacturer,
						install_date: '1/1/' + form.install_date_year,
						details: form.details
					}
				).success(function(result){
					moveToNextForm();
				}).error(function(error){
					// TODO: Deal with errors
				});
			} else if (getCurrentStep() == 'maintenance') {
				MaintenanceItem.create(
					{
						binder_id: currentBinderId,
						name: form.name,
						interval: form.interval,
						maintenance_cycle: form.maintenance_cycle,
						details: form.details
					}
				).success(function(result){
					moveToNextForm();
				}).error(function(error){
					console.log(error.data);
				});
			} else if (getCurrentStep() == 'improvements') {
				Project.create(
					{
						binder_id: currentBinderId,
						name: form.name,
						end_date: '1/1/' + form.end_date_year,
						status: 'Completed',
						details: form.details
					}
				).success(function(result){
					moveToNextForm();
				}).error(function(error){
					// TODO: Deal with errors
				});
			}
		}
		
		$scope.getNumber = function(num) {
		    return new Array(num);
		};

		$scope.addRow = function() {
			var year = new Date().getFullYear();
			if (getCurrentStep() == 'contractors') {
				$scope.forms.push({
					name: undefined
				}); 
			}
			else if (getCurrentStep() == 'appliances') {
				$scope.forms.push({
					name: undefined,
					install_year: year
				}); 
			}
			else if (getCurrentStep() == 'maintenance') {
				$scope.forms.push({
					name: undefined,
					interval: 1,
					maintenance_cycle: 'Years'
				});
			}
			else if (getCurrentStep() == 'improvements') {
				$scope.forms.push({
					name: undefined,
					end_date_year: year
				});
			} 
		};
		
		$scope.deleteRow = function(index) {
			$scope.forms[index].name = undefined;
		};

		$scope.getClass = function(path, index) {
			var match = $location.path().indexOf(path), currentIndex = 0, stepClass = "";
			
			for (var i=0; i<$scope.steps.length; i++) {
		        if ($location.path().indexOf($scope.steps[i].path) >= 0) { currentIndex = i; }
		    }

			if(match >= 0) {
				stepClass = ' active';
			}
			else if (index < currentIndex) {
				stepClass = "complete";
			}
			return stepClass;

		};
		$scope.nextPage = function() {
			saveForms();
		};
		$scope.cancelForm = function() {
			$location.path('/binders/'+currentBinderId);
		};
		$scope.generateSellerReport = function() {
			var url = 'http://' + $location.host();
			if ($location.port() != '80') {
				url += ":" + $location.port();
			}
			url += '/#/';
			if (Binder.getCurrent().seller_report == undefined) {
				SellerReport.create({'binder_id': currentBinderId, 'public': true}).success(function(result){
					$window.open(url + 'SellerReport/' + result.code);
				}).error(function(error){
					console.log(error.data);
				});
			} else {
				$window.open(url + 'SellerReport/' + Binder.getCurrent().seller_report.code);
			}
		};

		init();
}]);