import SwiftUI
import SwiftData

@main
struct SwiftIslandLandmarksApp: App {
	var sharedModelContainer: ModelContainer = {
		do {
			return try ModelContainer.shared()
		} catch {
			fatalError("Could not create ModelContainer: \(error)")
		}
	}()
	
	var body: some Scene {
		WindowGroup {
			ContentView()
		}
		.modelContainer(sharedModelContainer)
	}
}
