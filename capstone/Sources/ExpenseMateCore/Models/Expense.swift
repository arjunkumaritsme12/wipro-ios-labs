import Foundation

public enum ExpenseCategory: String, CaseIterable, Codable, Identifiable {
    case food = "Food"
    case transport = "Transport"
    case shopping = "Shopping"
    case bills = "Bills"
    case health = "Health"
    case education = "Education"
    case entertainment = "Entertainment"
    case other = "Other"

    public var id: String { rawValue }

    public var symbol: String {
        switch self {
        case .food: return "fork.knife"
        case .transport: return "car.fill"
        case .shopping: return "bag.fill"
        case .bills: return "doc.text.fill"
        case .health: return "cross.case.fill"
        case .education: return "book.fill"
        case .entertainment: return "film.fill"
        case .other: return "ellipsis.circle.fill"
        }
    }
}

public struct Expense: Identifiable, Codable, Equatable {
    public let id: UUID
    public var title: String
    public var amount: Double
    public var category: ExpenseCategory
    public var date: Date
    public var note: String

    public init(
        id: UUID = UUID(),
        title: String,
        amount: Double,
        category: ExpenseCategory,
        date: Date = Date(),
        note: String = ""
    ) {
        self.id = id
        self.title = title
        self.amount = amount
        self.category = category
        self.date = date
        self.note = note
    }
}
