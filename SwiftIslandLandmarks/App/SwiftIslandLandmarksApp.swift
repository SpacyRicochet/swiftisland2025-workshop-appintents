import AppIntents
import SwiftUI
import SwiftData

@main
struct SwiftIslandLandmarksApp: App {
	// 1. Because we'll be registering the dependencies to the dependency manager,
	//    we need to make sure we don't have to capture self.
	private let sharedModelContainer: ModelContainer
	private let sharedNavigationContext: NavigationContext
	
	init() {
		do {
			// 2. Instead, we'll create the dependencies in the init and assign them
			//    to the properties.
			let modelContainer = try ModelContainer.shared()
			sharedModelContainer = modelContainer
			
			let navigationContext = NavigationContext()
			sharedNavigationContext = navigationContext
			
			// 3. And now we can register them as an app dependency.
			AppDependencyManager.shared.add(dependency: modelContainer)
			AppDependencyManager.shared.add(dependency: navigationContext)
			
		} catch {
			fatalError("Could not create ModelContainer: \(error)")
		}
	}
	
	var body: some Scene {
		WindowGroup {
			ContentView(navigationContext: sharedNavigationContext)
		}
		.modelContainer(sharedModelContainer)
	}
}
