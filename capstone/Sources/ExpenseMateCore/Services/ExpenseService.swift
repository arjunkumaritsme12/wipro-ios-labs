import Foundation

public enum ExpenseValidationError: Error, Equatable {
    case emptyTitle
    case invalidAmount
}

public struct CategoryTotal: Equatable, Identifiable {
    public let category: ExpenseCategory
    public let total: Double
    public var id: String { category.rawValue }
}

public final class ExpenseService {
    private let repository: ExpenseRepository
    private(set) public var expenses: [Expense]

    public init(repository: ExpenseRepository) throws {
        self.repository = repository
        self.expenses = try repository.load()
    }

    public func add(_ expense: Expense) throws {
        try Self.validate(title: expense.title, amount: expense.amount)
        expenses.insert(expense, at: 0)
        try persist()
    }

    public func update(_ expense: Expense) throws {
        try Self.validate(title: expense.title, amount: expense.amount)
        guard let index = expenses.firstIndex(where: { $0.id == expense.id }) else {
            return
        }
        expenses[index] = expense
        try persist()
    }

    public func delete(id: UUID) throws {
        expenses.removeAll { $0.id == id }
        try persist()
    }

    public func total(for expenses: [Expense]? = nil) -> Double {
        (expenses ?? self.expenses).reduce(0) { $0 + $1.amount }
    }

    public func monthlyTotal(for date: Date = Date(), calendar: Calendar = .current) -> Double {
        let monthExpenses = expenses.filter {
            calendar.isDate($0.date, equalTo: date, toGranularity: .month)
        }
        return total(for: monthExpenses)
    }

    public func categoryTotals() -> [CategoryTotal] {
        let grouped = Dictionary(grouping: expenses, by: \.category)
        return grouped.map { category, items in
            CategoryTotal(category: category, total: total(for: items))
        }
        .sorted { $0.total > $1.total }
    }

    public func filtered(by category: ExpenseCategory?) -> [Expense] {
        guard let category else { return expenses }
        return expenses.filter { $0.category == category }
    }

    public static func validate(title: String, amount: Double) throws {
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw ExpenseValidationError.emptyTitle
        }
        guard amount.isFinite && amount > 0 else {
            throw ExpenseValidationError.invalidAmount
        }
    }

    private func persist() throws {
        try repository.save(expenses)
    }
}
