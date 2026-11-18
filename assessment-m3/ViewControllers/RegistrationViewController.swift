
import UIKit

final class RegistrationViewController: UIViewController {

    private let nameField = UITextField()
    private let emailField = UITextField()
    private let passwordField = UITextField()

    private let statusLabel = UILabel()
    private let submitButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create Account"
        view.backgroundColor = .systemBackground

        navigationController?.navigationBar.prefersLargeTitles = true

        configureUI()
    }

    private func configureUI() {

        let heading = UILabel()
        heading.text = "Welcome"
        heading.font = .systemFont(
            ofSize: 28,
            weight: .bold
        )

        let subtitle = UILabel()
        subtitle.text = "Enter your details to continue."
        subtitle.font = .systemFont(ofSize: 16)
        subtitle.textColor = .secondaryLabel

        configureField(
            nameField,
            placeholder: "Full name"
        )

        configureField(
            emailField,
            placeholder: "Email address"
        )

        emailField.keyboardType = .emailAddress
        emailField.autocapitalizationType = .none
        emailField.textContentType = .emailAddress

        configureField(
            passwordField,
            placeholder: "Password"
        )

        passwordField.isSecureTextEntry = true
        passwordField.textContentType = .newPassword

        statusLabel.font = .systemFont(ofSize: 13)
        statusLabel.textColor = .systemRed
        statusLabel.numberOfLines = 0

        submitButton.setTitle(
            "Continue to Posts",
            for: .normal
        )

        submitButton.titleLabel?.font = .systemFont(
            ofSize: 17,
            weight: .semibold
        )

        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 12

        submitButton.heightAnchor.constraint(
            equalToConstant: 50
        ).isActive = true

        submitButton.addTarget(
            self,
            action: #selector(submitForm),
            for: .touchUpInside
        )

        let stack = UIStackView(
            arrangedSubviews: [
                heading,
                subtitle,
                nameField,
                emailField,
                passwordField,
                statusLabel,
                submitButton
            ]
        )

        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([

            stack.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 24
            ),

            stack.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -24
            ),

            stack.centerYAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.centerYAnchor
            )
        ])
    }

    private func configureField(
        _ field: UITextField,
        placeholder: String
    ) {

        field.placeholder = placeholder
        field.borderStyle = .roundedRect
        field.autocorrectionType = .no
        field.clearButtonMode = .whileEditing

        field.heightAnchor.constraint(
            equalToConstant: 50
        ).isActive = true
    }

    @objc private func submitForm() {

        let name = (nameField.text ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let email = (emailField.text ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let password = passwordField.text ?? ""

        // Name validation
        guard !name.isEmpty else {
            showValidationError("Please enter your full name.")
            return
        }

        // Email validation
        guard isValidEmail(email) else {
            showValidationError("Please enter a valid email address.")
            return
        }

        // Password validation
        guard password.count >= 8 else {
            showValidationError(
                "Password must contain at least 8 characters."
            )
            return
        }

        statusLabel.text = nil

        let postsVC = PostsViewController()
        postsVC.userName = name

        navigationController?.pushViewController(
            postsVC,
            animated: true
        )
    }

    private func showValidationError(_ message: String) {
        statusLabel.text = message
    }

    private func isValidEmail(_ email: String) -> Bool {

        let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        return email.range(
            of: pattern,
            options: .regularExpression
        ) != nil
    }
}
