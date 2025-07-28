import SwiftData

extension LandmarkCollection {
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
