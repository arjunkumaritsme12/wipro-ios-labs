import UIKit

class LifecycleDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Demo Screen: viewDidLoad")

        view.backgroundColor = .systemBackground
        title = "Lifecycle Demo"

        let label = UILabel()
        label.text = "Second Screen\nPress Back to return."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true

        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)

        NSLayoutConstraint.activate([

            label.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),

            label.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),

            label.leadingAnchor.constraint(
                greaterThanOrEqualTo: view.leadingAnchor,
                constant: 24
            ),

            label.trailingAnchor.constraint(
                lessThanOrEqualTo: view.trailingAnchor,
                constant: -24
            )
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Demo Screen: viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Demo Screen: viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Demo Screen: viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Demo Screen: viewDidDisappear")
    }
}