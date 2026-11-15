import Foundation

struct TaskModel {
    let id: UUID
    var title: String
    var isCompleted: Bool

    init(title: String) {
        self.id = UUID()
        self.title = title
        self.isCompleted = false
    }
}

enum TaskFilter {
    case all
    case active
    case completed
}