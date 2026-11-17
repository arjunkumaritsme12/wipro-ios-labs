import XCTest
@testable import Milestone2

final class TaskViewModelTests: XCTestCase {
    func testAddTaskTrimsWhitespace() async {
        await MainActor.run {
            let viewModel = TaskViewModel()
            viewModel.addTask(title: "  Buy groceries  ")
            XCTAssertEqual(viewModel.tasks.count, 1)
            XCTAssertEqual(viewModel.tasks.first?.title, "Buy groceries")
        }
    }

    func testEmptyTaskIsIgnored() async {
        await MainActor.run {
            let viewModel = TaskViewModel()
            viewModel.addTask(title: "   ")
            XCTAssertTrue(viewModel.tasks.isEmpty)
        }
    }

    func testToggleTaskChangesCompletion() async {
        await MainActor.run {
            let viewModel = TaskViewModel()
            viewModel.addTask(title: "Write tests")
            let id = try! XCTUnwrap(viewModel.tasks.first?.id)

            viewModel.toggleTask(id: id)
            XCTAssertEqual(viewModel.tasks.first?.isCompleted, true)

            viewModel.toggleTask(id: id)
            XCTAssertEqual(viewModel.tasks.first?.isCompleted, false)
        }
    }

    func testDeleteTaskRemovesItem() async {
        await MainActor.run {
            let viewModel = TaskViewModel()
            viewModel.addTask(title: "Delete me")
            let id = try! XCTUnwrap(viewModel.tasks.first?.id)
            viewModel.deleteTask(id: id)
            XCTAssertTrue(viewModel.tasks.isEmpty)
        }
    }
}
