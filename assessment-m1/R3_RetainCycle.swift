
import Foundation

// Demonstration of fixing a retain cycle

class Teacher {

    let name: String
    var classroom: Classroom?

    init(name: String) {
        self.name = name
        print("Teacher \(name) created")
    }

    deinit {
        print("Teacher \(name) deallocated")
    }
}

class Classroom {

    let roomNumber: Int

    // Weak reference prevents retain cycle
    weak var teacher: Teacher?

    init(roomNumber: Int) {
        self.roomNumber = roomNumber
        print("Classroom \(roomNumber) created")
    }

    deinit {
        print("Classroom \(roomNumber) deallocated")
    }
}

// Create objects
var teacher: Teacher? = Teacher(name: "Arjun")

var classroom: Classroom? = Classroom(roomNumber: 101)

// Connect objects
teacher?.classroom = classroom
classroom?.teacher = teacher

print("Teacher and Classroom connected")

// Release strong references
teacher = nil
classroom = nil

print("Both objects released")
