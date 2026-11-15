import XCTest
@testable import Lab4A

final class TaskViewModelTests: XCTestCase {

    var viewModel: TaskViewModel!

    override func setUp() {
        super.setUp()
        viewModel = TaskViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testAddTask() {

        viewModel.addTask("Complete Swift Lab")

        XCTAssertEqual(viewModel.tasks.count, 1)
        XCTAssertEqual(
            viewModel.tasks.first?.title,
            "Complete Swift Lab"
        )
    }

    func testEmptyTaskValidation() {

        viewModel.addTask("   ")

        XCTAssertEqual(viewModel.tasks.count, 0)
        XCTAssertNotNil(viewModel.errorMessage)
    }

    func testCompleteTask() {

        viewModel.addTask("Learn MVVM")

        let task = viewModel.tasks[0]

        viewModel.toggleTask(task)

        XCTAssertTrue(viewModel.tasks[0].isCompleted)
    }

    func testDeleteTask() {

        viewModel.addTask("Delete this task")

        let task = viewModel.tasks[0]

        viewModel.deleteTask(task)

        XCTAssertEqual(viewModel.tasks.count, 0)
    }

    func testActiveFilter() {

        viewModel.addTask("Task One")
        viewModel.addTask("Task Two")

        let firstTask = viewModel.tasks[0]

        viewModel.toggleTask(firstTask)

        viewModel.selectedFilter = .active

        XCTAssertEqual(viewModel.filteredTasks.count, 1)
        XCTAssertFalse(viewModel.filteredTasks[0].isCompleted)
    }

    func testCompletedFilter() {

        viewModel.addTask("Task One")
        viewModel.addTask("Task Two")

        let firstTask = viewModel.tasks[0]

        viewModel.toggleTask(firstTask)

        viewModel.selectedFilter = .completed

        XCTAssertEqual(viewModel.filteredTasks.count, 1)
        XCTAssertTrue(viewModel.filteredTasks[0].isCompleted)
    }
}