import Foundation

/// ViewModel owns screen state and exposes actions for a task-list view.
@MainActor
public final class TaskViewModel {
    public private(set) var tasks: [TaskItem] = []

    public init() {}

    public func addTask(title: String) {
        let cleanedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanedTitle.isEmpty else { return }
        tasks.append(TaskItem(title: cleanedTitle))
    }

    public func toggleTask(id: UUID) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }
        tasks[index].isCompleted.toggle()
    }

    public func deleteTask(id: UUID) {
        tasks.removeAll { $0.id == id }
    }
}
