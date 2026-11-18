
import UIKit

final class PostsViewController: UIViewController {

    var userName = "User"

    private let tableView = UITableView()

    private let activityIndicator =
        UIActivityIndicatorView(style: .large)

    private let messageLabel = UILabel()

    private let retryButton = UIButton(type: .system)

    private let service = PostService()

    private var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Posts"
        view.backgroundColor = .systemBackground

        navigationItem.largeTitleDisplayMode = .never

        configureUI()
        loadPosts()
    }

    private func configureUI() {

        // Table View
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "PostCell"
        )

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        tableView.isHidden = true

        // Loading Indicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true

        // Message Label
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .secondaryLabel
        messageLabel.isHidden = true

        // Retry Button
        retryButton.translatesAutoresizingMaskIntoConstraints = false

        retryButton.setTitle(
            "Try Again",
            for: .normal
        )

        retryButton.titleLabel?.font = .systemFont(
            ofSize: 16,
            weight: .semibold
        )

        retryButton.isHidden = true

        retryButton.addTarget(
            self,
            action: #selector(loadPosts),
            for: .touchUpInside
        )

        // Add Subviews
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.addSubview(messageLabel)
        view.addSubview(retryButton)

        // Auto Layout
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
            ),

            activityIndicator.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),

            activityIndicator.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),

            messageLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),

            messageLabel.centerYAnchor.constraint(
                equalTo: view.centerYAnchor,
                constant: -20
            ),

            messageLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 28
            ),

            messageLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -28
            ),

            retryButton.topAnchor.constraint(
                equalTo: messageLabel.bottomAnchor,
                constant: 16
            ),

            retryButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            )
        ])
    }

    // MARK: - API Request

    @objc private func loadPosts() {

        showLoading()

        service.fetchPosts { [weak self] result in

            DispatchQueue.main.async {

                guard let self = self else {
                    return
                }

                switch result {

                case .success(let fetchedPosts):

                    self.posts = fetchedPosts

                    if fetchedPosts.isEmpty {
                        self.showMessage("No posts found.")
                    } else {
                        self.showList()
                    }

                case .failure(let error):

                    self.showFailure(
                        error.localizedDescription
                    )
                }
            }
        }
    }

    // MARK: - Loading State

    private func showLoading() {

        tableView.isHidden = true
        messageLabel.isHidden = true
        retryButton.isHidden = true

        activityIndicator.startAnimating()
    }

    // MARK: - Success State

    private func showList() {

        activityIndicator.stopAnimating()

        messageLabel.isHidden = true
        retryButton.isHidden = true

        tableView.isHidden = false
        tableView.reloadData()
    }

    // MARK: - Empty State

    private func showMessage(_ message: String) {

        activityIndicator.stopAnimating()

        tableView.isHidden = true

        messageLabel.text = message
        messageLabel.isHidden = false

        retryButton.isHidden = true
    }

    // MARK: - Failure State

    private func showFailure(_ message: String) {

        activityIndicator.stopAnimating()

        tableView.isHidden = true

        messageLabel.text = """
        Unable to load posts.
        \(message)
        """

        messageLabel.isHidden = false
        retryButton.isHidden = false
    }
}

// MARK: - UITableView DataSource and Delegate

extension PostsViewController:
    UITableViewDataSource,
    UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return posts.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "PostCell",
            for: indexPath
        )

        let post = posts[indexPath.row]

        var content = cell.defaultContentConfiguration()

        content.text = post.title.capitalized

        content.secondaryText =
            "Post #\(post.id) • \(post.body)"

        content.secondaryTextProperties.numberOfLines = 2

        cell.contentConfiguration = content

        cell.accessoryType = .disclosureIndicator

        return cell
    }

    // MARK: - Navigate to Detail Screen

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        tableView.deselectRow(
            at: indexPath,
            animated: true
        )

        let selectedPost = posts[indexPath.row]

        let detailVC = PostDetailViewController(
            post: selectedPost
        )

        navigationController?.pushViewController(
            detailVC,
            animated: true
        )
    }
}
