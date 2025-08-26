import AppIntents
import SwiftData

// This app intent actually sets the log in the stored visit.
struct SetVisitLogSnippetIntent: AppIntent {
	
	// 1. Title and description once again.
	static let title: LocalizedStringResource = "Set Visit Log"
	static let description = IntentDescription("Add your thoughts about your visit.")
	
	// 2. Since this is an internal app intent, we don't want to allow the system
	//    to discover it on its own.
	static var isDiscoverable = false
	
	// 3. We're relying on three parameters here. The first two are as usual,
	//    but the `log` won't be populated by us. Instead, we leave it empty,
	//    which allows the system to prompt the user automatically.
	@Parameter
	var landmark: LandmarkEntity
	@Parameter
	var visit: VisitEntity
	@Parameter
	var log: String
	
	// 4. We fetch the stored visit, and replace the log with whatever the
	//    user came up with before the `perform` is run.
	@MainActor
	func perform() async throws -> some IntentResult & OpensIntent {
		let fetchedVisit = try visit.fetchedValue
		fetchedVisit.log = log
		visit.log = log // Some duplication here, because of SwiftData.
		
		// 5. We finish by reopening our original AddVisitIntent.
		return .result(
			opensIntent: AddVisitIntent(landmark: landmark, currentVisit: visit)
		)
	}
}

extension SetVisitLogSnippetIntent {
	// 3a. We don't initialize the log.
	init(visit: VisitEntity, landmark: LandmarkEntity) {
		self.visit = visit
		self.landmark = landmark
	}
}
