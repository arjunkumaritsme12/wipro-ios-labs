import Foundation

class RefreshService {

    func refreshData() -> String {

        print("REFRESH SERVICE: Refresh started")

        let currentTime = Date().formatted(
            date: .omitted,
            time: .standard
        )

        print("REFRESH SERVICE: Refresh completed")

        return "Last refreshed: \(currentTime)"
    }
}