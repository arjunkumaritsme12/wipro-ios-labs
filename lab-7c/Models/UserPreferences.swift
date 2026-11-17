import Foundation

struct UserPreferences {

    var name: String = ""
    var notificationsEnabled: Bool = true
    var selectedCourse: String = "iOS"
    var experienceLevel: Float = 5.0
    var selectedDate: Date = Date()

    var summary: String {

        return """
        Name: \(name.isEmpty ? "Not entered" : name)

        Notifications: \(notificationsEnabled ? "Enabled" : "Disabled")

        Course: \(selectedCourse)

        Experience Level: \(Int(experienceLevel))/10

        Selected Date: \(selectedDate.formatted(date: .medium, time: .omitted))
        """
    }
}