
import SwiftUI

struct CategoryChipView: View {

    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    isSelected ? Color.blue : Color.gray.opacity(0.12)
                )
                .foregroundStyle(
                    isSelected ? Color.white : Color.primary
                )
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack {
        CategoryChipView(
            title: "Programming",
            isSelected: true,
            action: {}
        )

        CategoryChipView(
            title: "Development",
            isSelected: false,
            action: {}
        )
    }
    .padding()
}
