/**
 * Created by IntelliJ IDEA.
 * User: cherrema
 * Date: 11/12/10
 * Time: 16:10
 * To change this template use File | Settings | File Templates.
 */
package {
	public class CalendarEvent {
		public var start:Date;
		public var end:Date;
		public var summary:String;
		public var startTimeInMinutes:uint;
		public var endTimeInMinutes:uint;

		public function CalendarEvent() {
		}

		public function get durationInMinutes():Number {
			var endTime:Number = (end ? end.time : 0);
			var startTime:Number = (start ? start.time : 0);
			return (endTime - startTime)/1000/60;
		}

		public function get durationInHours():Number {
			return durationInMinutes/60;
		}

		public function toString():String {
			return "CalendarEvent(" + summary + ", " + start + ")";
		}
	}
}
