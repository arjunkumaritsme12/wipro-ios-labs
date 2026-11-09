
import Foundation

func calculateMean(numbers: [Double]) -> Double {
    if numbers.isEmpty {
        return 0
    }
    return numbers.reduce(0, +) / Double(numbers.count)
}

func findMaximum(numbers: [Int]) -> Int? {
    return numbers.max()
}

func isValidEmail(email: String) -> Bool {
    let parts = email.split(separator: "@")
    
    if parts.count != 2 {
        return false
    }
    
    return parts[1].contains(".") && !parts[0].isEmpty
}

func formatDisplayName(firstName: String, lastName: String) -> String {
    return "\(firstName.capitalized) \(lastName.capitalized)"
}

struct Transaction {
    let category: String
    let amount: Double
    let type: String
}

func calculateTotalExpenses(transactions: [Transaction]) -> Double {
    let expenses = transactions.filter { $0.type == "Expense" }
    let amounts = expenses.map { $0.amount }
    return amounts.reduce(0, +)
}

func calculateTotalUsingLoop(transactions: [Transaction]) -> Double {
    var total = 0.0
    
    for transaction in transactions {
        if transaction.type == "Expense" {
            total += transaction.amount
        }
    }
    
    return total
}

struct Student {
    let name: String
    let marks: Int
}

func sortStudents(students: [Student]) -> [Student] {
    return students.sorted {
        if $0.marks == $1.marks {
            return $0.name < $1.name
        }
        return $0.marks > $1.marks
    }
}

func spendingByCategory(transactions: [Transaction]) -> [String: Double] {
    let expenses = transactions.filter { $0.type == "Expense" }
    
    return expenses.reduce(into: [String: Double]()) {
        $0[$1.category, default: 0] += $1.amount
    }
}

let numbers: [Double] = [10, 20, 30, 40, 50]
let marks = [45, 89, 67, 92, 76]

print("Mean:", calculateMean(numbers: numbers))
print("Maximum:", findMaximum(numbers: marks) ?? 0)
print("Email Valid:", isValidEmail(email: "arjun.kumar_cs.aiml23@gla.ac.in"))
print("Display Name:", formatDisplayName(firstName: "Arjun", lastName: "Kumar"))

let transactions = [
    Transaction(category: "Food", amount: 500, type: "Expense"),
    Transaction(category: "Travel", amount: 300, type: "Expense"),
    Transaction(category: "Food", amount: 200, type: "Expense"),
    Transaction(category: "Shopping", amount: 1000, type: "Expense"),
    Transaction(category: "Salary", amount: 5000, type: "Income")
]

print("\nTotal Expenses:", calculateTotalExpenses(transactions: transactions))
print("Total Using Loop:", calculateTotalUsingLoop(transactions: transactions))

let students = [
    Student(name: "Rahul", marks: 85),
    Student(name: "Aman", marks: 92),
    Student(name: "Karan", marks: 85),
    Student(name: "Priya", marks: 95)
]

print("\nSorted Students:")

for student in sortStudents(students: students) {
    print("\(student.name): \(student.marks)")
}

print("\nSpending By Category:")

let categoryReport = spendingByCategory(transactions: transactions)

for category in categoryReport.keys.sorted() {
    print("\(category): \(categoryReport[category]!)")
}
