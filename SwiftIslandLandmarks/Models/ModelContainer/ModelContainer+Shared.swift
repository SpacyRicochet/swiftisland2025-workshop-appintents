import Foundation
import SwiftData

extension ModelContainer {
	static func shared() throws -> ModelContainer {
		let schema = Schema.allEntities
		let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: false)
		let container = try ModelContainer(for: schema, configurations: modelConfiguration)
		try container.insertSampleDataIfNeeded()
		return container
	}
	
	// Insert sample data on first launch.
	func insertSampleDataIfNeeded() throws {
		// If there's no app data yet, this is a first launch.
		// We'll populate some initial landmarks.
		var initialFetch = FetchDescriptor<AppContext>()
		// Setting the limit to one makes the fetch faster.
		initialFetch.fetchLimit = 1
		let fetchResult = try mainContext.fetch(initialFetch)
		assert(fetchResult.count <= 1, "We shouldn't have more than one AppContext instance.")
		if fetchResult.isEmpty {
			// Add some initial data.
			mainContext.insertSampleData()

			// We create the app context, which also acts as the first launch detector.
			let appContext = AppContext(firstLaunchTimestamp: Date())
			mainContext.insert(appContext)
		}
		try mainContext.save()
	}
}
