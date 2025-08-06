import SwiftUI
import SwiftData

struct ContentView: View {
	@State var navigationContext = NavigationContext()
	
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
	ContentView()
		.modelContainer(try! ModelContainer.sample())
}
