import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let window = UIWindow(windowScene: windowScene)

        let controlsVC = ControlsViewController()

        let navigationController = UINavigationController(
            rootViewController: controlsVC
        )

        window.rootViewController = navigationController

        self.window = window
        window.makeKeyAndVisible()
    }
}