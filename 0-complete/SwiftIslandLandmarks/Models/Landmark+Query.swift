import Foundation

extension Landmark {
	
	static let favoritesPredicate: Predicate<Landmark> = {
		return #Predicate<Landmark> { $0.isFavorite }
	}()
}
