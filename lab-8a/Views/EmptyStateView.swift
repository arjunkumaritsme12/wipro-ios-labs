
import SwiftUI

struct EmptyStateView: View {

    let title: String
    let message: String

    var body: some View {

        VStack(spacing: 16) {

            Image(systemName: "book.closed")
                .font(.system(size: 55))
                .foregroundStyle(.secondary)

            Text(title)
                .font(.title3)
                .fontWeight(.bold)

            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 25)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }
}

#Preview {
    EmptyStateView(
        title: "No Courses Found",
        message: "Try selecting another category."
    )
}
