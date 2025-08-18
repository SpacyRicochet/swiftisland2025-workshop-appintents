import Foundation
import SwiftData

@Model
final class Visit {
	var modelID: UUID
	var timestamp: Date
	var log: String
	@Relationship(deleteRule: .nullify, inverse: \Landmark.visits)
	var landmark: Landmark?
	
	init(timestamp: Date, log: String, landmark: Landmark? = nil) {
		self.modelID = UUID()
		self.timestamp = timestamp
		self.log = log
		self.landmark = landmark
	}
}
