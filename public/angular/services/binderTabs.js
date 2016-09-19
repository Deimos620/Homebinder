'use strict';

/*
 * The BinderTabs service provides a list of the tabs in the binder.
 * Each Tab consists of an id, name, url and status.
 * 
 * id - identifier used to identify tab in code
 * name - used as the tab name and resource list header
 * resourceType - the data type of the resource. Used for uploads
 * url - the MVC url of the resource as in /views/<url>/. Used to retrieve
 * 		 form.html partial and show.html partial for each resource. The url
 * 		 will display in the address bar of the browser.
 * status - specifies whether or not the tab is selected. Provides the class
 */
homebinderServices.factory('BinderTabs', 
	function(){
		var current = null;
		var tabs = [
			{ 
				id : "overview",
				name : "Overview", 
				url : "overview"
			},
			{
				id : "structures",
				name : "Structures",
				resourceType : "structure",
				url : "structures"
			},
			{
				id : "areas",
				name : "Areas & Rooms",
				resourceType : "area",
				url : "areas"
			},
			{
				id : "maintenance",
				name : "Maintenance",
				resourceType: "maintenance_item",
				url : "maintenance_items"
			},
			{
				id : "projects",
				name : "Projects",
				resourceType: "project",
				url : "projects"
			},
			{
				id : "contractors",
				name : "Contractors",
				resourceType: "binder_contractor",
				url : "binder_contractors"
			},
			{
				id : "appliances",
				name : "Appliances",
				resourceType: "appliance",
				url : "appliances"
			},
			{
				id : "finishes",
				name : "Finishes",
				resourceType: "finish",
				url : "finishes"
			},
			{
				id : "paints",
				name : "Paints",
				resourceType: "paint",
				url : "paints"
			},
			{
				id : "inventory",
				name : "Inventory",
				resourceType: "inventory_item",
				url : "inventory_items"
			},
			{
				id : "receipts",
				name : "Receipts",
				resourceType: "receipt",
				url : "receipts"
			},
			{
				id: "spacer"
			},
			{
				id: "documents",
				name: "Documents",
				resourceType: "document",
				url: "documents",
				icon: "glyphicon glyphicon-folder-open"
			},
			{
				id: "images",
				name: "Gallery",
				resourceType: "image",
				url: "images",
				icon: "glyphicon glyphicon-picture"
			}
		];
		return {
			tabs: function() {
				return tabs;
			},
			getCurrent : function() {
				return current;
			},
			setCurrent : function(tab) {
				if (current != null) {
					current.status = null;
				}
				
				tab.status = "active";
				current = tab;
			}
		};
	});
