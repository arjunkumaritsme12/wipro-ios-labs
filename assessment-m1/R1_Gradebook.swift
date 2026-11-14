
import Foundation

var gradebook: [String: [Double]] = [
    "Arjun": [85, 90, 88],
    "Rahul": [75, 80, 82],
    "Priya": [92, 95, 90],
    "Aman": [65, 70, 68]
]

func calculateAverage(marks: [Double]) -> Double {
    guard !marks.isEmpty else {
        return 0.0
    }

    let total = marks.reduce(0, +)
    return total / Double(marks.count)
}

print("===== STUDENT GRADEBOOK =====")

for (name, marks) in gradebook {
    let average = calculateAverage(marks: marks)

    print("Student: \(name)")
    print("Marks: \(marks)")
    print("Average: \(String(format: "%.2f", average))")
    print("-----------------------------")
}

let studentName = "Arjun"

if let marks = gradebook[studentName] {
    print("\(studentName)'s Average: \(calculateAverage(marks: marks))")
} else {
    print("Student not found")
}

let missingStudent = gradebook["Rohit"]

print("Missing Student: \(missingStudent ?? [])")
