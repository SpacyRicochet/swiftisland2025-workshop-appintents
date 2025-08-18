import Foundation
import SwiftData

@Model
final class Visit {
	var timestamp: Date
	var log: String
	
	init(timestamp: Date, log: String) {
		self.timestamp = timestamp
		self.log = log
	}
}
