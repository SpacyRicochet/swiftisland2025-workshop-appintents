import SwiftData

extension ModelContainer {
	@MainActor
	static func sample() throws -> ModelContainer {
		let schema = Schema.allEntities
		let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
		let container = try ModelContainer(for: schema, configurations: modelConfiguration)
		container.mainContext.insertSampleData()
		return container
	}
}
