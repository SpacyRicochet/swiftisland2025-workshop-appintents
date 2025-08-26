import Foundation

extension LandmarkCollection {
	
	static let favoritesPredicate: Predicate<LandmarkCollection> = {
		return #Predicate<LandmarkCollection> { $0.name == "Favorites" }
	}()
}
