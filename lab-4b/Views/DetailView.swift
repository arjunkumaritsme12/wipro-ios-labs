import SwiftUI

struct DetailView: View {

    var body: some View {

        VStack(spacing: 25) {

            Image(systemName: "doc.text")
                .font(.system(size: 65))
                .foregroundStyle(.green)

            Text("Detail Screen")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("This is the second screen of the application.")

                .multilineTextAlignment(.center)

            Text("Lifecycle events are recorded in the console.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(25)
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {

            print("VIEW: DetailView appeared")
        }
        .onDisappear {

            print("VIEW: DetailView disappeared")
        }
    }
}