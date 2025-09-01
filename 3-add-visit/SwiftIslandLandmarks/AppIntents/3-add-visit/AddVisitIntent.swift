import AppIntents
import SwiftData

// We want to add a visit to a landmark.
// Create the app intent that will request a confirmation through a snippet intent.
struct AddVisitIntent: AppIntent {
	
	// 1. Let's add a title and a description.

	// 2. Let's set up all the parameters that we'll need.

	// 3. Here is the meat of our intent! We have to create a Visit first, so we can
	//    query it in our intent chain. After we're done constructing it, we can
	//    add the visit to the landmark.
	@MainActor
	func perform() async throws -> some IntentResult {
		
		// 3a. We need to make sure that we have a persisted visit, that we can query
		// along our intent daisy chain.


		// 3b. Now, we want to add a visit, but only if the user is truly ready for it!

		
		// 3c. Now that we've receive confirmation and we have an updated,
		//     persisted `Visit`, we can add it to our landmark.

		
		// 4. And finally we make sure that we return the landmark parameter to indicate
		//     that it's updated.

		// And we're done! Open the app (or run ClosestLandmark again) to verify.
	}
	
}

// Don't forget the extra initializer.
