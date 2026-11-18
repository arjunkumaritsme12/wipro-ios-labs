
import SwiftUI

struct CourseDetailView: View {

    let course: Course

    @Environment(CourseStore.self) private var store

    private var favoriteBinding: Binding<Bool> {
        Binding(
            get: {
                store.isFavorite(course)
            },
            set: {
                store.setFavorite($0, for: course)
            }
        )
    }

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 18) {

                Image(systemName: "book.closed.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 35)
                    .background(Color.blue.opacity(0.10))
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                HStack {
                    Text(course.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Spacer()

                    Button {
                        favoriteBinding.wrappedValue.toggle()
                    } label: {
                        Image(
                            systemName: favoriteBinding.wrappedValue
                                ? "heart.fill"
                                : "heart"
                        )
                        .font(.title)
                        .foregroundStyle(.red)
                    }
                    .accessibilityLabel(
                        favoriteBinding.wrappedValue
                            ? "Remove favourite"
                            : "Add favourite"
                    )
                }

                Text(course.category)
                    .font(.subheadline)
                    .foregroundStyle(.blue)

                Divider()

                Text("Course Overview")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(course.description)
                    .foregroundStyle(.secondary)

                Label(
                    "Duration: \(course.duration)",
                    systemImage: "clock"
                )
                .font(.subheadline)
            }
            .padding()
        }
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CourseDetailView(course: CourseData.courses[0])
            .environment(CourseStore())
    }
}
