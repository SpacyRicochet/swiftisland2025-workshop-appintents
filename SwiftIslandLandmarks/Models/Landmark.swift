import Foundation
import SwiftData

@Model
final class Landmark {
	@Attribute(.unique)
	var name: String
	var latitude: Double
	var longitude: Double
	var lastVisited: Date?
	var isFavorite: Bool
	
	@Relationship(deleteRule: .nullify, inverse: \LandmarkCollection.landmarks)
	var collection: LandmarkCollection?
	
	init(name: String, latitude: Double, longitude: Double, isFavorite: Bool, lastVisited: Date?) {
		self.name = name
		self.latitude = latitude
		self.longitude = longitude
		self.isFavorite = isFavorite
		self.lastVisited = lastVisited
	}
}
