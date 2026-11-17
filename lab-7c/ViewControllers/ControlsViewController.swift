
import UIKit

class ControlsViewController: UIViewController {

    // MARK: - State

    private var preferences = UserPreferences()

    // MARK: - UI Components

    private let nameField = UITextField()

    private let notificationSwitch = UISwitch()

    private let courseSegment: UISegmentedControl = {
        let segment = UISegmentedControl(
            items: ["iOS", "Android", "Web"]
        )
        segment.selectedSegmentIndex = 0
        return segment
    }()

    private let experienceSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.value = 5
        return slider
    }()

    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        return picker
    }()

    private let sliderValueLabel = UILabel()

    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        return label
    }()

    private let summaryPanel: UIView = {
        let panel = UIView()
        panel.backgroundColor = .secondarySystemBackground
        panel.layer.cornerRadius = 12
        return panel
    }()

    private let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update Summary", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.layer.cornerRadius = 10
        return button
    }()

    // Navigation button added

    private let navigationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Open Lifecycle Demo", for: .normal)
        button.backgroundColor = .systemIndigo
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.layer.cornerRadius = 10
        button.accessibilityLabel = "Open Lifecycle Demo"
        button.heightAnchor.constraint(
            greaterThanOrEqualToConstant: 50
        ).isActive = true
        return button
    }()

    private let scrollView = UIScrollView()
    private let mainStack = UIStackView()

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Lifecycle: viewDidLoad")

        title = "UI Controls Lab"
        view.backgroundColor = .systemBackground

        setupControls()
        setupLayout()
        setupActions()
        setupKeyboardHandling()

        updateSummary()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        print("Lifecycle: viewWillAppear")

        updateSummary()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("Lifecycle: viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        print("Lifecycle: viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        print("Lifecycle: viewDidDisappear")
    }

    // MARK: - Controls Setup

    private func setupControls() {

        nameField.placeholder = "Enter your name"
        nameField.borderStyle = .roundedRect
        nameField.font = .preferredFont(forTextStyle: .body)
        nameField.adjustsFontForContentSizeCategory = true
        nameField.autocorrectionType = .no
        nameField.returnKeyType = .done
        nameField.accessibilityLabel = "Enter your name"

        // Delegate added
        nameField.delegate = self

        notificationSwitch.isOn = true
        notificationSwitch.accessibilityLabel = "Enable notifications"

        courseSegment.accessibilityLabel = "Select course"

        experienceSlider.accessibilityLabel = "Experience level"
        sliderValueLabel.text = "Experience: 5/10"

        datePicker.accessibilityLabel = "Select date"

        summaryLabel.accessibilityLabel = "Preferences summary"

        updateButton.accessibilityLabel = "Update summary"
    }

    // MARK: - Layout

    private func setupLayout() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        mainStack.axis = .vertical
        mainStack.spacing = 20
        mainStack.alignment = .fill

        view.addSubview(scrollView)
        scrollView.addSubview(mainStack)

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

            mainStack.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor,
                constant: 20
            ),

            mainStack.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor,
                constant: 20
            ),

            mainStack.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor,
                constant: -20
            ),

            mainStack.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor,
                constant: -20
            ),

            mainStack.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor,
                constant: -40
            )
        ])

        addSection(
            title: "Personal Information",
            views: [nameField]
        )

        let notificationRow = UIStackView(
            arrangedSubviews: [
                createLabel("Notifications"),
                notificationSwitch
            ]
        )

        notificationRow.axis = .horizontal
        notificationRow.distribution = .equalSpacing

        addSection(
            title: "Notification Settings",
            views: [notificationRow]
        )

        addSection(
            title: "Select Your Course",
            views: [courseSegment]
        )

        addSection(
            title: "Experience Level",
            views: [sliderValueLabel, experienceSlider]
        )

        addSection(
            title: "Select Date",
            views: [datePicker]
        )

        summaryPanel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false

        summaryPanel.addSubview(summaryLabel)

        NSLayoutConstraint.activate([

            summaryLabel.topAnchor.constraint(
                equalTo: summaryPanel.topAnchor,
                constant: 16
            ),

            summaryLabel.leadingAnchor.constraint(
                equalTo: summaryPanel.leadingAnchor,
                constant: 16
            ),

            summaryLabel.trailingAnchor.constraint(
                equalTo: summaryPanel.trailingAnchor,
                constant: -16
            ),

            summaryLabel.bottomAnchor.constraint(
                equalTo: summaryPanel.bottomAnchor,
                constant: -16
            )
        ])

        mainStack.addArrangedSubview(
            createLabel("Preferences Summary")
        )

        mainStack.addArrangedSubview(summaryPanel)

        mainStack.addArrangedSubview(updateButton)

        // Navigation button added to layout
        mainStack.addArrangedSubview(navigationButton)
    }

    private func createLabel(_ text: String) -> UILabel {

        let label = UILabel()
        label.text = text
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label

        return label
    }

    private func addSection(
        title: String,
        views: [UIView]
    ) {

        let stack = UIStackView()

        stack.axis = .vertical
        stack.spacing = 10

        stack.addArrangedSubview(createLabel(title))

        for item in views {
            stack.addArrangedSubview(item)
        }

        mainStack.addArrangedSubview(stack)
    }

    // MARK: - Actions

    private func setupActions() {

        nameField.addTarget(
            self,
            action: #selector(nameChanged),
            for: .editingChanged
        )

        notificationSwitch.addTarget(
            self,
            action: #selector(notificationChanged),
            for: .valueChanged
        )

        courseSegment.addTarget(
            self,
            action: #selector(courseChanged),
            for: .valueChanged
        )

        experienceSlider.addTarget(
            self,
            action: #selector(experienceChanged),
            for: .valueChanged
        )

        datePicker.addTarget(
            self,
            action: #selector(dateChanged),
            for: .valueChanged
        )

        updateButton.addTarget(
            self,
            action: #selector(updateButtonTapped),
            for: .touchUpInside
        )

        // Navigation action connected
        navigationButton.addTarget(
            self,
            action: #selector(openLifecycleDemo),
            for: .touchUpInside
        )
    }

    // MARK: - Navigation

    @objc private func openLifecycleDemo() {

        let nextVC = LifecycleDemoViewController()

        navigationController?.pushViewController(
            nextVC,
            animated: true
        )
    }

    // MARK: - State Updates

    @objc private func nameChanged() {

        preferences.name = nameField.text ?? ""
        updateSummary()
    }

    @objc private func notificationChanged() {

        preferences.notificationsEnabled =
            notificationSwitch.isOn

        updateSummary()
    }

    @objc private func courseChanged() {

        let index = courseSegment.selectedSegmentIndex

        guard index >= 0,
              index < courseSegment.numberOfSegments else {
            return
        }

        preferences.selectedCourse =
            courseSegment.titleForSegment(at: index) ?? "Unknown"

        updateSummary()
    }

    @objc private func experienceChanged() {

        preferences.experienceLevel = experienceSlider.value

        sliderValueLabel.text =
            "Experience: \(Int(experienceSlider.value))/10"

        updateSummary()
    }

    @objc private func dateChanged() {

        preferences.selectedDate = datePicker.date
        updateSummary()
    }

    @objc private func updateButtonTapped() {

        view.endEditing(true)

        updateSummary()

        let alert = UIAlertController(
            title: "Updated Successfully",
            message: "Your preferences have been updated.",
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(title: "OK", style: .default)
        )

        present(alert, animated: true)
    }

    // MARK: - Summary

    private func updateSummary() {
        summaryLabel.text = preferences.summary
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

        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func keyboardWillShow(
        notification: Notification
    ) {

        guard let keyboardFrame = notification.userInfo?[
            UIResponder.keyboardFrameEndUserInfoKey
        ] as? CGRect else {
            return
        }

        scrollView.contentInset.bottom = keyboardFrame.height
        scrollView.verticalScrollIndicatorInsets.bottom =
            keyboardFrame.height

        print("Keyboard presented - Layout adjusted")
    }

    @objc private func keyboardWillHide(
        notification: Notification
    ) {

        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0

        print("Keyboard dismissed - Layout restored")
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UITextFieldDelegate

extension ControlsViewController: UITextFieldDelegate {

    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {

        textField.resignFirstResponder()
        return true
    }
}
