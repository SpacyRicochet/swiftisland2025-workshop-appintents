import SwiftUI

@Observable
final class NavigationContext {
	var selectedCollection: LandmarkCollection?
	var selectedLandmark: Landmark?
	
	init(selectedCollection: LandmarkCollection? = nil, selectedLandmark: Landmark? = nil) {
		self.selectedCollection = selectedCollection
		self.selectedLandmark = selectedLandmark
	}
}
