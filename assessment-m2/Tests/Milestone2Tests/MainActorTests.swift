import XCTest
@testable import Milestone2

final class MainActorTests: XCTestCase {
    func testScreenMessageCanBeUpdated() async {
        await MainActor.run {
            let screen = ScreenState()
            screen.show("Updated")
            XCTAssertEqual(screen.message, "Updated")
        }
    }
}
