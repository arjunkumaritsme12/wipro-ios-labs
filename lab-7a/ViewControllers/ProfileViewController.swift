import UIKit

class ProfileViewController: UIViewController {

    // MARK: - UI Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Your Profile"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your details to get started."
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()

    private let nameField = UITextField()
    private let emailField = UITextField()
    private let courseField = UITextField()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .preferredFont(forTextStyle: .footnote)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit Profile", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(
            greaterThanOrEqualToConstant: 50
        ).isActive = true
        return button
    }()

    private let formStack = UIStackView()
    private let scrollView = UIScrollView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile Form"
        view.backgroundColor = .systemBackground

        setupTextFields()
        setupLayout()
        setupActions()
        setupKeyboardHandling()
    }

    // MARK: - Text Fields

    private func setupTextFields() {

        configureField(
            nameField,
            placeholder: "Full Name",
            keyboardType: .default,
            contentType: .name
        )

        configureField(
            emailField,
            placeholder: "Email Address",
            keyboardType: .emailAddress,
            contentType: .emailAddress
        )

        configureField(
            courseField,
            placeholder: "Course (e.g. B.Tech CSE)",
            keyboardType: .default,
            contentType: nil
        )

        nameField.returnKeyType = .next
        emailField.returnKeyType = .next
        courseField.returnKeyType = .done

        nameField.delegate = self
        emailField.delegate = self
        courseField.delegate = self
    }

    private func configureField(
        _ field: UITextField,
        placeholder: String,
        keyboardType: UIKeyboardType,
        contentType: UITextContentType?
    ) {

        field.placeholder = placeholder
        field.borderStyle = .roundedRect
        field.font = .preferredFont(forTextStyle: .body)
        field.adjustsFontForContentSizeCategory = true
        field.keyboardType = keyboardType
        field.textContentType = contentType
        field.autocorrectionType = .no
        field.clearButtonMode = .whileEditing
        field.heightAnchor.constraint(
            greaterThanOrEqualToConstant: 50
        ).isActive = true

        field.accessibilityLabel = placeholder
        field.accessibilityHint = "Enter \(placeholder)"
    }

    // MARK: - Layout

    private func setupLayout() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        formStack.translatesAutoresizingMaskIntoConstraints = false

        formStack.axis = .vertical
        formStack.spacing = 18
        formStack.alignment = .fill
        formStack.distribution = .fill

        let headingStack = UIStackView(
            arrangedSubviews: [titleLabel, subtitleLabel]
        )

        headingStack.axis = .vertical
        headingStack.spacing = 8
        headingStack.alignment = .fill

        formStack.addArrangedSubview(headingStack)
        formStack.addArrangedSubview(nameField)
        formStack.addArrangedSubview(emailField)
        formStack.addArrangedSubview(courseField)
        formStack.addArrangedSubview(errorLabel)
        formStack.addArrangedSubview(submitButton)

        view.addSubview(scrollView)
        scrollView.addSubview(formStack)

        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),

            scrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            scrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            scrollView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),

            formStack.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor,
                constant: 35
            ),

            formStack.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor,
                constant: 24
            ),

            formStack.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor,
                constant: -24
            ),

            formStack.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor,
                constant: -35
            ),

            formStack.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor,
                constant: -48
            )
        ])
    }

    // MARK: - Actions

    private func setupActions() {

        submitButton.addTarget(
            self,
            action: #selector(submitProfile),
            for: .touchUpInside
        )

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Validation

    @objc private func submitProfile() {

        view.endEditing(true)

        let name = nameField.text ?? ""
        let email = emailField.text ?? ""
        let course = courseField.text ?? ""

        if let error = ProfileValidator.validate(
            name: name,
            email: email,
            course: course
        ) {

            errorLabel.text = error
            errorLabel.isHidden = false

            let alert = UIAlertController(
                title: "Validation Error",
                message: error,
                preferredStyle: .alert
            )

            alert.addAction(
                UIAlertAction(title: "OK", style: .default)
            )

            present(alert, animated: true)

            return
        }

        errorLabel.isHidden = true

        let alert = UIAlertController(
            title: "Success!",
            message: """
            Profile submitted successfully.

            Name: \(name)
            Email: \(email)
            Course: \(course)
            """,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(title: "OK", style: .default)
        )

        present(alert, animated: true)
    }

    // MARK: - Keyboard Handling

    private func setupKeyboardHandling() {

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(
        notification: Notification
    ) {

        guard let frame = notification.userInfo?[
            UIResponder.keyboardFrameEndUserInfoKey
        ] as? CGRect else {
            return
        }

        scrollView.contentInset.bottom = frame.height
        scrollView.verticalScrollIndicatorInsets.bottom = frame.height
    }

    @objc private func keyboardWillHide(
        notification: Notification
    ) {

        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UITextFieldDelegate

extension ProfileViewController: UITextFieldDelegate {

    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {

        if textField == nameField {
            emailField.becomeFirstResponder()

        } else if textField == emailField {
            courseField.becomeFirstResponder()

        } else {
            courseField.resignFirstResponder()
            submitProfile()
        }

        return true
    }
}