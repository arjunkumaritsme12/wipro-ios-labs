
let studentName = "Arjun"
let rollNumber = 2315510039

let marks: [Int] = [85, 76, 92, 68, 79]
let attendance = 85.0

let totalMarks = marks.reduce(0, +)
let average = Double(totalMarks) / Double(marks.count)
let percentage = (Double(totalMarks) / 500.0) * 100

let hasValidMarks = marks.allSatisfy { $0 >= 0 && $0 <= 100 }
let hasValidAttendance = attendance >= 0 && attendance <= 100

let hasPassed = marks.allSatisfy { $0 >= 35 }
let attendanceEligible = attendance >= 75

var result = "Fail"
var grade = "F"

if hasValidMarks && hasValidAttendance {
    if hasPassed && attendanceEligible {
        result = "Pass"

        switch percentage {
        case 90...100:
            grade = "A+"
        case 80..<90:
            grade = "A"
        case 70..<80:
            grade = "B"
        case 60..<70:
            grade = "C"
        case 50..<60:
            grade = "D"
        default:
            grade = "F"
        }
    }
} else {
    result = "Invalid Input"
}

var bonusMarks = 0
bonusMarks += 5

let optionalRemark: String? = nil
let remark = optionalRemark ?? "No remarks"

let firstSubject = marks.first ?? 0
let lastSubject = marks.last ?? 0

let addition = firstSubject + lastSubject
let subtraction = firstSubject - lastSubject
let multiplication = firstSubject * lastSubject
let division = Double(firstSubject) / Double(lastSubject)

let isHighScorer = percentage >= 80
let isLowAttendance = attendance < 75
let isEligible = hasPassed && attendanceEligible
let isNotEligible = !isEligible

print("===== STUDENT RESULT =====")
print("Name: \(studentName)")
print("Roll Number: \(rollNumber)")
print("Marks: \(marks)")
print("Attendance: \(attendance)%")
print("Total: \(totalMarks)/500")
print("Average: \(average)")
print("Percentage: \(percentage)%")
print("Result: \(result)")
print("Grade: \(grade)")
print("Attendance Eligible: \(attendanceEligible)")
print("Remark: \(remark)")

print("\n===== OPERATOR DEMONSTRATION =====")
print("Addition: \(addition)")
print("Subtraction: \(subtraction)")
print("Multiplication: \(multiplication)")
print("Division: \(division)")
print("Comparison: \(isHighScorer)")
print("Logical AND: \(isEligible)")
print("Logical NOT: \(isNotEligible)")
print("Low Attendance: \(isLowAttendance)")
print("Compound Assignment: \(bonusMarks)")
print("Nil Coalescing: \(remark)")
