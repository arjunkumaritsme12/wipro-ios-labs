
import Foundation

enum ValidationError: Error {
    case emptyName
    case invalidMark
    case invalidID
}

struct Student {
    let name: String
    let marks: Int
    let id: Int
}

func registerStudent(name: String, marks: Int, id: Int) throws -> Student {
    if name.trimmingCharacters(in: .whitespaces).isEmpty {
        throw ValidationError.emptyName
    }

    if marks < 0 || marks > 100 {
        throw ValidationError.invalidMark
    }

    if id <= 0 {
        throw ValidationError.invalidID
    }

    return Student(name: name, marks: marks, id: id)
}

func displayRegistration(name: String, marks: Int, id: Int) {
    do {
        let student = try registerStudent(name: name, marks: marks, id: id)

        print("Registration Successful")
        print("Name: \(student.name)")
        print("Marks: \(student.marks)")
        print("ID: \(student.id)")

    } catch ValidationError.emptyName {
        print("Error: Student name cannot be empty.")

    } catch ValidationError.invalidMark {
        print("Error: Marks must be between 0 and 100.")

    } catch ValidationError.invalidID {
        print("Error: Student ID must be greater than zero.")

    } catch {
        print("Something went wrong.")
    }
}

print("Student Registration Tests")

displayRegistration(name: "Arjun", marks: 85, id: 101)

print()

displayRegistration(name: "", marks: 85, id: 102)

print()

displayRegistration(name: "Rahul", marks: 120, id: 103)

print()

displayRegistration(name: "Priya", marks: 90, id: -1)


func registerStudentOptional(name: String, marks: Int, id: Int) -> Student? {
    guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
          marks >= 0 && marks <= 100,
          id > 0 else {
        return nil
    }

    return Student(name: name, marks: marks, id: id)
}

print("\nOptional Example")

if let student = registerStudentOptional(name: "Aman", marks: 78, id: 104) {
    print("Student registered: \(student.name)")
} else {
    print("Registration failed.")
}


enum NetworkError: Error {
    case noInternet
    case serverError
}

func fetchStudentData(success: Bool) -> Result<String, NetworkError> {
    if success {
        return .success("Student data received successfully.")
    } else {
        return .failure(.noInternet)
    }
}

func showNetworkResult(result: Result<String, NetworkError>) {
    switch result {
    case .success(let message):
        print(message)

    case .failure(let error):
        switch error {
        case .noInternet:
            print("Please check your internet connection.")

        case .serverError:
            print("Server is currently unavailable.")
        }
    }
}

print("\nNetwork Result Example")

let response = fetchStudentData(success: true)
showNetworkResult(result: response)

let failedResponse = fetchStudentData(success: false)
showNetworkResult(result: failedResponse)


print("\nAssertion Tests")

assert(registerStudentOptional(name: "Arjun", marks: 85, id: 101) != nil)
assert(registerStudentOptional(name: "", marks: 85, id: 101) == nil)
assert(registerStudentOptional(name: "Rahul", marks: 110, id: 102) == nil)
assert(registerStudentOptional(name: "Priya", marks: 90, id: 0) == nil)

if case .success = fetchStudentData(success: true) {
    print("Network success test passed")
} else {
    assertionFailure("Expected network success")
}

if case .failure = fetchStudentData(success: false) {
    print("Network failure test passed")
} else {
    assertionFailure("Expected network failure")
}

print("All tests completed successfully!")
