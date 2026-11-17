import XCTest
@testable import Milestone2

private struct StubUserSource: UserDataSource {
    func fetchUser() async throws -> UserProfile { UserProfile(name: "Test User") }
}

private struct StubTaskSource: TaskDataSource {
    func fetchTasks() async throws -> [RemoteTask] {
        [RemoteTask(title: "Test task")]
    }
}

final class ConcurrentFetchTests: XCTestCase {
    func testIndependentSourcesAreCombined() async throws {
        let repository = DashboardRepository(
            userSource: StubUserSource(),
            taskSource: StubTaskSource()
        )

        let result = try await repository.fetchDashboard()

        XCTAssertEqual(result.user.name, "Test User")
        XCTAssertEqual(result.tasks, [RemoteTask(title: "Test task")])
    }
}
