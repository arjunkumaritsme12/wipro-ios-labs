import Foundation

public enum LoadState<Value: Sendable>: Sendable {
    case idle
    case loading
    case success(Value)
    case failure(String)
    case cancelled
}

public protocol DashboardLoading: Sendable {
    func fetchDashboard() async throws -> DashboardData
}

/// Observable-style state holder. UI frameworks can bind/render based on `state`.
@MainActor
public final class DashboardViewModel {
    public private(set) var state: LoadState<DashboardData> = .idle
    private let repository: any DashboardLoading
    private var loadTask: Task<Void, Never>?

    public init(repository: any DashboardLoading) {
        self.repository = repository
    }

    public func load() {
        loadTask?.cancel()
        state = .loading
        let repository = self.repository

        loadTask = Task { [weak self] in
            do {
                let data = try await repository.fetchDashboard()
                try Task.checkCancellation()
                self?.state = .success(data)
            } catch is CancellationError {
                self?.state = .cancelled
            } catch {
                self?.state = .failure(error.localizedDescription)
            }
        }
    }

    public func cancel() {
        loadTask?.cancel()
        state = .cancelled
    }
}
