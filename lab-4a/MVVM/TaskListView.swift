import SwiftUI

struct TaskListView: View {

    @StateObject private var viewModel = TaskViewModel()

    @State private var newTask = ""

    var body: some View {

        NavigationStack {

            VStack(spacing: 16) {

                HStack {

                    TextField("Enter a task", text: $newTask)
                        .textFieldStyle(.roundedBorder)

                    Button("Add") {

                        viewModel.addTask(newTask)
                        if viewModel.errorMessage == nil {
                            newTask = ""
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }

                Picker(
                    "Filter",
                    selection: $viewModel.selectedFilter
                ) {
                    Text("All").tag(TaskFilter.all)
                    Text("Active").tag(TaskFilter.active)
                    Text("Completed").tag(TaskFilter.completed)
                }
                .pickerStyle(.segmented)

                if let error = viewModel.errorMessage {

                    Text(error)
                        .foregroundStyle(.red)
                        .font(.caption)
                }

                List {

                    ForEach(viewModel.filteredTasks) { task in

                        HStack {

                            Button {
                                viewModel.toggleTask(task)
                            } label: {

                                Image(
                                    systemName: task.isCompleted
                                        ? "checkmark.circle.fill"
                                        : "circle"
                                )
                                .foregroundStyle(
                                    task.isCompleted ? .green : .gray
                                )
                            }
                            .buttonStyle(.plain)

                            Text(task.title)
                                .strikethrough(task.isCompleted)
                                .foregroundStyle(
                                    task.isCompleted ? .gray : .primary
                                )

                            Spacer()
                        }
                    }
                    .onDelete { offsets in

                        let tasksToDelete = offsets.map {
                            viewModel.filteredTasks[$0]
                        }

                        for task in tasksToDelete {
                            viewModel.deleteTask(task)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("MVVM Task Manager")
        }
    }
}