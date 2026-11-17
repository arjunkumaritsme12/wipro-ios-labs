import Foundation

public struct UserProfile: Equatable, Sendable {
    public let name: String
    public init(name: String) { self.name = name }
}

public struct RemoteTask: Equatable, Sendable {
    public let title: String
    public init(title: String) { self.title = title }
}

public struct DashboardData: Equatable, Sendable {
    public let user: UserProfile
    public let tasks: [RemoteTask]
}

public protocol UserDataSource: Sendable {
    func fetchUser() async throws -> UserProfile
}

public protocol TaskDataSource: Sendable {
    func fetchTasks() async throws -> [RemoteTask]
}

/// Fetches independent sources concurrently and combines their results.
public struct DashboardRepository: DashboardLoading, Sendable {
    private let userSource: any UserDataSource
    private let taskSource: any TaskDataSource

    public init(userSource: any UserDataSource, taskSource: any TaskDataSource) {
        self.userSource = userSource
        self.taskSource = taskSource
    }

    public func fetchDashboard() async throws -> DashboardData {
        async let user = userSource.fetchUser()
        async let tasks = taskSource.fetchTasks()
        return try await DashboardData(user: user, tasks: tasks)
    }
}

public struct DemoUserSource: UserDataSource {
    public init() {}
    public func fetchUser() async throws -> UserProfile {
        try await Task.sleep(for: .milliseconds(700))
        return UserProfile(name: "Arjun")
    }
}

public struct DemoTaskSource: TaskDataSource {
    public init() {}
    public func fetchTasks() async throws -> [RemoteTask] {
        try await Task.sleep(for: .milliseconds(900))
        return [RemoteTask(title: "Complete MVVM"), RemoteTask(title: "Practice concurrency")]
    }
}
