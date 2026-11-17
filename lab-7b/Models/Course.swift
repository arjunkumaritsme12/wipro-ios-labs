import Foundation

struct Course {
    let id: Int
    let name: String
    let instructor: String
    let duration: String
    let description: String

    static let sampleCourses: [Course] = [

        Course(
            id: 1,
            name: "Swift Programming",
            instructor: "Apple Development Team",
            duration: "6 Weeks",
            description: "Learn Swift fundamentals, variables, functions, structures, classes and object-oriented programming."
        ),

        Course(
            id: 2,
            name: "UIKit Development",
            instructor: "iOS Development Team",
            duration: "8 Weeks",
            description: "Learn UIKit, UIViewController, Auto Layout, navigation controllers and table views."
        ),

        Course(
            id: 3,
            name: "iOS App Development",
            instructor: "Mobile Development Team",
            duration: "10 Weeks",
            description: "Build complete iOS applications using Swift, UIKit, networking and application architecture."
        ),

        Course(
            id: 4,
            name: "Swift Concurrency",
            instructor: "Apple Development Team",
            duration: "4 Weeks",
            description: "Understand async and await, Tasks, actors and structured concurrency in Swift."
        )
    ]
}