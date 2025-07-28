import Foundation
import SwiftData

@Model
final class Landmark {
	var name: String
	var latitude: Double
	var longitude: Double
	var lastVisited: Date?
	var isFavorite: Bool
	
	init(name: String, latitude: Double, longitude: Double, isFavorite: Bool, lastVisited: Date?) {
		self.name = name
		self.latitude = latitude
		self.longitude = longitude
		self.isFavorite = isFavorite
		self.lastVisited = lastVisited
	}
}
