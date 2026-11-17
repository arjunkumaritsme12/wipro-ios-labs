import Foundation

struct ProfileValidator {

    static func validate(
        name: String,
        email: String,
        course: String
    ) -> String? {

        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Please enter your name."
        }

        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Please enter your email."
        }

        let emailPattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        if email.range(
            of: emailPattern,
            options: .regularExpression
        ) == nil {
            return "Please enter a valid email address."
        }

        if course.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Please enter your course."
        }

        return nil
    }
}