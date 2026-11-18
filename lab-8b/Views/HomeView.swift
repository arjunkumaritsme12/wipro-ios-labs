
import SwiftUI

struct HomeView: View {

    private let courses = CourseData.courses

    var body: some View {
        NavigationStack {

            List(courses) { course in

                NavigationLink(value: course) {
                    VStack(alignment: .leading, spacing: 6) {

                        Text(course.title)
                            .font(.headline)

                        Text(course.subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Text(course.category)
                            .font(.caption)
                            .foregroundStyle(.blue)
                    }
                    .padding(.vertical, 6)
                }
            }
            .navigationTitle("Course Explorer")
            .navigationBarTitleDisplayMode(.inline)

            .navigationDestination(for: Course.self) { course in
                CourseDetailView(course: course)
            }

            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SearchView(courses: courses)
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    .accessibilityLabel("Search courses")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
