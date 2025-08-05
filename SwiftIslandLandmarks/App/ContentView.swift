import SwiftUI
import SwiftData

struct ContentView: View {
	var body: some View {
		NavigationSplitView {
			MainOverview()
		} detail: {
			NavigationStack {
				Text("Select an item")
			}
		}
	}
}

#Preview {
	ContentView()
		.modelContainer(try! ModelContainer.sample())
}
