import Foundation
import SwiftData

@Model
final class Visit {
	var timestamp: Date
	@Relationship(deleteRule: .nullify)
	var landmark: Landmark
	
	init(timestamp: Date, landmark: Landmark) {
		self.timestamp = timestamp
		self.landmark = landmark
	}
}
