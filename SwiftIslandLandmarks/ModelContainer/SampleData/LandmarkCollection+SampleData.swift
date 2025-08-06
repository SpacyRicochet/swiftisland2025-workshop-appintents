import SwiftData

extension LandmarkCollection {
	
	static let initialList = [
		browse,
		favorites,
		swiftIsland,
	]

	static let browse: LandmarkCollection = {
		LandmarkCollection(
			name: "Browse",
			landmarks: []
		)
	}()
	
	static let favorites: LandmarkCollection = {
		LandmarkCollection(
			name: "Favorites",
			landmarks: []
		)
	}()
	
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
