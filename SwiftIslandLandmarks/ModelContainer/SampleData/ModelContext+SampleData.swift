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
}
