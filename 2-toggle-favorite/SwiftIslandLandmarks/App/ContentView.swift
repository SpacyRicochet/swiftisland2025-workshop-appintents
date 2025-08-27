import SwiftUI
import SwiftData

struct ContentView: View {
	@State var navigationContext: NavigationContext
	
	init(navigationContext: NavigationContext) {
		self.navigationContext = navigationContext
	}
	
	var body: some View {
		NavigationSplitView {
			MainOverview(navigationContext: $navigationContext)
		} content: {
			LandmarkCollectionDetailView(navigationContext: $navigationContext)
		} detail: {
			LandmarkDetailView(navigationContext: $navigationContext)
		}
	}
}

#Preview {
	ContentView(navigationContext: NavigationContext())
		.modelContainer(try! ModelContainer.sample())
}
