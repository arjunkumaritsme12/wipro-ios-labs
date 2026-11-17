
import Foundation

// MARK: - R1: Unsafe Counter

final class UnsafeCounter {

    var value = 0

    func increment() {
        value += 1
    }
}

// MARK: - R2: Safe Counter Using Actor

actor SafeCounter {

    private var value = 0

    func increment() {
        value += 1
    }

    func getValue() -> Int {
        return value
    }
}

// MARK: - Main Application

@main
struct Lab5D {

    static func main() async {

        let totalOperations = 10_000

        print("================================")
        print(" LAB 5D: CONCURRENCY SAFETY")
        print("================================")

        // MARK: - BEFORE: Unsafe Implementation

        print("\n--- BEFORE: UNSAFE COUNTER ---")

        let unsafeCounter = UnsafeCounter()

        await withTaskGroup(of: Void.self) { group in

            for _ in 0..<totalOperations {

                group.addTask {

                    // Shared mutable state
                    unsafeCounter.increment()
                }
            }
        }

        print("Expected Value: \(totalOperations)")
        print("Actual Value: \(unsafeCounter.value)")
        print("Unsafe counter test completed.")

        // MARK: - AFTER: Safe Actor Implementation

        print("\n--- AFTER: SAFE ACTOR COUNTER ---")

        let safeCounter = SafeCounter()

        await withTaskGroup(of: Void.self) { group in

            for _ in 0..<totalOperations {

                group.addTask {

                    await safeCounter.increment()
                }
            }
        }

        let finalValue = await safeCounter.getValue()

        print("Expected Value: \(totalOperations)")
        print("Actual Value: \(finalValue)")

        if finalValue == totalOperations {
            print("SUCCESS: Counter is thread-safe!")
        } else {
            print("FAILED: Counter value mismatch.")
        }

        print("\n================================")
        print("       LAB 5D COMPLETED")
        print("================================")
    }
}
