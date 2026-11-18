
import XCTest
@testable import YourApp

final class GradeCalculatorTests: XCTestCase {

    func testGradeAForScoreAbove90() {
        XCTAssertEqual(GradeCalculator.calculateGrade(for: 95), "A")
    }

    func testGradeBoundaries() {
        XCTAssertEqual(GradeCalculator.calculateGrade(for: 90), "A")
        XCTAssertEqual(GradeCalculator.calculateGrade(for: 80), "B")
        XCTAssertEqual(GradeCalculator.calculateGrade(for: 70), "C")
        XCTAssertEqual(GradeCalculator.calculateGrade(for: 60), "D")
        XCTAssertEqual(GradeCalculator.calculateGrade(for: 59), "F")
    }

    func testGradeForZeroScore() {
        XCTAssertEqual(GradeCalculator.calculateGrade(for: 0), "F")
    }

    func testGradeRejectsInvalidScores() {
        XCTAssertNil(GradeCalculator.calculateGrade(for: -1))
        XCTAssertNil(GradeCalculator.calculateGrade(for: 101))
    }

    func testValidName() {
        XCTAssertTrue(RegistrationValidator.isValidName("Arjun Kumar"))
    }

    func testEmptyNameIsInvalid() {
        XCTAssertFalse(RegistrationValidator.isValidName("   "))
    }

    func testValidEmail() {
        XCTAssertTrue(
            RegistrationValidator.isValidEmail("arjun@example.com")
        )
    }

    func testInvalidEmail() {
        XCTAssertFalse(RegistrationValidator.isValidEmail("arjunexample.com"))
        XCTAssertFalse(RegistrationValidator.isValidEmail("arjun@"))
        XCTAssertFalse(RegistrationValidator.isValidEmail("arjun @example.com"))
    }

    func testValidPhoneNumber() {
        XCTAssertTrue(RegistrationValidator.isValidPhone("9876543210"))
    }

    func testInvalidPhoneNumber() {
        XCTAssertFalse(RegistrationValidator.isValidPhone("12345"))
        XCTAssertFalse(RegistrationValidator.isValidPhone("12345678901"))
    }

    func testValidRegistrationForm() {
        XCTAssertTrue(
            RegistrationValidator.isValidForm(
                name: "Arjun Kumar",
                email: "arjun@example.com",
                phone: "9876543210"
            )
        )
    }

    func testInvalidRegistrationForm() {
        XCTAssertFalse(
            RegistrationValidator.isValidForm(
                name: "",
                email: "invalid-email",
                phone: "123"
            )
        )
    }
}

enum MockServiceError: Error {
    case failed
}

struct MockCourseService: CourseService {

    let result: Result<[Course], MockServiceError>

    func fetchCourses() async throws -> [Course] {
        try result.get()
    }
}

final class CourseViewModelTests: XCTestCase {

    @MainActor
    func testLoadCoursesWithSuccessfulService() async {

        let sampleCourses = [
            Course(id: 1, title: "Swift"),
            Course(id: 2, title: "SwiftUI")
        ]

        let service = MockCourseService(
            result: .success(sampleCourses)
        )

        let viewModel = CourseViewModel(service: service)

        await viewModel.loadCourses()

        XCTAssertEqual(viewModel.courses, sampleCourses)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    @MainActor
    func testLoadCoursesWithFailedService() async {

        let service = MockCourseService(
            result: .failure(.failed)
        )

        let viewModel = CourseViewModel(service: service)

        await viewModel.loadCourses()

        XCTAssertTrue(viewModel.courses.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    @MainActor
    func testLoadCoursesWithEmptyResponse() async {

        let service = MockCourseService(
            result: .success([])
        )

        let viewModel = CourseViewModel(service: service)

        await viewModel.loadCourses()

        XCTAssertTrue(viewModel.courses.isEmpty)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }
}
