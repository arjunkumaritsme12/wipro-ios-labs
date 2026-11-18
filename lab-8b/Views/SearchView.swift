
import SwiftUI

struct SearchView: View {

    let courses: [Course]

    @State private var searchText = ""

    private var filteredCourses: [Course] {
        if searchText.isEmpty {
            return courses
        }

        return courses.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.category.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {

        List(filteredCourses) { course in

            NavigationLink(value: course) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(course.title)
                        .font(.headline)

                    Text(course.category)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 5)
            }
        }
        .searchable(text: $searchText, prompt: "Search courses")
        .navigationTitle("Search Courses")
        .navigationDestination(for: Course.self) { course in
            CourseDetailView(course: course)
        }
        .overlay {
            if filteredCourses.isEmpty {
                ContentUnavailableView.search(text: searchText)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SearchView(courses: CourseData.courses)
    }
}
