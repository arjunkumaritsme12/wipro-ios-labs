func toggleTask(id: UUID) {
    guard let index = tasks.firstIndex(where: { $0.id == id }) else {
        return
    }

    tasks[index].isCompleted.toggle()
}

func deleteTask(id: UUID) {
    tasks.removeAll { $0.id == id }
}