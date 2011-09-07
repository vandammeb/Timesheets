package {

	public class WorkLog {

		public var company:String;
		public var project:String;
		public var date:Date = new Date();
		public var durationInHours:Number = 0;
		public var person:String;
		public var billable:Boolean;

		public function WorkLog() {
		}
	}
}
