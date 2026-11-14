
import UIKit

class UIKitScreen: UIViewController {

    let titleLabel = UILabel()
    let nameField = UITextField()
    let helloButton = UIButton(type: .system)
    let resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // Title
        titleLabel.text = "Welcome App"
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center

        // Text Field
        nameField.placeholder = "Enter your name"
        nameField.borderStyle = .roundedRect

        // Button
        helloButton.setTitle("Say Hello", for: .normal)
        helloButton.backgroundColor = .systemBlue
        helloButton.setTitleColor(.white, for: .normal)
        helloButton.layer.cornerRadius = 10

        // Result Label
        resultLabel.text = ""
        resultLabel.textAlignment = .center
        resultLabel.font = .boldSystemFont(ofSize: 18)
        resultLabel.textColor = .systemGreen

        // Add components
        let stackView = UIStackView(
            arrangedSubviews: [
                titleLabel,
                nameField,
                helloButton,
                resultLabel
            ]
        )

        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        // Layout constraints
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 25
            ),
            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -25
            ),
            helloButton.heightAnchor.constraint(
                equalToConstant: 45
            )
        ])

        // Button action
        helloButton.addTarget(
            self,
            action: #selector(showGreeting),
            for: .touchUpInside
        )
    }

    @objc func showGreeting() {

        let name = nameField.text ?? ""

        if name.isEmpty {
            resultLabel.text = "Please enter your name!"
        } else {
            resultLabel.text = "Hello, \(name)!"
        }
    }
}
