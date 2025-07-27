import Foundation
import SwiftData

@Model
final class Landmark {
	var name: String
	var coordinates: Coordinates
	var lastVisited: Date?
	var isFavorite: Bool
	
	init(name: String, coordinates: Coordinates, lastVisited: Date?, isFavorite: Bool) {
		self.name = name
		self.coordinates = coordinates
		self.lastVisited = lastVisited
		self.isFavorite = isFavorite
	}
}
