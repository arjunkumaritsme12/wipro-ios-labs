
import Foundation

// MARK: - Course Model

struct Course {
    let id: Int
    let name: String
    let duration: String
}

// MARK: - Custom Error

enum CourseError: Error {
    case courseNotFound(Int)
}

// MARK: - Course Service

func fetchCourse(id: Int) async throws -> Course {

    print("Starting request for Course ID: \(id)")

    // Simulate independent network delays
    let delay = UInt64(id % 3 + 1) * 1_000_000_000

    try await Task.sleep(nanoseconds: delay)

    // Check cancellation
    try Task.checkCancellation()

    // Simulate one failed request
    if id == 103 {
        throw CourseError.courseNotFound(id)
    }

    let course = Course(
        id: id,
        name: "Course \(id)",
        duration: "4 Weeks"
    )

    print("Completed request for Course ID: \(id)")

    return course
}

// MARK: - Sequential Fetching

func fetchSequentially(ids: [Int]) async -> [Course] {

    print("\n===== SEQUENTIAL EXECUTION =====")

    let startTime = Date()
    var courses: [Course] = []

    for id in ids {

        do {
            let course = try await fetchCourse(id: id)
            courses.append(course)

        } catch {
            print("Error fetching Course \(id): \(error)")
        }
    }

    let elapsed = Date().timeIntervalSince(startTime)

    print("\nSequential Results:")

    for course in courses {
        print("\(course.id) - \(course.name)")
    }

    print("Sequential Time: \(String(format: "%.2f", elapsed)) seconds")

    return courses
}

// MARK: - Concurrent Fetching Using Task Group

func fetchConcurrently(ids: [Int]) async -> [Course] {

    print("\n===== CONCURRENT EXECUTION =====")

    let startTime = Date()

    let courses = await withTaskGroup(
        of: Course?.self,
        returning: [Course].self
    ) { group in

        // R2: Launch independent child tasks
        for id in ids {

            group.addTask {

                do {
                    return try await fetchCourse(id: id)

                } catch is CancellationError {

                    print("Course \(id) was cancelled")
                    return nil

                } catch {

                    print("Child task failed for Course \(id): \(error)")
                    return nil
                }
            }
        }

        var results: [Course] = []

        // Collect results as tasks finish
        for await course in group {

            if let course = course {
                results.append(course)
            }
        }

        return results.sorted { $0.id < $1.id }
    }

    let elapsed = Date().timeIntervalSince(startTime)

    print("\nConcurrent Results:")

    for course in courses {
        print("\(course.id) - \(course.name)")
    }

    print("Concurrent Time: \(String(format: "%.2f", elapsed)) seconds")

    return courses
}

// MARK: - Main Application

@main
struct Lab5C {

    static func main() async {

        let courseIDs = [101, 102, 103, 104, 105]

        print("================================")
        print(" LAB 5C: TASK GROUPS")
        print("================================")

        // R3: Sequential comparison
        let sequentialResults = await fetchSequentially(
            ids: courseIDs
        )

        // R2: Concurrent execution
        let concurrentResults = await fetchConcurrently(
            ids: courseIDs
        )

        // MARK: - Final Comparison

        print("\n===== PERFORMANCE COMPARISON =====")

        print("Total Courses: \(courseIDs.count)")

        print("Sequential Successful: \(sequentialResults.count)")

        print("Concurrent Successful: \(concurrentResults.count)")

        print("\n===== LAB 5C COMPLETED =====")
    }
}
