import Foundation
import SwiftData

@Model
final class Visit {
	var timestamp: Date
	
	init(timestamp: Date) {
		self.timestamp = timestamp
	}
}
