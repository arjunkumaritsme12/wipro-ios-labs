
import Foundation

struct Course {
    var name: String
    var duration: Int
}

class CourseManager {
    var course: Course

    init(course: Course) {
        self.course = course
    }

    deinit {
        print("CourseManager released from memory")
    }
}

print("===== R1: Struct and Class =====")

let originalCourse = Course(name: "Swift Programming", duration: 30)

let manager = CourseManager(course: originalCourse)

print("Course Name: \(originalCourse.name)")
print("Course Duration: \(originalCourse.duration) Days")
print("Manager Course: \(manager.course.name)")

print("\n===== R2: Value vs Reference Behaviour =====")

var copiedCourse = originalCourse
copiedCourse.name = "Python Programming"
copiedCourse.duration = 45

print("Original Struct: \(originalCourse.name), \(originalCourse.duration) Days")
print("Copied Struct: \(copiedCourse.name), \(copiedCourse.duration) Days")

let managerCopy = manager
managerCopy.course.name = "Java Programming"
managerCopy.course.duration = 60

print("Original Manager: \(manager.course.name), \(manager.course.duration) Days")
print("Copied Manager: \(managerCopy.course.name), \(managerCopy.course.duration) Days")

print("\n===== R3: Teacher and Classroom =====")

class Teacher {
    let name: String
    var classroom: Classroom?

    init(name: String) {
        self.name = name
        print("Teacher \(name) created")
    }

    deinit {
        print("Teacher \(name) released")
    }
}

class Classroom {
    let roomNumber: Int
    weak var teacher: Teacher?

    init(roomNumber: Int) {
        self.roomNumber = roomNumber
        print("Classroom \(roomNumber) created")
    }

    deinit {
        print("Classroom \(roomNumber) released")
    }
}

var teacher: Teacher? = Teacher(name: "Mr. Sharma")
var classroom: Classroom? = Classroom(roomNumber: 101)

teacher?.classroom = classroom
classroom?.teacher = teacher

print("Teacher: \(teacher?.name ?? "Unknown")")
print("Classroom: \(teacher?.classroom?.roomNumber ?? 0)")
print("Classroom Teacher: \(classroom?.teacher?.name ?? "Unknown")")

teacher = nil
classroom = nil

print("\n===== R4: Strong Reference Cycle =====")

class ClosureDemo {
    let name: String
    var completion: (() -> Void)?

    init(name: String) {
        self.name = name
        print("\(name) created")
    }

    func createStrongCycle() {
        completion = {
            print("Strong closure accessing \(self.name)")
        }
    }

    func createWeakClosure() {
        completion = { [weak self] in
            guard let self = self else {
                print("Object no longer exists")
                return
            }

            print("Weak closure accessing \(self.name)")
        }
    }

    deinit {
        print("\(name) released from memory")
    }
}

print("Creating strong reference cycle")


var strongObject: ClosureDemo? = ClosureDemo(name: "Strong Object")
strongObject?.createStrongCycle()

strongObject?.completion?()

strongObject?.completion = nil
strongObject = nil

print("Strong reference cycle successfully broken")

var weakObject: ClosureDemo? = ClosureDemo(name: "Weak Object")
weakObject?.createWeakClosure()

weakObject?.completion?()

weakObject = nil

print("\n===== R5: Value, Reference and ARC =====")

print("Struct: Value type, independent copies.")
print("Class: Reference type, shared instance.")
print("ARC: Automatically manages class instance memory.")
print("Strong: Keeps an object alive.")
print("Weak: Does not keep an object alive.")
print("Capture List: Prevents unwanted strong closure captures.")

print("\n===== Lab 1E Completed Successfully =====")
