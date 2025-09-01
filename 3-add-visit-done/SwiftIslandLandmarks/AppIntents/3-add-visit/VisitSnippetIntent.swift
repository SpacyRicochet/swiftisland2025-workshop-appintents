import AppIntents
import SwiftData
import SwiftUI

// Create a snippet intent like LandmarkSnippetIntent,
// where its main purpose is to show an interactive view.
struct VisitSnippetIntent: SnippetIntent {
	
	// 1. Add the required title and other things you might want.
	static let title: LocalizedStringResource = "Add visit Snippet"
	
	// 2. Add the parameters we'll need.
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

extension VisitSnippetIntent {
	init(visit: VisitEntity, landmark: LandmarkEntity) {
		self.visit = visit
		self.landmark = landmark
	}
}
