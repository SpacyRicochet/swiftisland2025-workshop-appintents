import SwiftData

extension Landmark {
	static let texel: Landmark = {
		.init(
			name: "Texel",
			latitude: 53.077764,
			longitude: 4.7134941,
			isFavorite: false,
			lastVisited: nil
		)
	}()
	
	static let prinsHendrik: Landmark = {
		Landmark(
			name: "Prins Hendrik Hotel & Bungalowpark",
			latitude: 53.1148607,
			longitude: 4.8945083,
			isFavorite: false,
			lastVisited: nil
		)
	}()
	
	static let lightHouse: Landmark = {
		Landmark(
			name: "Vuurtoren van Texel",
			latitude: 53.1821339,
			longitude: 4.8528133,
			isFavorite: false,
			lastVisited: nil
		)
	}()
	
	static let ecomare: Landmark = {
		Landmark(
			name: "Zeehondencreche Ecomare",
			latitude: 53.0779344,
			longitude: 4.7428146,
			isFavorite: false,
			lastVisited: nil
		)
	}()
	
	static let utopia: Landmark = {
		Landmark(
			name: "Utopia",
			latitude: 53.1221429,
			longitude: 4.8944967,
			isFavorite: false,
			lastVisited: nil
		)
	}()
	
	static let initialList: [Landmark] = [
		prinsHendrik,
		lightHouse,
		ecomare,
		utopia,
	]
}
