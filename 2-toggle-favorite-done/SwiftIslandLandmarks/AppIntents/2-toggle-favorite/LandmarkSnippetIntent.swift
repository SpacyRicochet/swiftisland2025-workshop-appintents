import AppIntents
import SwiftData
import SwiftUI

// Snippet intents provide ways to make snippets interactive!
// In this case, we want to add a button to the LandmarkSnippetView
// to update the landmark's favorite status.
struct LandmarkSnippetIntent: SnippetIntent {
	
	// 1. Like all the other snippets, we need a title.
	static let title: LocalizedStringResource = "Landmark Snippet"
	
	// 2. We need the landmark entity to work with.
	@Parameter
	var landmark: LandmarkEntity
	
	// 3. And because we'll be showing a view here, we need to
	//    make sure the type reflects this.
	func perform() async throws -> some IntentResult & ShowsSnippetView {
		return .result(
			view: LandmarkSnippetView(landmark: landmark)
		)
	}
}

// 4. We need to declare another initializer in an extension, because the `init()` is
//    required. But we also need a parametrized version for our snippet to call.
extension LandmarkSnippetIntent {
	init(landmark: LandmarkEntity) {
		self.landmark = landmark
	}
}
