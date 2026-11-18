
import Foundation

enum PostServiceError: LocalizedError {

    case invalidResponse
    case httpError(Int)

    var errorDescription: String? {

        switch self {

        case .invalidResponse:
            return "Invalid server response."

        case .httpError(let statusCode):
            return "Server error: HTTP \(statusCode)"
        }
    }
}

final class PostService {

    private let session: URLSession

    private let endpoint = URL(
        string: "https://jsonplaceholder.typicode.com/posts?_limit=20"
    )!

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchPosts(
        completion: @escaping (Result<[Post], Error>) -> Void
    ) {

        var request = URLRequest(url: endpoint)

        request.httpMethod = "GET"
        request.timeoutInterval = 20

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Accept"
        )

        session.dataTask(with: request) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(PostServiceError.invalidResponse))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                completion(
                    .failure(PostServiceError.httpError(httpResponse.statusCode))
                )
                return
            }

            guard let data = data else {
                completion(.failure(PostServiceError.invalidResponse))
                return
            }

            do {

                let posts = try JSONDecoder().decode(
                    [Post].self,
                    from: data
                )

                completion(.success(posts))

            } catch {

                completion(.failure(error))
            }

        }.resume()
    }
}
