import Foundation

public protocol ExpenseRepository {
    func load() throws -> [Expense]
    func save(_ expenses: [Expense]) throws
}

public enum RepositoryError: Error, Equatable {
    case invalidData
}

public final class JSONExpenseRepository: ExpenseRepository {
    private let fileURL: URL
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(fileURL: URL) {
        self.fileURL = fileURL
        self.encoder = JSONEncoder()
        self.decoder = JSONDecoder()
        self.encoder.dateEncodingStrategy = .iso8601
        self.decoder.dateDecodingStrategy = .iso8601
    }

    public func load() throws -> [Expense] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return []
        }
        let data = try Data(contentsOf: fileURL)
        do {
            return try decoder.decode([Expense].self, from: data)
        } catch {
            throw RepositoryError.invalidData
        }
    }

    public func save(_ expenses: [Expense]) throws {
        let directory = fileURL.deletingLastPathComponent()
        try FileManager.default.createDirectory(
            at: directory,
            withIntermediateDirectories: true
        )
        let data = try encoder.encode(expenses)
        try data.write(to: fileURL, options: .atomic)
    }
}
