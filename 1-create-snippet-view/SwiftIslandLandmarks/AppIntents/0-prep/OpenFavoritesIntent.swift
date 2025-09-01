import AppIntents
import Foundation
import SwiftData

// My first app intent! Let's open the app in the favorites screen.
struct OpenFavoritesIntent: AppIntent {
	// 1. Every app intent _needs_ a title. Note the type.
	static let title: LocalizedStringResource = "Open favorite landmarks"
	
	// 2. The description is optional. Note the type.
	static let description = IntentDescription("Open the list of your favorite landmarks.")
	
	// 3. Because this intent will open the app, we'll tell the system this.
	static let openAppWhenRun: Bool = true
	
	// 4. We can't run this in a vacuum.
	//    Let's declare anything this intent depends on.
	@Dependency
	private var navigationContext: NavigationContext
	@Dependency
	private var modelContainer: ModelContainer
	
	// 5. Now let's implement the intent's main method, also required.
	//    Because we want to open the app and navigate to a specific screen,
	//    we'll need to run it on the main actor.
	@MainActor
	func perform() async throws -> some IntentResult {
		if let favoritesCollection = try modelContainer.mainContext.fetch(
			FetchDescriptor<LandmarkCollection>(predicate: LandmarkCollection.favoritesPredicate)
		).first {
			navigationContext.selectedCollection = favoritesCollection
		}
		
		// 6. Since we're done, we return an empty result.
		return .result()
	}
}
