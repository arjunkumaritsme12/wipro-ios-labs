
import Foundation

struct CourseData {

    static let samples: [Course] = [

        Course(
            title: "SwiftUI Development",
            subtitle: "Learn modern iOS development",
            category: "Mobile Development",
            status: "Popular",
            duration: "6 Weeks",
            description: """
            Learn to build modern iOS applications using SwiftUI.
            Understand views, layouts, navigation, state management
            and reusable components.
            """
        ),

        Course(
            title: "Python Programming",
            subtitle: "Master Python fundamentals",
            category: "Programming",
            status: "Beginner",
            duration: "4 Weeks",
            description: """
            Learn Python programming from scratch.
            Explore variables, loops, functions, collections
            and object-oriented programming.
            """
        ),

        Course(
            title: "Machine Learning",
            subtitle: "Explore intelligent systems",
            category: "Artificial Intelligence",
            status: "Trending",
            duration: "8 Weeks",
            description: """
            Understand machine learning concepts including
            supervised learning, unsupervised learning,
            model training and evaluation.
            """
        ),

        Course(
            title: "Web Development",
            subtitle: "Build modern websites",
            category: "Development",
            status: "Popular",
            duration: "5 Weeks",
            description: """
            Learn HTML, CSS and JavaScript to build
            responsive and interactive websites.
            """
        ),

        Course(
            title: "Data Structures",
            subtitle: "Improve problem solving skills",
            category: "Programming",
            status: "Intermediate",
            duration: "7 Weeks",
            description: """
            Study arrays, linked lists, stacks, queues,
            trees, graphs and algorithms.
            """
        ),

        Course(
            title: "Artificial Intelligence",
            subtitle: "Understand AI technologies",
            category: "Artificial Intelligence",
            status: "New",
            duration: "9 Weeks",
            description: """
            Explore artificial intelligence concepts,
            neural networks, deep learning and real-world
            AI applications.
            """
        )
    ]

    static let categories: [String] = [
        "All",
        "Programming",
        "Mobile Development",
        "Artificial Intelligence",
        "Development"
    ]
}
