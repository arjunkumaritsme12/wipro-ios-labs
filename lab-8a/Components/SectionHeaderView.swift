
import SwiftUI

struct SectionHeaderView: View {

    let title: String
    let subtitle: String

    var body: some View {

        VStack(alignment: .leading, spacing: 5) {

            Text(title)
                .font(.title2)
                .fontWeight(.bold)

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SectionHeaderView(
        title: "Explore Courses",
        subtitle: "Choose your learning path"
    )
    .padding()
}
