import Foundation
import SwiftData

@Model
final class Landmark {
	@Attribute(.unique)
	var name: String
	var latitude: Double
	var longitude: Double
	var isFavorite: Bool
	
	@Relationship(deleteRule: .nullify, inverse: \LandmarkCollection.landmarks)
	var collection: LandmarkCollection?
	
	@Relationship(deleteRule: .cascade, inverse: \Visit.landmark)
	var visits: [Visit]
	
	init(
		name: String,
		latitude: Double,
		longitude: Double,
		isFavorite: Bool,
		lastVisited: Date?,
		visits: [Visit] = []
	) {
		self.name = name
		self.latitude = latitude
		self.longitude = longitude
		self.isFavorite = isFavorite
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
