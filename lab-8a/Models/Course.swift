
import Foundation

struct Course: Identifiable, Hashable {

    let id: UUID
    let title: String
    let subtitle: String
    let category: String
    let status: String
    let duration: String
    let description: String

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        category: String,
        status: String,
        duration: String,
        description: String
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.category = category
        self.status = status
        self.duration = duration
        self.description = description
    }
}
