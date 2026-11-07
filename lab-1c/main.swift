
import Foundation

print("===== R1: Array Operations =====")

var courses = [
    "Swift",
    "Python",
    "Java",
    "JavaScript",
    "C++"
]

print("Original Courses: \(courses)")

courses.append("Kotlin")
print("After Adding: \(courses)")

courses.removeAll { $0 == "Java" }
print("After Removing Java: \(courses)")

courses.sort()
print("Sorted Courses: \(courses)")

let filteredCourses = courses.filter { $0.count > 5 }
print("Courses with more than 5 characters: \(filteredCourses)")

let searchCourse = "Python"

if courses.contains(searchCourse) {
    print("\(searchCourse) found in course list")
} else {
    print("\(searchCourse) not found in course list")
}

print("\n===== R2: Set Operations =====")

let studentIDs = [
    101, 102, 103, 101, 104,
    102, 105, 106, 103, 107
]

let uniqueStudentIDs = Set(studentIDs)

print("Original Student IDs: \(studentIDs)")
print("Unique Student IDs: \(uniqueStudentIDs.sorted())")
print("Total Student IDs: \(studentIDs.count)")
print("Unique Student Count: \(uniqueStudentIDs.count)")
print("Duplicate Count: \(studentIDs.count - uniqueStudentIDs.count)")

print("\n===== R3: Dictionary Operations =====")

let studentMarks: [Int: Double] = [
    101: 85,
    102: 92,
    103: 78,
    104: 95,
    105: 67,
    106: 88,
    107: 55
]

print("Student Marks: \(studentMarks)")

if let topper = studentMarks.max(by: { $0.value < $1.value }) {
    print("Topper ID: \(topper.key)")
    print("Topper Marks: \(topper.value)")
}

let threshold = 75.0

let belowThreshold = studentMarks
    .filter { $0.value < threshold }
    .sorted { $0.key < $1.key }

print("Students Scoring Below \(threshold):")

for (studentID, marks) in belowThreshold {
    print("Student ID: \(studentID), Marks: \(marks)")
}

print("\n===== R4: Enum and Switch =====")

enum TaskPriority {
    case low
    case medium
    case high
    case urgent
}

let tasks: [TaskPriority] = [
    .low,
    .medium,
    .high,
    .urgent
]

for task in tasks {
    switch task {
    case .low:
        print("Low Priority: Can be completed later")
    case .medium:
        print("Medium Priority: Complete soon")
    case .high:
        print("High Priority: Complete as early as possible")
    case .urgent:
        print("Urgent Priority: Complete immediately")
    }
}

print("\n===== R5: Collection Explanation =====")

print("Array: Stores ordered elements and allows duplicates.")
print("Set: Stores unique elements and removes duplicates.")
print("Dictionary: Stores key-value pairs for fast lookup.")

print("\n===== Lab 1C Completed Successfully =====")
