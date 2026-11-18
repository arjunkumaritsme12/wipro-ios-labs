
import Foundation

struct CourseData {

    static let courses: [Course] = [
        Course(
            id: 1,
            title: "Swift Programming",
            subtitle: "Learn Swift from basics",
            category: "iOS Development",
            duration: "4 Weeks",
            description: "Learn Swift fundamentals, variables, functions, structures, classes and object-oriented programming."
        ),
        Course(
            id: 2,
            title: "SwiftUI Development",
            subtitle: "Build modern iOS interfaces",
            category: "iOS Development",
            duration: "6 Weeks",
            description: "Understand SwiftUI views, layouts, state management, reusable components and navigation."
        ),
        Course(
            id: 3,
            title: "Python Programming",
            subtitle: "Start learning Python",
            category: "Programming",
            duration: "5 Weeks",
            description: "Learn Python syntax, data structures, functions, file handling and practical programming."
        ),
        Course(
            id: 4,
            title: "Machine Learning",
            subtitle: "Explore intelligent systems",
            category: "Artificial Intelligence",
            duration: "8 Weeks",
            description: "Understand machine learning concepts, supervised learning, unsupervised learning and model evaluation."
        ),
        Course(
            id: 5,
            title: "Web Development",
            subtitle: "Create websites and web apps",
            category: "Development",
            duration: "6 Weeks",
            description: "Learn HTML, CSS and JavaScript to build responsive and interactive websites."
        )
    ]
}
