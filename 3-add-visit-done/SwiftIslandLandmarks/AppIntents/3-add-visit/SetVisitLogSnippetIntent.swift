import AppIntents
import SwiftData

// Make an app intent actually sets the log in the stored visit.
// When adding a log parameter, make sure to keep it empty!
struct SetVisitLogSnippetIntent: AppIntent {
	
	// 1. Start with our standard app intent code.
	//    Bonus points: make the intent undiscoverable.
	static let title: LocalizedStringResource = "Set Visit Log"
	static let description = IntentDescription("Add your thoughts about your visit.")
	static var isDiscoverable = false
	
	// 2. We're relying on three parameters here. The first two are as usual,
	//    but the `log` won't be populated by us. Instead, we leave it empty,
	//    which allows the system to prompt the user automatically.
	@Parameter
	var landmark: LandmarkEntity
	@Parameter
	var visit: VisitEntity
	@Parameter
	var log: String
	
	// 3. The `perform` method will store the log and return the visit as a result.
	@MainActor
	func perform() async throws -> some IntentResult & OpensIntent {
		// 3a. We fetch the stored visit, and replace the log with whatever the
		//     user came up with before the `perform` is run.
		let fetchedVisit = try visit.fetchedValue
		fetchedVisit.log = log
		visit.log = log // Some duplication here, because of SwiftData.
		
		// 4. We finish by reopening our original AddVisitIntent
		//    with the _updated_ visit entity.
		return .result(
			opensIntent: AddVisitIntent(landmark: landmark, currentVisit: visit)
		)
	}
}

// 5. Add the extra initializer.
extension SetVisitLogSnippetIntent {
	init(visit: VisitEntity, landmark: LandmarkEntity) {
		self.visit = visit
		self.landmark = landmark
	}
}

// Bonus points: instead of leaving `log` nil, try filling it with
// an empty string or with the visit's current log.
// Then try to use `$log.requestValue` to edit it instead.
