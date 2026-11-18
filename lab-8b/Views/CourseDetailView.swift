
import SwiftUI

struct CourseDetailView: View {

    let course: Course

    @State private var isSaved = false

    var body: some View {

        ScrollView {
            VStack(alignment: .leading, spacing: 18) {

                Image(systemName: "book.closed.fill")
                    .font(.system(size: 55))
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 35)
                    .background(Color.blue.opacity(0.10))
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                Text(course.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(course.category)
                    .font(.subheadline)
                    .foregroundStyle(.blue)

                Divider()

                Text("Course Overview")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(course.description)
                    .font(.body)
                    .foregroundStyle(.secondary)

                HStack {
                    Image(systemName: "clock")
                    Text("Duration: \(course.duration)")
                }
                .font(.subheadline)

                Spacer(minLength: 20)
            }
            .padding()
        }
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isSaved.toggle()
                } label: {
                    Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                }
                .accessibilityLabel(
                    isSaved ? "Remove bookmark" : "Bookmark course"
                )
            }
        }
    }
}

#Preview {
    NavigationStack {
        CourseDetailView(course: CourseData.courses[0])
    }
}
