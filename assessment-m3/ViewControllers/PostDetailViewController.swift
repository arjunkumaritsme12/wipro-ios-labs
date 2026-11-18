
import UIKit

final class PostDetailViewController: UIViewController {

    private let post: Post

    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Post Details"
        view.backgroundColor = .systemBackground

        configureUI()
    }

    private func configureUI() {

        // Post Title
        let titleLabel = UILabel()

        titleLabel.text = post.title.capitalized

        titleLabel.font = .systemFont(
            ofSize: 24,
            weight: .bold
        )

        titleLabel.numberOfLines = 0

        // Post Information
        let metadataLabel = UILabel()

        metadataLabel.text =
            "Post ID: \(post.id)   •   User ID: \(post.userId)"

        metadataLabel.font = .systemFont(
            ofSize: 13,
            weight: .medium
        )

        metadataLabel.textColor = .secondaryLabel

        // Post Body
        let bodyLabel = UILabel()

        bodyLabel.text = post.body

        bodyLabel.font = .systemFont(ofSize: 17)

        bodyLabel.numberOfLines = 0

        // Stack View
        let stack = UIStackView(
            arrangedSubviews: [
                titleLabel,
                metadataLabel,
                bodyLabel
            ]
        )

        stack.axis = .vertical
        stack.spacing = 18

        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        // Auto Layout Constraints
        NSLayoutConstraint.activate([

            stack.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 24
            ),

            stack.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),

            stack.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            )
        ])
    }
}
