import UIKit

class CourseDetailViewController: UIViewController {

    private let course: Course

    private let nameLabel = UILabel()
    private let instructorLabel = UILabel()
    private let durationLabel = UILabel()
    private let descriptionLabel = UILabel()

    init(course: Course) {
        self.course = course
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Course Details"
        view.backgroundColor = .systemBackground

        setupUI()
        displayCourseDetails()
    }

    private func setupUI() {

        let stackView = UIStackView(
            arrangedSubviews: [
                nameLabel,
                instructorLabel,
                durationLabel,
                descriptionLabel
            ]
        )

        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill

        stackView.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.font = .preferredFont(forTextStyle: .largeTitle)
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.textColor = .label
        nameLabel.numberOfLines = 0

        instructorLabel.font = .preferredFont(forTextStyle: .headline)
        instructorLabel.adjustsFontForContentSizeCategory = true

        durationLabel.font = .preferredFont(forTextStyle: .subheadline)
        durationLabel.adjustsFontForContentSizeCategory = true
        durationLabel.textColor = .systemBlue

        descriptionLabel.font = .preferredFont(forTextStyle: .body)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.numberOfLines = 0

        descriptionLabel.textColor = .secondaryLabel

        view.addSubview(stackView)

        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 35
            ),

            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),

            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            )
        ])
    }

    private func displayCourseDetails() {

        nameLabel.text = course.name

        instructorLabel.text =
            "Instructor: \(course.instructor)"

        durationLabel.text =
            "Duration: \(course.duration)"

        descriptionLabel.text =
            course.description
    }
}