import SwiftUI

@main
struct LifecycleDemoApp: App {

    @Environment(\.scenePhase) private var scenePhase

    init() {
        print("APP: Application Initialized")
    }

    var body: some Scene {

        WindowGroup {

            HomeView()
                .onAppear {
                    print("APP: Root View Appeared")
                }
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in

            switch newPhase {

            case .active:
                print("SCENE: Application became ACTIVE")

            case .inactive:
                print("SCENE: Application became INACTIVE")

            case .background:
                print("SCENE: Application entered BACKGROUND")

            @unknown default:
                print("SCENE: Unknown state")
            }
        }
    }
}