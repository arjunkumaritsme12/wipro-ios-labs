import UIKit

class CourseListViewController: UIViewController {

    private let tableView = UITableView()

    private let courses = Course.sampleCourses

    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "No courses available."
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.isHidden = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Available Courses"
        view.backgroundColor = .systemBackground

        setupTableView()
        setupEmptyState()
    }

    private func setupTableView() {

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            CourseTableViewCell.self,
            forCellReuseIdentifier: CourseTableViewCell.identifier
        )

        tableView.dataSource = self
        tableView.delegate = self

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100

        view.addSubview(tableView)

        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),

            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])
    }

    private func setupEmptyState() {

        emptyLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(emptyLabel)

        NSLayoutConstraint.activate([

            emptyLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),

            emptyLabel.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            )
        ])

        emptyLabel.isHidden = !courses.isEmpty
        tableView.isHidden = courses.isEmpty
    }
}

// MARK: - UITableViewDataSource

extension CourseListViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return courses.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CourseTableViewCell.identifier,
            for: indexPath
        ) as? CourseTableViewCell else {

            return UITableViewCell(
                style: .default,
                reuseIdentifier: nil
            )
        }

        let course = courses[indexPath.row]
        cell.configure(with: course)

        return cell
    }
}

// MARK: - UITableViewDelegate

extension CourseListViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        tableView.deselectRow(at: indexPath, animated: true)

        let selectedCourse = courses[indexPath.row]

        let detailVC = CourseDetailViewController(
            course: selectedCourse
        )

        navigationController?.pushViewController(
            detailVC,
            animated: true
        )
    }
}