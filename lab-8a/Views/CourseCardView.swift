
import SwiftUI

struct CourseCardView: View {

    let title: String
    let subtitle: String
    let category: String
    let status: String

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            HStack {

                Text(category.uppercased())
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)

                Spacer()

                Text(status)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.green.opacity(0.12))
                    .foregroundStyle(.green)
                    .clipShape(Capsule())
            }

            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.primary)

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack {

                Label(
                    "Explore Course",
                    systemImage: "book.fill"
                )
                .font(.caption)
                .foregroundStyle(.blue)

                Spacer()

                Image(systemName: "arrow.right")
                    .foregroundStyle(.blue)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    CourseCardView(
        title: "SwiftUI Development",
        subtitle: "Learn modern iOS development",
        category: "Mobile Development",
        status: "Popular"
    )
    .padding()
}
