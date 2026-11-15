import Foundation

class TaskListModel {

    private(set) var tasks: [TaskModel] = []

    func addTask(_ title: String) -> Bool {

        let trimmedTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !trimmedTitle.isEmpty else {
            return false
        }

        let task = TaskModel(title: trimmedTitle)
        tasks.append(task)

        return true
    }

    func toggleTask(at index: Int) {

        guard tasks.indices.contains(index) else {
            return
        }

        tasks[index].isCompleted.toggle()
    }

    func deleteTask(at index: Int) {

        guard tasks.indices.contains(index) else {
            return
        }

        tasks.remove(at: index)
    }

    func filteredTasks(_ filter: TaskFilter) -> [TaskModel] {

        switch filter {

        case .all:
            return tasks

        case .active:
            return tasks.filter { !$0.isCompleted }

        case .completed:
            return tasks.filter { $0.isCompleted }
        }
    }
}