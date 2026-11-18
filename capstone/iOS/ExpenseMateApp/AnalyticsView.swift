import SwiftUI

struct AnalyticsView: View {
    @EnvironmentObject private var viewModel: ExpenseViewModel

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.categoryTotals.isEmpty {
                    ContentUnavailableView(
                        "Nothing to analyze",
                        systemImage: "chart.pie",
                        description: Text("Add expenses to see your category-wise spending.")
                    )
                } else {
                    List {
                        Section("Spending by category") {
                            ForEach(viewModel.categoryTotals) { item in
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Label(item.category.rawValue, systemImage: item.category.symbol)
                                        Spacer()
                                        Text(item.total, format: .currency(code: "INR"))
                                            .fontWeight(.semibold)
                                    }
                                    GeometryReader { geometry in
                                        let maxValue = max(viewModel.total, 1)
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(.indigo.opacity(0.18))
                                            .overlay(alignment: .leading) {
                                                RoundedRectangle(cornerRadius: 5)
                                                    .fill(.indigo)
                                                    .frame(width: geometry.size.width * item.total / maxValue)
                                            }
                                    }
                                    .frame(height: 8)
                                }
                                .padding(.vertical, 5)
                            }
                        }
                        Section {
                            HStack {
                                Text("Total spending")
                                Spacer()
                                Text(viewModel.total, format: .currency(code: "INR"))
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Analytics")
        }
    }
}
