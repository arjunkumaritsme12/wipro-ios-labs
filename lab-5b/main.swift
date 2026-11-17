
import Foundation

// MARK: - Product Model

struct Product {
    let id: Int
    let name: String
    let price: Double
}

// MARK: - App States

enum FetchState {
    case loading
    case success([Product])
    case empty
    case failure(String)
    case cancelled
}

// MARK: - Product Service

enum ProductError: Error {
    case networkError
}

func fetchProducts(mode: String) async throws -> [Product] {

    print("\nFetching products...")

    // Simulate network delay
    try await Task.sleep(nanoseconds: 2_000_000_000)

    // Check cancellation
    try Task.checkCancellation()

    switch mode {

    case "success":
        return [
            Product(id: 1, name: "Laptop", price: 55000),
            Product(id: 2, name: "Smartphone", price: 25000),
            Product(id: 3, name: "Headphones", price: 3000)
        ]

    case "empty":
        return []

    case "failure":
        throw ProductError.networkError

    default:
        return []
    }
}

// MARK: - Product ViewModel

@MainActor
class ProductViewModel {

    private(set) var state: FetchState = .loading

    private var fetchTask: Task<Void, Never>?

    func fetch(mode: String) {

        // Cancel previous operation if running
        fetchTask?.cancel()

        state = .loading
        displayState()

        // R2: Create a Task to execute async function
        fetchTask = Task {

            do {

                let products = try await fetchProducts(mode: mode)

                try Task.checkCancellation()

                if products.isEmpty {
                    state = .empty
                } else {
                    state = .success(products)
                }

            } catch is CancellationError {

                state = .cancelled

            } catch {

                state = .failure("Network error occurred!")
            }

            displayState()
        }
    }

    // MARK: - Cancel Operation

    func cancel() {

        guard let task = fetchTask else {
            print("No active task to cancel.")
            return
        }

        task.cancel()
        fetchTask = nil

        state = .cancelled
        displayState()
    }

    // MARK: - Retry

    func retry() {
        print("\nRetrying operation...")
        fetch(mode: "success")
    }

    // MARK: - Display State

    func displayState() {

        switch state {

        case .loading:
            print("\nSTATE: LOADING")
            print("Please wait...")

        case .success(let products):
            print("\nSTATE: SUCCESS")
            print("Products fetched successfully:")

            for product in products {
                print("\(product.id). \(product.name) - Rs. \(product.price)")
            }

        case .empty:
            print("\nSTATE: EMPTY")
            print("No products available.")

        case .failure(let message):
            print("\nSTATE: FAILURE")
            print(message)
            print("You can retry the operation.")

        case .cancelled:
            print("\nSTATE: CANCELLED")
            print("Operation was cancelled.")
        }
    }
}

// MARK: - Main Application

@main
struct Lab5B {

    static func main() async {

        let viewModel = await ProductViewModel()

        print("================================")
        print("     LAB 5B: ASYNC/AWAIT")
        print("================================")

        // R3: SUCCESS STATE
        print("\n--- TEST 1: SUCCESS ---")
        await viewModel.fetch(mode: "success")
        try? await Task.sleep(nanoseconds: 3_000_000_000)

        // EMPTY STATE
        print("\n--- TEST 2: EMPTY ---")
        await viewModel.fetch(mode: "empty")
        try? await Task.sleep(nanoseconds: 3_000_000_000)

        // FAILURE STATE
        print("\n--- TEST 3: FAILURE ---")
        await viewModel.fetch(mode: "failure")
        try? await Task.sleep(nanoseconds: 3_000_000_000)

        // CANCELLATION STATE
        print("\n--- TEST 4: CANCELLATION ---")
        await viewModel.fetch(mode: "success")
        try? await Task.sleep(nanoseconds: 500_000_000)
        await viewModel.cancel()

        print("\n================================")
        print("         LAB 5B COMPLETED")
        print("================================")
    }
}
