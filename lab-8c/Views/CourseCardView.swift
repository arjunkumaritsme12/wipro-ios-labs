
import SwiftUI

struct CourseCardView: View {

    let course: Course
    @Binding var isFavorite: Bool

    var body: some View {

        HStack(spacing: 12) {

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
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            Button {
                isFavorite.toggle()
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.title2)
                    .foregroundStyle(isFavorite ? .red : .secondary)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(
                isFavorite ? "Remove favourite" : "Add favourite"
            )
        }
        .padding(.vertical, 8)
    }
}
