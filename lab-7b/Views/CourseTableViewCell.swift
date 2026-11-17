import UIKit

class CourseTableViewCell: UITableViewCell {

    static let identifier = "CourseTableViewCell"

    private let courseNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        return label
    }()

    private let instructorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        return label
    }()

    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .systemBlue
        return label
    }()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {

        let stackView = UIStackView(
            arrangedSubviews: [
                courseNameLabel,
                instructorLabel,
                durationLabel
            ]
        )

        stackView.axis = .vertical
        stackView.spacing = 6

        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 12
            ),

            stackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),

            stackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),

            stackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -12
            )
        ])

        accessoryType = .disclosureIndicator
        accessibilityElement = true
    }

    func configure(with course: Course) {

        courseNameLabel.text = course.name
        instructorLabel.text = "Instructor: \(course.instructor)"
        durationLabel.text = "Duration: \(course.duration)"

        accessibilityLabel = """
        \(course.name), Instructor: \(course.instructor), Duration: \(course.duration)
        """
    }
}