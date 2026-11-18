import Foundation
import SwiftUI
import ExpenseMateCore

@MainActor
final class ExpenseViewModel: ObservableObject {
    @Published private(set) var expenses: [Expense] = []
    @Published var errorMessage: String?
    @Published var selectedCategory: ExpenseCategory?

    private let service: ExpenseService

    init() {
        let documents = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
        let fileURL = documents.appendingPathComponent("expenses.json")
        do {
            service = try ExpenseService(
                repository: JSONExpenseRepository(fileURL: fileURL)
            )
            expenses = service.expenses
        } catch {
            service = try! ExpenseService(
                repository: JSONExpenseRepository(
                    fileURL: FileManager.default.temporaryDirectory
                        .appendingPathComponent("expensemate-fallback.json")
                )
            )
            errorMessage = "Your saved expenses could not be loaded."
        }
    }

    var total: Double { service.total() }
    var monthlyTotal: Double { service.monthlyTotal() }
    var categoryTotals: [CategoryTotal] { service.categoryTotals() }
    var visibleExpenses: [Expense] { service.filtered(by: selectedCategory) }

    func add(title: String, amountText: String, category: ExpenseCategory, date: Date, note: String) {
        errorMessage = nil
        guard let amount = Double(amountText.replacingOccurrences(of: ",", with: ".")) else {
            errorMessage = "Enter a valid amount."
            return
        }
        do {
            try service.add(
                Expense(title: title, amount: amount, category: category, date: date, note: note)
            )
            refresh()
        } catch ExpenseValidationError.emptyTitle {
            errorMessage = "Please enter an expense title."
        } catch ExpenseValidationError.invalidAmount {
            errorMessage = "Amount must be greater than zero."
        } catch {
            errorMessage = "Could not save this expense. Please try again."
        }
    }

    func delete(at offsets: IndexSet) {
        let items = offsets.map { visibleExpenses[$0] }
        do {
            for item in items { try service.delete(id: item.id) }
            refresh()
        } catch {
            errorMessage = "Could not delete the selected expense."
        }
    }

    func refresh() {
        expenses = service.expenses
    }
}
