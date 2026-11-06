
import Foundation

let studentName = "Arjun Kumar"
let rollNumber = 2315510039

let marks1 = 94.0
let marks2 = 87.0
let marks3 = 92.0
let marks4 = 88.0
let marks5 = 98.0

let attendance = 92.67

let totalSubjects = 5
let maximumMarks = 100.0
let passingMarks = 40.0

let totalMarks = marks1 + marks2 + marks3 + marks4 + marks5
let average = totalMarks / Double(totalSubjects)
let percentage = (totalMarks / (Double(totalSubjects) * maximumMarks)) * 100

var grade: String
var result = "Pass"

if average < passingMarks {
    result = "Fail"
}

if percentage >= 90 {
    grade = "A+"
} else if percentage >= 80 {
    grade = "A"
} else if percentage >= 70 {
    grade = "B"
} else if percentage >= 60 {
    grade = "C"
} else if percentage >= 50 {
    grade = "D"
} else {
    grade = "F"
}

let gradeMessage: String

switch grade {
case "A+":
    gradeMessage = "Excellent Performance"
case "A":
    gradeMessage = "Very Good Performance"
case "B":
    gradeMessage = "Good Performance"
case "C":
    gradeMessage = "Average Performance"
case "D":
    gradeMessage = "Needs Improvement"
default:
    gradeMessage = "Failed"
}

print("===== Student Report =====")
print("Name: \(studentName)")
print("Roll Number: \(rollNumber)")
print("Total Marks: \(totalMarks)/500")
print("Average: \(average)")
print("Percentage: \(percentage)%")
print("Grade: \(grade)")
print("Result: \(result)")
print("Performance: \(gradeMessage)")
print("Attendance: \(attendance)%")

if attendance >= 75 && attendance <= 100 {
    print("Attendance Status: Eligible")
} else {
    print("Attendance Status: Not Eligible")
}

let a = 20
let b = 10

print("\n===== Arithmetic Operators =====")
print("Addition: \(a + b)")
print("Subtraction: \(a - b)")
print("Multiplication: \(a * b)")
print("Division: \(a / b)")
print("Remainder: \(a % b)")

print("\n===== Comparison Operators =====")
print("Equal: \(a == b)")
print("Not Equal: \(a != b)")
print("Greater Than: \(a > b)")
print("Less Than: \(a < b)")
print("Greater Than or Equal: \(a >= b)")
print("Less Than or Equal: \(a <= b)")

print("\n===== Logical Operators =====")
let isPassed = true
let hasGoodAttendance = true

print("AND: \(isPassed && hasGoodAttendance)")
print("OR: \(isPassed || false)")
print("NOT: \(!isPassed)")

print("\n===== Compound Assignment Operators =====")
var score = 50

score += 10
print("After += 10: \(score)")

score -= 5
print("After -= 5: \(score)")

score *= 2
print("After *= 2: \(score)")

score /= 5
print("After /= 5: \(score)")

print("\n===== Nil-Coalescing Operator =====")
let studentNickname: String? = nil
let displayName = studentNickname ?? studentName

print("Display Name: \(displayName)")

func validateMarks(_ marks: Double) -> String {
    if marks < 0 || marks > 100 {
        return "Invalid Marks"
    } else if marks < passingMarks {
        return "Fail"
    } else {
        return "Pass"
    }
}

func validateAttendance(_ attendance: Double) -> String {
    if attendance < 0 || attendance > 100 {
        return "Invalid Attendance"
    } else if attendance < 75 {
        return "Not Eligible"
    } else {
        return "Eligible"
    }
}

print("\n===== Boundary Value Validation =====")
print("Marks 0: \(validateMarks(0))")
print("Marks 100: \(validateMarks(100))")
print("Failing Marks 30: \(validateMarks(30))")
print("Invalid Marks 110: \(validateMarks(110))")

print("Attendance 0: \(validateAttendance(0))")
print("Attendance 100: \(validateAttendance(100))")
print("Invalid Attendance 120: \(validateAttendance(120))")
print("Attendance 80: \(validateAttendance(80))")
