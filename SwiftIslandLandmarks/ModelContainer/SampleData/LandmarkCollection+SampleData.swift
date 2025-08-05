import SwiftData

extension LandmarkCollection {
	
	static let initialList = [swiftIsland]
	
	static let swiftIsland: LandmarkCollection = {
		LandmarkCollection(
			name: "Swift Island",
			landmarks: [
				Landmark.prinsHendrik,
				Landmark.utopia,
			]
		)
	}()
}
