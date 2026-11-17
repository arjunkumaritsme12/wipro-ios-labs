
import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

// MARK: - Network Errors

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case decodingFailed
    case emptyResults
}

extension NetworkError: LocalizedError {

    var errorDescription: String? {

        switch self {

        case .invalidURL:
            return "Invalid API URL."

        case .invalidResponse:
            return "Invalid server response."

        case .httpError(let statusCode):
            return "HTTP Error: \(statusCode)"

        case .decodingFailed:
            return "Unable to decode JSON response."

        case .emptyResults:
            return "No users found."
        }
    }
}

// MARK: - User Service

struct UserService {

    let endpoint: String

    func fetchUsers() async throws -> [User] {

        // Validate URL
        guard let components = URLComponents(string: endpoint),
              let scheme = components.scheme,
              ["http", "https"].contains(scheme),
              components.host != nil,
              let url = components.url else {

            throw NetworkError.invalidURL
        }

        // Create HTTP request
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.timeoutInterval = 15

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Accept"
        )

        print("\nRequesting API: \(url.absoluteString)")

        // Actual network request
        let (data, response) = try await URLSession.shared.data(
            for: request
        )

        // Validate HTTP response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(httpResponse.statusCode)
        }

        // Decode JSON
        let decoder = JSONDecoder()

        let users: [User]

        do {
            users = try decoder.decode([User].self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }

        // Handle empty results
        guard !users.isEmpty else {
            throw NetworkError.emptyResults
        }

        return users
    }
}
