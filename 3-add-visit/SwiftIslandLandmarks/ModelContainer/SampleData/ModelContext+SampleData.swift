import Foundation
import SwiftData

extension ModelContext {
	func insertSampleData() {
		for landmark in Landmark.initialList {
			insert(landmark)
		}
		
		for collection in LandmarkCollection.initialList {
			insert(collection)
		}
	}
	
	func eraseAllData() {
		do {
			for model in try fetch(FetchDescriptor<LandmarkCollection>()) {
				delete(model)
			}
			for model in try fetch(FetchDescriptor<Landmark>()) {
				delete(model)
			}
			for model in try fetch(FetchDescriptor<Visit>()) {
				delete(model)
			}
			for model in try fetch(FetchDescriptor<AppContext>()) {
				delete(model)
			}
		} catch {
			fatalError("Could not delete data: \(error.localizedDescription)")
		}
	}
	
	func resetSampleData() {
		eraseAllData()
		insertSampleData()
		insert(AppContext(firstLaunchTimestamp: Date()))
	}
}
