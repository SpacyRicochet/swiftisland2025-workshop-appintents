import SwiftData

extension Landmark {
	static func texel() -> Landmark {
		.init(
			name: "Texel",
			coordinates: .init(latitude: 53.077764, longitude: 4.7134941),
			lastVisited: nil,
			isFavorite: false
		)
	}
	
	static let initialList: [Landmark] = [
		Landmark(
			name: "Prins Hendrik Hotel & Bungalowpark",
			coordinates: .init(latitude: 53.1148607, longitude: 4.8945083),
			lastVisited: nil,
			isFavorite: false
		),
		Landmark(
			name: "Vuurtoren van Texel",
			coordinates: .init(latitude: 53.1821339, longitude: 4.8528133),
			lastVisited: nil,
			isFavorite: false
		),
		Landmark(
			name: "Zeehondencreche Ecomare",
			coordinates: .init(latitude: 53.0779344, longitude: 4.7428146),
			lastVisited: nil,
			isFavorite: false
		),
		Landmark(
			name: "Utopia",
			coordinates: .init(latitude: 53.1221429, longitude: 4.8944967),
			lastVisited: nil,
			isFavorite: false
		),
	]
}
