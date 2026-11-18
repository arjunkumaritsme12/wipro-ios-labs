import SwiftUI

@main
struct ExpenseMateApp: App {
    @StateObject private var viewModel = ExpenseViewModel()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(viewModel)
        }
    }
}
