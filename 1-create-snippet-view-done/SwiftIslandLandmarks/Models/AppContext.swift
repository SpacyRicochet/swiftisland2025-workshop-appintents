import Foundation
import SwiftData

@Model
final class AppContext {
	var firstLaunchTimestamp: Date
	
	init(firstLaunchTimestamp: Date) {
		self.firstLaunchTimestamp = firstLaunchTimestamp
	}
}
