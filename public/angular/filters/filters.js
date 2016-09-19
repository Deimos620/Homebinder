'use strict';

angular.module('Homebinder.Filters',[])
// filter for converting to different file sizes
.filter('bytes', function() {
	return function(bytes, precision) {
		if (isNaN(parseFloat(bytes)) || !isFinite(bytes)) return '-';
		if (typeof precision === 'undefined') precision = 1;
		var units = ['bytes', 'kB', 'MB', 'GB', 'TB', 'PB'],
			number = Math.floor(Math.log(bytes) / Math.log(1024));
		return (bytes / Math.pow(1024, Math.floor(number))).toFixed(precision) +  ' ' + units[number];
	};
})
// filter for splitting an array at a certain point
.filter('splitArrayFilter', function() {
  	return function(arr, lengthofsublist) {
	    if (!angular.isUndefined(arr) && arr.length > 0) {
	    	
	      	var arrayToReturn = [];  
	      	var subArray=[]; 
	      	var pushed=true;   
	      	   
      		for (var i=0; i<arr.length; i++){
        		if ((i+1)%lengthofsublist==0) {
          			subArray.push(arr[i]);
          			arrayToReturn.push(subArray);
	          		subArray=[];
	          		pushed=true;
	        	} else {
	          		subArray.push(arr[i]);
	          		pushed=false;
	        	}
	      	}
	      	if (!pushed)
	        	arrayToReturn.push(subArray);
			
	      	return arrayToReturn; 
	    }
        return arr;
  	};
})
// filter for formatting phone numbers
.filter('tel', function () {
    return function (phoneNumber) {
        if (!phoneNumber)
            return phoneNumber;

        return formatLocal('US', phoneNumber); 
    };
})
// filter to titleize a string
.filter('titleize', function() {
	return function(value) {
		
		function titleize(value) {
			var result = '';
			for(var k = 0; k < value.length; k++) {
				if (k == 0) {
					result += value.charAt(k).toUpperCase();
				} else if (value[k-1] == ' ') {
					result += value.charAt(k).toUpperCase();
				}
				else {
					result += value.charAt(k);
				}
			}
			return result;
		}
		
		if (angular.isString(value)) {
			return titleize(value);
		} else if (angular.isArray(value)) {
			for(var k = 0; k < value.length; k++) {
				value[k] = titleize(value[k]);
			}
			return value;
		} else {
			return value;
		}
	};
})
// filter for ???
.filter('orderObjectBy', function() { 
	return function(input, attribute, direction) { 
		if (!angular.isObject(input)) return input; 
		
		var array = []; 
		for(var objectKey in input) { 
			array.push(input[objectKey]); 
		}
		
		array.sort(function(a, b){ 
			var alc = a[attribute],
      			blc = b[attribute];
  			
  			if(direction == 'asc')
  				return alc > blc ? 1 : alc < blc ? -1 : 0;
  			else
  				return alc > blc ? -1 : alc < blc ? 1 : 0;
		}); 

		return array; 
	} 
})
// filter to translate true/false to yes/no
.filter('yesNo', function(){
   return function(value) {
    return value == true ? "Yes" : "No";
   }
})
// filter to convert a subscription id into a label for display
.filter('subscriptionLabel', function(){
	return function(id, site) {
		switch(site){
			case 'home':
				return id == 'free' ? 'Renter' : 'Homeowner';
			case 'auto':
			case 'boat':
			default:
				return id;
		}
	}
});