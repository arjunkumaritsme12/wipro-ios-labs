
import SwiftUI

struct CourseListView: View {

    let courses: [Course]

    var body: some View {

        Group {

            if courses.isEmpty {

                EmptyStateView(
                    title: "No Courses Available",
                    message: "There are currently no courses to display."
                )

            } else {

                List(courses) { course in

                    NavigationLink(
                        destination: CourseDetailView(course: course)
                    ) {

                        HStack(spacing: 14) {

                            Image(systemName: "book.fill")
                                .font(.title2)
                                .foregroundStyle(.blue)
                                .frame(width: 45, height: 45)
                                .background(Color.blue.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                            VStack(alignment: .leading, spacing: 5) {

                                Text(course.title)
                                    .font(.headline)

                                Text(course.category)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)

                                Text(course.status)
                                    .font(.caption2)
                                    .foregroundStyle(.green)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("All Courses")
    }
}

#Preview {
    NavigationStack {
        CourseListView(courses: CourseData.samples)
    }
}
