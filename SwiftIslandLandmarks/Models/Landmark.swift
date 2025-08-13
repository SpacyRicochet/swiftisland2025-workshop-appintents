import Foundation
import SwiftData

@Model
final class Landmark {
	@Attribute(.unique)
	var modelID: UUID
	@Attribute(.unique)
	var name: String
	var latitude: Double
	var longitude: Double
	var isFavorite: Bool
	
	@Relationship(deleteRule: .nullify)
	var collections: [LandmarkCollection]
	
	@Relationship(deleteRule: .cascade)
	var visits: [Visit]
	
	init(
		name: String,
		latitude: Double,
		longitude: Double,
		isFavorite: Bool,
		lastVisited: Date?,
		collections: [LandmarkCollection] = [],
		visits: [Visit] = []
	) {
		self.modelID = UUID()
		self.name = name
		self.latitude = latitude
		self.longitude = longitude
		self.isFavorite = isFavorite
		self.collections = collections
		self.visits = visits
	}
}

extension Landmark {
	var lastVisited: Date? {
		guard !visits.isEmpty else {
			return nil
		}
		return visits.sorted(using: SortDescriptor(\.timestamp, order: .reverse)).first?.timestamp
	}
}
