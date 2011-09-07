package com.stackandheap.calendar.domain.entity {
	import mx.collections.ArrayCollection;

	public class Client {

		public var name:String;
		public var projects:ArrayCollection = new ArrayCollection();

		// --------------------------------------------------------------------
		//
		// Constructor
		//
		// --------------------------------------------------------------------

		public function Client(name:String) {
			this.name = name;
		}

		// --------------------------------------------------------------------
		//
		// Public Methods
		//
		// --------------------------------------------------------------------

		public function addProject(projectName:String):void {
			projects.addItem(projectName);
		}

		public function hasProject(projectName:String):Boolean {
			for each (var p:String in projects) {
				if (p === projectName) {
					return true;
				}
			}
			return false;
		}
	}
}
