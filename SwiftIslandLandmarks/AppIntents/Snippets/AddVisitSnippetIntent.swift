import AppIntents
import SwiftData
import SwiftUI

// In this intent we prepare the confirmation screen for adding a visit.
struct AddVisitSnippetIntent: SnippetIntent {
	
	// 1. Add the title.
	static let title: LocalizedStringResource = "Add visit Snippet"
	
	// 2. Add the parameters.
	@Parameter
	var landmark: LandmarkEntity
	@Parameter
	var visit: VisitEntity
	
	// 3. In this easy perform, just return the view we want.
	func perform() async throws -> some IntentResult & ShowsSnippetView {
		return .result(
			view: VisitSnippetView(landmark: landmark, visit: visit)
		)
	}
}

extension AddVisitSnippetIntent {
	init(visit: VisitEntity, landmark: LandmarkEntity) {
		self.visit = visit
		self.landmark = landmark
	}
}
