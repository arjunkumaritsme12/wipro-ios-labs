import SwiftUI
import ExpenseMateCore

struct AddExpenseView: View {
    @EnvironmentObject private var viewModel: ExpenseViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var amount = ""
    @State private var category: ExpenseCategory = .food
    @State private var date = Date()
    @State private var note = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Expense details") {
                    TextField("What did you spend on?", text: $title)
                        .textInputAutocapitalization(.words)
                    TextField("Amount (₹)", text: $amount)
                        .keyboardType(.decimalPad)
                    Picker("Category", selection: $category) {
                        ForEach(ExpenseCategory.allCases) { item in
                            Text(item.rawValue).tag(item)
                        }
                    }
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Note (optional)", text: $note, axis: .vertical)
                        .lineLimit(2...4)
                }
                Section {
                    Button("Save expense") {
                        viewModel.add(
                            title: title,
                            amountText: amount,
                            category: category,
                            date: date,
                            note: note
                        )
                        if viewModel.errorMessage == nil { dismiss() }
                    }
                    .frame(maxWidth: .infinity)
                    .fontWeight(.semibold)
                }
            }
            .navigationTitle("New expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
