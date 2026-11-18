import SwiftUI
import UIKit

struct DashboardView: View {
    @EnvironmentObject private var viewModel: ExpenseViewModel
    @State private var showingAdd = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Total expenses").font(.subheadline).foregroundStyle(.white.opacity(0.8))
                        Text(viewModel.total, format: .currency(code: "INR"))
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                        Text("All recorded transactions").font(.caption).foregroundStyle(.white.opacity(0.8))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(22)
                    .foregroundStyle(.white)
                    .background(
                        LinearGradient(colors: [.indigo, .purple], startPoint: .topLeading, endPoint: .bottomTrailing),
                        in: RoundedRectangle(cornerRadius: 24)
                    )

                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("This month").font(.caption).foregroundStyle(.secondary)
                            Text(viewModel.monthlyTotal, format: .currency(code: "INR"))
                                .font(.title3.bold())
                        }
                        Spacer()
                        Image(systemName: "calendar")
                            .font(.title2)
                            .foregroundStyle(.indigo)
                    }
                    .padding(18)
                    .background(.background, in: RoundedRectangle(cornerRadius: 18))
                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(.quaternary))

                    HStack {
                        Text("Recent transactions").font(.headline)
                        Spacer()
                        Button("See all") {}
                            .font(.subheadline.weight(.semibold))
                    }
                    if viewModel.expenses.isEmpty {
                        ContentUnavailableView(
                            "No expenses yet",
                            systemImage: "tray",
                            description: Text("Add your first expense to start tracking your spending.")
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                    } else {
                        ForEach(Array(viewModel.expenses.prefix(4))) { expense in
                            ExpenseRow(expense: expense)
                            if expense.id != viewModel.expenses.prefix(4).last?.id {
                                Divider()
                            }
                        }
                    }
                    Button {
                        showingAdd = true
                    } label: {
                        Label("Add an expense", systemImage: "plus")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.indigo, in: RoundedRectangle(cornerRadius: 16))
                            .foregroundStyle(.white)
                    }
                }
                .padding()
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationTitle("ExpenseMate")
            .sheet(isPresented: $showingAdd) { AddExpenseView() }
            .alert("Notice", isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            )) {
                Button("OK") { viewModel.errorMessage = nil }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
}
