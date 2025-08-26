import AppIntents
import SwiftData

// We want to add a visit to a landmark. Let's start with the basic app intent
// that will manage this.
struct AddVisitIntent: AppIntent {
	
	// 1. Let's add a title and a description.
	static let title: LocalizedStringResource = "Add visit to landmark"
	static let description = IntentDescription("This adds a visit to the landmark.")

	// 2. Let's set up all the parameters that we'll need.
	@Parameter
	var landmark: LandmarkEntity
	@Parameter
	var currentVisit: VisitEntity?
	@Dependency
	var modelContainer: ModelContainer
	
	// 3. Here is the meat of our intent! We have to create a Visit first, so we can
	//    query it in our intent chain. After we're done constructing it, we can
	//    add the visit to the landmark.
	@MainActor
	func perform() async throws -> some IntentResult & ShowsSnippetIntent & ReturnsValue<LandmarkEntity> {
		let visit: Visit
		let visitEntity: VisitEntity
		
		// 3a. We need to make sure that we have a persisted visit, that we can query
		// along our intent daisy chain.
		if let currentVisit {
			visitEntity = currentVisit
			visit = try visitEntity.fetchedValue
		} else {
			visit = Visit(timestamp: Date(), log: "")
			modelContainer.mainContext.insert(visit)
			visitEntity = VisitEntity(visit: visit, modelContainer: modelContainer)
		}
		
		// 3b. Now, we want to add a visit, but only if the user is truly ready for it!
		try await requestConfirmation(
			actionName: .add,
			snippetIntent: AddVisitSnippetIntent(visit: visitEntity, landmark: landmark)
		)
		
		// 3c. Now that we've receive confirmation and we have an updated,
		//     persisted `Visit`, we can add it to our landmark.
		let fetchedLandmark = try landmark.fetchedValue
		fetchedLandmark.visits.append(visit)
		
		// 4. And finally we make sure that we return the landmark parameter to indicate
		//     that it's updated.
		return .result(
			value: landmark
		)
		
		// And we're done! Open the app (or run ClosestLandmark again) to verify.
	}
}

extension AddVisitIntent {
	init(landmark: LandmarkEntity, currentVisit: VisitEntity? = nil) {
		self.landmark = landmark
		self.currentVisit = currentVisit
	}
}
