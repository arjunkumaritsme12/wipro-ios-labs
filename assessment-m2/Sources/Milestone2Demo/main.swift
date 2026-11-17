import Foundation
import Milestone2

@main
struct Milestone2Demo {
    static func main() async {
        print("=== R1: MVVM ===")
        let viewModel = await TaskViewModel()
        await viewModel.addTask(title: "Learn Swift concurrency")
        print("Tasks:", await viewModel.tasks.map(\.title))

        print("\\n=== R2: Concurrent fetch ===")
        let repository = DashboardRepository(
            userSource: DemoUserSource(),
            taskSource: DemoTaskSource()
        )
        do {
            let dashboard = try await repository.fetchDashboard()
            print("User:", dashboard.user.name)
            print("Remote tasks:", dashboard.tasks.map(\.title))
        } catch {
            print("Fetch failed:", error.localizedDescription)
        }

        print("\\n=== R4: MainActor ===")
        let screen = await ScreenState()
        await screen.show("UI state updated on MainActor")
        print(await screen.message)
    }
}
