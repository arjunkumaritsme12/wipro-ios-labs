
import Foundation

protocol Displayable {
    func display() -> String
}

struct Student: Displayable {
    let name: String
    let marks: Int

    func display() -> String {
        return "Student: \(name), Marks: \(marks)"
    }
}

struct Course: Displayable {
    let title: String
    let duration: Int

    func display() -> String {
        return "Course: \(title), Duration: \(duration) months"
    }
}

extension String {
    var wordCount: Int {
        return self.split(separator: " ").count
    }
}

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

struct Stack<T> {
    private var items: [T] = []

    var isEmpty: Bool {
        return items.isEmpty
    }

    mutating func push(_ item: T) {
        items.append(item)
    }

    mutating func pop() -> T? {
        return items.popLast()
    }

    func peek() -> T? {
        return items.last
    }
}

func showDetails<T: Displayable>(_ item: T) {
    print(item.display())
}

let student = Student(name: "Arjun", marks: 85)
let course = Course(title: "Swift Programming", duration: 3)

print("Protocol Examples:")
showDetails(student)
showDetails(course)

print("\nExtension Examples:")
let message = "Swift programming is interesting"
print("Word Count:", message.wordCount)
print("Is 20 even?", 20.isEven)

print("\nInteger Stack:")
var intStack = Stack<Int>()

intStack.push(10)
intStack.push(20)
intStack.push(30)

print("Top Element:", intStack.peek() ?? 0)
print("Removed Element:", intStack.pop() ?? 0)
print("New Top Element:", intStack.peek() ?? 0)
print("Is Empty:", intStack.isEmpty)

print("\nString Stack:")
var stringStack = Stack<String>()

stringStack.push("Apple")
stringStack.push("Banana")
stringStack.push("Mango")

print("Top Element:", stringStack.peek() ?? "None")
print("Removed Element:", stringStack.pop() ?? "None")
print("New Top Element:", stringStack.peek() ?? "None")

print("\nAssertion Tests:")

assert(student.display() == "Student: Arjun, Marks: 85")
assert(course.display() == "Course: Swift Programming, Duration: 3 months")
assert(message.wordCount == 5)
assert(20.isEven == true)
assert(15.isEven == false)

var testStack = Stack<Int>()

assert(testStack.isEmpty == true)

testStack.push(100)
assert(testStack.isEmpty == false)
assert(testStack.peek() == 100)
assert(testStack.pop() == 100)
assert(testStack.isEmpty == true)

var testStringStack = Stack<String>()
testStringStack.push("Hello")
assert(testStringStack.peek() == "Hello")

print("All 11 tests passed successfully!")