import Foundation
import SwiftData

extension ModelContainer {

	@MainActor
	func landmarks() throws -> [Landmark] {
		return try mainContext.fetch(FetchDescriptor<Landmark>())
	}
	
	@MainActor
	func landmarks(for modelIDs: [UUID]) throws -> [Landmark] {
		let ids = modelIDs
		let fetchDescriptor = FetchDescriptor<Landmark>(
			predicate: #Predicate<Landmark> { ids.contains($0.modelID) }
		)
		return try mainContext.fetch(fetchDescriptor)
	}
}
