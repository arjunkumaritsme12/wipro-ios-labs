import Foundation
import Combine

class TaskViewModel: ObservableObject {

    @Published private(set) var tasks: [Task] = []

    @Published var selectedFilter: TaskFilter = .all

    @Published private(set) var errorMessage: String?

    var filteredTasks: [Task] {

        switch selectedFilter {

        case .all:
            return tasks

        case .active:
            return tasks.filter { !$0.isCompleted }

        case .completed:
            return tasks.filter { $0.isCompleted }
        }
    }

    func addTask(_ title: String) {

        let trimmedTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !trimmedTitle.isEmpty else {
            errorMessage = "Task name cannot be empty."
            return
        }

        tasks.append(Task(title: trimmedTitle))
        errorMessage = nil
    }

    func toggleTask(_ task: Task) {

        guard let index = tasks.firstIndex(
            where: { $0.id == task.id }
        ) else {
            return
        }

        tasks[index].isCompleted.toggle()
    }

    func deleteTask(_ task: Task) {

        tasks.removeAll { $0.id == task.id }
    }

    func clearError() {
        errorMessage = nil
    }
}