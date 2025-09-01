import AppIntents
import SwiftData

// Make an app intent actually sets the log in the stored visit.
// When adding a log parameter, make sure to keep it empty!
struct SetVisitLogSnippetIntent: AppIntent {
	
	// 1. Start with our standard app intent code.
	//    Bonus points: make the intent undiscoverable.
	
	
	// 2. We're relying on three parameters here. The first two are as usual,
	//    but the `log` won't be populated by us. Instead, we leave it empty,
	//    which allows the system to prompt the user automatically.
	
	
	// 3. The `perform` method will store the log and return the visit as a result.
	@MainActor
	func perform() async throws -> some IntentResult {
		// 3a. We fetch the stored visit, and replace the log with whatever the
		//     user came up with before the `perform` is run.

		
		// 4. We finish by reopening our AddVisitIntent
		//    with the _updated_ visit entity.
	}
}

// 5. Add the extra initializer.

// Bonus points: instead of leaving `log` nil, try filling it with
// an empty string or with the visit's current log.
// Then try to use `$log.requestValue` to edit it instead.
