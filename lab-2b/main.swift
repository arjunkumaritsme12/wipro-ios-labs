
import Foundation

struct Student {
    let name: String
    let marks: Int
}

func sortStudents(students: [Student]) -> [Student] {
    return students.sorted { first, second in
        first.marks > second.marks
    }
}

let students = [
    Student(name: "Arjun", marks: 85),
    Student(name: "Rahul", marks: 92),
    Student(name: "Priya", marks: 95),
    Student(name: "Aman", marks: 78)
]

print("Sorted Students:")

let sortedStudents = sortStudents(students: students)

for student in sortedStudents {
    print("\(student.name): \(student.marks)")
}


func performOperation(completion: () -> Void) {
    print("\nOperation started")

    completion()
}

performOperation {
    print("Operation completed successfully")
}


func showMessage(message: String, completion: (String) -> Void) {
    completion(message)
}

showMessage(message: "Welcome to Swift Closures") { message in
    print("\n\(message)")
}

showMessage(message: "Learning closures is interesting") { result in
    print(result)
}


func makeCounter() -> () -> Int {
    var count = 0

    return {
        count += 1
        return count
    }
}

let counter = makeCounter()

print("\nCounter:")
print(counter())
print(counter())
print(counter())


class DataManager {
    var onCompletion: (() -> Void)?

    func startTask() {
        onCompletion = { [weak self] in
            guard let self = self else {
                return
            }

            print("\nTask completed for \(self.name)")
        }
    }

    let name: String

    init(name: String) {
        self.name = name
    }

    deinit {
        print("DataManager released")
    }
}

var manager: DataManager? = DataManager(name: "Arjun")

manager?.startTask()
manager?.onCompletion?()

manager = nil


func retryOperation(maxAttempts: Int, operation: () -> Bool) {
    for attempt in 1...maxAttempts {
        print("\nAttempt \(attempt)")

        if operation() {
            print("Operation successful")
            return
        }
    }

    print("Operation failed after all attempts")
}

var attempts = 0

retryOperation(maxAttempts: 3) {
    attempts += 1
    return attempts == 2
}
