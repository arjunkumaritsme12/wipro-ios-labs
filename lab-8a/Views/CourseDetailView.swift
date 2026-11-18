
import SwiftUI

struct CourseDetailView: View {

    let course: Course

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 22) {

                ZStack {

                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue.gradient)
                        .frame(height: 180)

                    VStack(spacing: 12) {

                        Image(systemName: "book.closed.fill")
                            .font(.system(size: 55))
                            .foregroundStyle(.white)

                        Text(course.category)
                            .font(.headline)
                            .foregroundStyle(.white)
                    }
                }

                VStack(alignment: .leading, spacing: 10) {

                    Text(course.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(course.subtitle)
                        .font(.title3)
                        .foregroundStyle(.secondary)

                    Text(course.status)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(Color.green.opacity(0.12))
                        .clipShape(Capsule())
                }

                Divider()

                Label(
                    course.duration,
                    systemImage: "clock"
                )
                .font(.headline)

                VStack(alignment: .leading, spacing: 10) {

                    Text("About This Course")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text(course.description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .lineSpacing(6)
                }

                Spacer(minLength: 20)
            }
            .padding()
        }
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CourseDetailView(course: CourseData.samples[0])
    }
}
