
import SwiftUI

struct Course: Identifiable {
    let id: Int
    let title: String
    let category: String
    let searchableText: String

    init(id: Int, title: String, category: String) {
        self.id = id
        self.title = title
        self.category = category
        self.searchableText = "\(title) \(category)".lowercased()
    }
}

struct ContentView: View {
    @State private var searchText = ""
    @State private var filteredCourses: [Course] = []

    private let courses: [Course] = (1...10000).map {
        Course(
            id: $0,
            title: "Swift Programming Course \($0)",
            category: $0.isMultiple(of: 2) ? "Development" : "Design"
        )
    }

    var body: some View {
        NavigationStack {
            List(filteredCourses) { course in
                VStack(alignment: .leading, spacing: 5) {
                    Text(course.title)
                        .font(.headline)

                    Text(course.category)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 4)
            }
            .searchable(text: $searchText)
            .navigationTitle("Course Explorer")
            .onAppear {
                updateResults()
            }
            .onChange(of: searchText) { _ in
                updateResults()
            }
        }
    }

    private func updateResults() {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        guard !query.isEmpty else {
            filteredCourses = courses
            return
        }

        filteredCourses = courses.filter {
            $0.searchableText.contains(query)
        }
    }
}
