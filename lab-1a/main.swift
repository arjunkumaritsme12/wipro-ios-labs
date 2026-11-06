import Foundation

let studentName = "Arjun Kumar"
let rollNumber = 2315510039

let marks1 = 94.0
let marks2 = 87.0
let marks3 = 92.0
let marks4 = 88.0
let marks5 = 98.0

let attendance = 92.67

let totalMarks = marks1 + marks2 + marks3 + marks4 + marks5
let percentage = totalMarks / 5

var grade: String

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

print("===== Student Report =====")
print("Name: \(studentName)")
print("Roll Number: \(rollNumber)")
print("Total Marks: \(totalMarks)/500")
print("Percentage: \(percentage)%")
print("Grade: \(grade)")
print("Attendance: \(attendance)%")

if attendance >= 75 {
    print("Attendance Status: Eligible")
} else {
    print("Attendance Status: Not Eligible")
}