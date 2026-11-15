import SwiftUI

struct HomeView: View {

    @State private var refreshMessage = "Not refreshed yet"

    var body: some View {

        NavigationStack {

            VStack(spacing: 25) {

                Image(systemName: "iphone.gen3")
                    .font(.system(size: 65))
                    .foregroundStyle(.blue)

                Text("Lifecycle Demo")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Welcome to the Home Screen")
                    .font(.headline)

                Text(refreshMessage)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                NavigationLink(destination: DetailView()) {

                    Text("Go to Detail Screen")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(12)
                }
            }
            .padding(25)
            .navigationTitle("Home")
            .onAppear {

                print("VIEW: HomeView appeared")

                refreshHomeData()
            }
            .onDisappear {

                print("VIEW: HomeView disappeared")
            }
        }
    }

    private func refreshHomeData() {

        print("REFRESH: Home data refreshed")

        refreshMessage = "Last refreshed: \(Date().formatted(date: .omitted, time: .standard))"
    }
}