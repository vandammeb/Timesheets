package com.stackandheap.calendar.command {
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;

	import org.as3commons.lang.DateUtils;
	import org.as3commons.lang.StringUtils;

	/**
	 *
	 */
	public class CreateWorkLogsFromEventsCommand {

		public var groupByDay:Boolean;

		private var _events:ArrayCollection;

		// --------------------------------------------------------------------
		//
		// Constructor
		//
		// --------------------------------------------------------------------

		public function CreateWorkLogsFromEventsCommand(events:ArrayCollection) {
			_events = events;
		}

		// --------------------------------------------------------------------
		//
		// Public Methods
		//
		// --------------------------------------------------------------------

		public function execute():ArrayCollection {
			var result:ArrayCollection = new ArrayCollection();

			for each (var event:CalendarEvent in _events) {
				var summaryParts:Array = event.summary.split("-");
				var company:String = StringUtils.trim(summaryParts[0] ? summaryParts[0] : "");
				var project:String = StringUtils.trim(summaryParts[1] ? summaryParts[1] : "");
				var person:String = StringUtils.trim(summaryParts[2] ? summaryParts[2] : "");
				var billable:String = StringUtils.trim(summaryParts[3] ? summaryParts[3] : "");
				var matchingWorkLog:WorkLog;

				if (groupByDay) {
					matchingWorkLog = getMatchingWorkLog(result, event.start, company, project, person);
				}

				if (matchingWorkLog) {
					//trace("Grouping worklogs");
					matchingWorkLog.durationInHours += event.durationInHours;
				} else {
					var workLog:WorkLog = new WorkLog();
					workLog.company = company;
					workLog.project = project;
					workLog.person = person;
					workLog.billable = !StringUtils.hasText(billable);
					workLog.date = (event.start ? event.start : new Date());
					workLog.durationInHours = (event.durationInHours == 24 ? 8 : event.durationInHours);
					//trace("duration in hours: " + workLog.durationInHours);

					result.addItem(workLog);
				}

				matchingWorkLog = null;
			}

			result.sort = new Sort();
			result.sort.fields = [new SortField("date")];
			result.refresh();

			return result;
		}

		// --------------------------------------------------------------------
		//
		// Private Methods
		//
		// --------------------------------------------------------------------

		private function getMatchingWorkLog(workLogs:ArrayCollection, start:Date, company:String, project:String, person:String):WorkLog {
			for each (var workLog:WorkLog in workLogs) {
				if (DateUtils.isSameDay(start, workLog.date) && (workLog.company == company) && (workLog.project == project) && (workLog.person == person)) {
					return workLog;
				}
			}
			return null;
		}

	}
}
