
import Foundation

// Generic Stack Implementation
struct Stack<T> {

    private var elements: [T] = []

    // Add element
    mutating func push(_ element: T) {
        elements.append(element)
    }

    // Remove top element
    mutating func pop() -> T? {
        return elements.popLast()
    }

    // View top element
    func peek() -> T? {
        return elements.last
    }

    // Check whether stack is empty
    var isEmpty: Bool {
        return elements.isEmpty
    }

    // Display stack
    func display() {
        print(elements)
    }
}

// Example 1: Integer Stack
print("===== INTEGER STACK =====")

var intStack = Stack<Int>()

intStack.push(10)
intStack.push(20)
intStack.push(30)

print("Stack elements:")
intStack.display()

print("Top element:", intStack.peek() ?? -1)
print("Removed element:", intStack.pop() ?? -1)

print("After pop:")
intStack.display()

// Example 2: String Stack
print("\n===== STRING STACK =====")

var stringStack = Stack<String>()

stringStack.push("Swift")
stringStack.push("UIKit")
stringStack.push("SwiftUI")

print("Stack elements:")
stringStack.display()

print("Top element:", stringStack.peek() ?? "Empty")
print("Removed element:", stringStack.pop() ?? "Empty")

print("After pop:")
stringStack.display()
