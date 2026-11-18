import XCTest
@testable import ExpenseMateCore

final class ExpenseServiceTests: XCTestCase {
    private func makeService() throws -> ExpenseService {
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathComponent("expenses.json")
        return try ExpenseService(repository: JSONExpenseRepository(fileURL: url))
    }

    private func sample(
        title: String = "Lunch",
        amount: Double = 120,
        category: ExpenseCategory = .food,
        date: Date = Date()
    ) -> Expense {
        Expense(title: title, amount: amount, category: category, date: date)
    }

    func testNewRepositoryStartsEmpty() throws {
        let service = try makeService()
        XCTAssertTrue(service.expenses.isEmpty)
    }

    func testAddExpense() throws {
        let service = try makeService()
        try service.add(sample())
        XCTAssertEqual(service.expenses.count, 1)
        XCTAssertEqual(service.expenses.first?.title, "Lunch")
    }

    func testRejectsBlankTitle() throws {
        let service = try makeService()
        XCTAssertThrowsError(try service.add(sample(title: "   "))) { error in
            XCTAssertEqual(error as? ExpenseValidationError, .emptyTitle)
        }
    }

    func testRejectsZeroAmount() throws {
        let service = try makeService()
        XCTAssertThrowsError(try service.add(sample(amount: 0))) { error in
            XCTAssertEqual(error as? ExpenseValidationError, .invalidAmount)
        }
    }

    func testRejectsNegativeAmount() throws {
        let service = try makeService()
        XCTAssertThrowsError(try service.add(sample(amount: -10))) { error in
            XCTAssertEqual(error as? ExpenseValidationError, .invalidAmount)
        }
    }

    func testDeleteExpense() throws {
        let service = try makeService()
        let expense = sample()
        try service.add(expense)
        try service.delete(id: expense.id)
        XCTAssertTrue(service.expenses.isEmpty)
    }

    func testUpdateExpense() throws {
        let service = try makeService()
        let expense = sample()
        try service.add(expense)
        let changed = Expense(
            id: expense.id,
            title: "Dinner",
            amount: 250,
            category: .food,
            date: expense.date
        )
        try service.update(changed)
        XCTAssertEqual(service.expenses.first?.title, "Dinner")
        XCTAssertEqual(service.expenses.first?.amount, 250)
    }

    func testCategoryTotalsAreSortedDescending() throws {
        let service = try makeService()
        try service.add(sample(title: "Bus", amount: 40, category: .transport))
        try service.add(sample(title: "Shoes", amount: 500, category: .shopping))
        try service.add(sample(title: "Snack", amount: 60, category: .food))
        let totals = service.categoryTotals()
        XCTAssertEqual(totals.first?.category, .shopping)
        XCTAssertEqual(totals.first?.total, 500)
    }

    func testFilterByCategory() throws {
        let service = try makeService()
        try service.add(sample(title: "Lunch", amount: 100, category: .food))
        try service.add(sample(title: "Cab", amount: 200, category: .transport))
        XCTAssertEqual(service.filtered(by: .food).count, 1)
        XCTAssertEqual(service.filtered(by: .food).first?.title, "Lunch")
    }

    func testTotalSumsExpenses() throws {
        let service = try makeService()
        try service.add(sample(amount: 100))
        try service.add(sample(title: "Cab", amount: 75, category: .transport))
        XCTAssertEqual(service.total(), 175)
    }
}
