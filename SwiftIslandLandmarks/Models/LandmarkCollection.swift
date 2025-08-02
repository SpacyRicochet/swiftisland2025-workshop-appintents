import SwiftData

@Model
final class LandmarkCollection {
	@Attribute(.unique)
	var name: String
	@Relationship(deleteRule: .nullify, inverse: \Landmark.collections)
	var landmarks: [Landmark]
	
	init(name: String, landmarks: [Landmark]) {
		self.name = name
		self.landmarks = landmarks
	}
}
