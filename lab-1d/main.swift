
import Foundation

let studentMarks: [Int: Double] = [
    101: 85.0,
    102: 92.0,
    103: 78.0,
    104: 95.0,
    105: 67.0
]

func findMarks(by studentID: Int) -> Double? {
    return studentMarks[studentID]
}

print("===== R1: Optional Result =====")

let searchID = 102

if let marks = findMarks(by: searchID) {
    print("Student ID: \(searchID)")
    print("Marks: \(marks)")
} else {
    print("Student not found")
}

print("\n===== R2: Optional Handling Techniques =====")

if let marks = findMarks(by: 101) {
    print("if let: Student Marks = \(marks)")
} else {
    print("if let: Marks not found")
}

func displayStudentMarks(_ studentID: Int) {
    guard let marks = findMarks(by: studentID) else {
        print("guard let: Student not found")
        return
    }

    print("guard let: Student Marks = \(marks)")
}

displayStudentMarks(103)
displayStudentMarks(999)

struct Student {
    let name: String
    let address: String?
}

let student = Student(
    name: "Arjun Kumar",
    address: "Mathura, Uttar Pradesh"
)

let studentAddress = student.address?.uppercased()
print("Optional Chaining: \(studentAddress ?? "Address not available")")

let nickname: String? = nil
let displayName = nickname ?? "Unknown Student"

print("Nil-Coalescing: \(displayName)")

print("\n===== R3: Missing Values Handling =====")

let missingID = 999

if let marks = studentMarks[missingID] {
    print("Marks: \(marks)")
} else {
    print("Missing Dictionary Key: Student ID \(missingID) not found")
}

let textField = "   "
let enteredText = textField.trimmingCharacters(in: .whitespacesAndNewlines)

if enteredText.isEmpty {
    print("Empty Text Field: Please enter a value")
} else {
    print("Entered Text: \(enteredText)")
}

print("\n===== Optional Profile Model =====")

struct Profile {
    let name: String
    let address: String?
    let phone: String?

    func displayProfile() {
        print("Name: \(name)")
        print("Address: \(address ?? "Not provided")")
        print("Phone: \(phone ?? "Not provided")")
    }
}

let profile = Profile(
    name: "Arjun Kumar",
    address: nil,
    phone: "9876543210"
)

profile.displayProfile()

print("\n===== R4: Safe Unwrapping Check =====")

let optionalMarks = findMarks(by: 104)

if let marks = optionalMarks {
    print("Safely retrieved marks: \(marks)")
} else {
    print("Marks are unavailable")
}

print("No force unwrapping used in this program.")

print("\n===== Lab 1D Completed Successfully =====")
