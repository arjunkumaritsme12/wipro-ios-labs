
import SwiftUI

struct HomeView: View {

    @State private var courses: [Course]

    @State private var selectedCategory = "All"

    init(courses: [Course] = CourseData.samples) {
        _courses = State(initialValue: courses)
    }

    // Filter courses according to category
    private var filteredCourses: [Course] {

        if selectedCategory == "All" {
            return courses
        }

        return courses.filter {
            $0.category == selectedCategory
        }
    }

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(alignment: .leading, spacing: 24) {

                    // Welcome Header
                    welcomeSection

                    // Category Section
                    categorySection

                    // Courses Section
                    coursesSection
                }
                .padding()
            }
            .background(Color(uiColor: .systemBackground))
            .navigationTitle("Course Explorer")
            .toolbar {

                ToolbarItem(placement: .navigationBarTrailing) {

                    NavigationLink(
                        destination: CourseListView(courses: courses)
                    ) {

                        Image(systemName: "list.bullet")
                            .font(.headline)
                    }
                }
            }
        }
    }

    // MARK: - Welcome Section

    private var welcomeSection: some View {

        ZStack {

            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue.gradient)

            VStack(alignment: .leading, spacing: 12) {

                Text("Learn Something New!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)

                Text("Explore courses and build your skills.")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))

                HStack {

                    Image(systemName: "graduationcap.fill")

                    Text("\(courses.count) Courses Available")

                    Spacer()
                }
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            }
            .padding(20)
        }
        .frame(height: 155)
    }

    // MARK: - Category Section

    private var categorySection: some View {

        VStack(alignment: .leading, spacing: 14) {

            SectionHeaderView(
                title: "Categories",
                subtitle: "Choose your learning area"
            )

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 10) {

                    ForEach(CourseData.categories, id: \.self) { category in

                        CategoryChipView(
                            title: category,
                            isSelected: selectedCategory == category
                        ) {

                            selectedCategory = category
                        }
                    }
                }
            }
        }
    }

    // MARK: - Courses Section

    private var coursesSection: some View {

        VStack(alignment: .leading, spacing: 14) {

            HStack {

                SectionHeaderView(
                    title: "Explore Courses",
                    subtitle: "Find your next learning opportunity"
                )

                Spacer()

                NavigationLink(
                    destination: CourseListView(courses: courses)
                ) {

                    Text("See All")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }

            if filteredCourses.isEmpty {

                EmptyStateView(
                    title: "No Courses Found",
                    message: "No courses are available in this category."
                )

            } else {

                LazyVStack(spacing: 16) {

                    ForEach(filteredCourses) { course in

                        NavigationLink(
                            destination: CourseDetailView(course: course)
                        ) {

                            CourseCardView(
                                title: course.title,
                                subtitle: course.subtitle,
                                category: course.category,
                                status: course.status
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview("With Courses") {
    HomeView()
}

#Preview("Empty State") {
    HomeView(courses: [])
}
