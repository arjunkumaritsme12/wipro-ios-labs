
import Foundation

// Define custom errors
enum ValidationError: Error {
    case emptyName
    case invalidAge
}

// Throwing validation function
func validateStudent(name: String, age: Int) throws -> String {

    // Check empty name
    guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
        throw ValidationError.emptyName
    }

    // Check valid age
    guard age >= 18 && age <= 60 else {
        throw ValidationError.invalidAge
    }

    return "Student \(name) validated successfully!"
}

// Test Case 1: Valid student
do {
    let result = try validateStudent(name: "Arjun", age: 21)
    print(result)

} catch ValidationError.emptyName {
    print("Error: Student name cannot be empty.")

} catch ValidationError.invalidAge {
    print("Error: Age must be between 18 and 60.")

} catch {
    print("Unknown error:", error)
}

// Test Case 2: Empty name
do {
    let result = try validateStudent(name: "", age: 21)
    print(result)

} catch ValidationError.emptyName {
    print("Error: Student name cannot be empty.")

} catch ValidationError.invalidAge {
    print("Error: Age must be between 18 and 60.")

} catch {
    print("Unknown error:", error)
}

// Test Case 3: Invalid age
do {
    let result = try validateStudent(name: "Rahul", age: 15)
    print(result)

} catch ValidationError.emptyName {
    print("Error: Student name cannot be empty.")

} catch ValidationError.invalidAge {
    print("Error: Age must be between 18 and 60.")

} catch {
    print("Unknown error:", error)
}
