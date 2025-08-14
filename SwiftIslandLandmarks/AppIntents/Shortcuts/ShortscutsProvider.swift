import AppIntents

// 1. We can provide app intents to Shortcuts automatically.
//    Having your intent available as a shortcut also means that
//    it will automatically be available throughout the system.
//    For example, when searching for the app or intent.
final class ShortscutsProvider: AppShortcutsProvider {
	
	// 2. The system lets us to pick a color that
	//    represents the app in the Shortcuts app.
	static let shortcutTileColor: ShortcutTileColor = .orange
	
	// 3. The meat of this type, we provide all the intents as shortcuts.
	static var appShortcuts: [AppShortcut] {
		
		// 4. We decide which app intents to add to Shorcuts.
		AppShortcut(
			// 4a. The intent itself.
			intent: OpenFavoritesIntent(),
			phrases: [
				// 4b. Add some phrases that the intent can be launched
				//     with through Siri. Note that each of them needs to
				//     include the `.applicationName` or it won't compile.
				"Open favorites in \(.applicationName)",
			],
			// 4c. Add a short title.
			shortTitle: "Open favorites",
			// 4d. And give it a proper SF symbol.
			systemImageName: "star.fill"
		)
		
		// Let's add our other shortcuts here as well.
		AppShortcut(
			intent: ClosestLandmarkIntent(),
			phrases: [
				"Find closest landmark in \(.applicationName)",
				"What is the nearest landmark in \(.applicationName)"
			],
			shortTitle: "Closest landmark",
			systemImageName: "mappin.and.ellipse"
		)
	}
}
