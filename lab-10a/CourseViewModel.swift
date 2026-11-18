
import Foundation

struct Course: Identifiable, Equatable {
    let id: Int
    let title: String
}

protocol CourseService {
    func fetchCourses() async throws -> [Course]
}

@MainActor
final class CourseViewModel {

    private let service: CourseService

    private(set) var courses: [Course] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    init(service: CourseService) {
        self.service = service
    }

    func loadCourses() async {

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            courses = try await service.fetchCourses()
        } catch {
            courses = []
            errorMessage = error.localizedDescription
        }
    }
}
