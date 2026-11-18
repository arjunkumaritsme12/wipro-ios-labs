
import SwiftUI

@main
struct CourseExplorerApp: App {

    @State private var store = CourseStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(store)
        }
    }
}
