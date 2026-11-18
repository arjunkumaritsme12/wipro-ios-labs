import SwiftUI
import ExpenseMateCore

struct TransactionsView: View {
    @EnvironmentObject private var viewModel: ExpenseViewModel
    @State private var showingAdd = false

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.visibleExpenses.isEmpty {
                    ContentUnavailableView(
                        "No transactions found",
                        systemImage: "list.bullet.rectangle",
                        description: Text(viewModel.selectedCategory == nil
                            ? "Your expenses will appear here."
                            : "Try another category filter.")
                    )
                } else {
                    List {
                        ForEach(viewModel.visibleExpenses) { expense in
                            ExpenseRow(expense: expense)
                        }
                        .onDelete(perform: viewModel.delete)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Button("All categories") { viewModel.selectedCategory = nil }
                        ForEach(ExpenseCategory.allCases) { category in
                            Button(category.rawValue) { viewModel.selectedCategory = category }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button { showingAdd = true } label: { Image(systemName: "plus") }
                }
            }
            .sheet(isPresented: $showingAdd) { AddExpenseView() }
        }
    }
}
