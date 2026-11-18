
import Foundation
import Observation

@MainActor
@Observable
final class CourseStore {

    private(set) var courses: [Course] = CourseData.courses
    private(set) var favoriteIDs: Set<Int>

    private let favoritesKey = "savedCourseFavorites"

    init() {
        let savedIDs = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
        favoriteIDs = Set(savedIDs)
    }

    func isFavorite(_ course: Course) -> Bool {
        favoriteIDs.contains(course.id)
    }

    func toggleFavorite(_ course: Course) {
        if favoriteIDs.contains(course.id) {
            favoriteIDs.remove(course.id)
        } else {
            favoriteIDs.insert(course.id)
        }

        saveFavorites()
    }

    func setFavorite(_ isFavorite: Bool, for course: Course) {
        if isFavorite {
            favoriteIDs.insert(course.id)
        } else {
            favoriteIDs.remove(course.id)
        }

        saveFavorites()
    }

    var favoriteCourses: [Course] {
        courses.filter { favoriteIDs.contains($0.id) }
    }

    private func saveFavorites() {
        UserDefaults.standard.set(
            Array(favoriteIDs),
            forKey: favoritesKey
        )
    }
}
