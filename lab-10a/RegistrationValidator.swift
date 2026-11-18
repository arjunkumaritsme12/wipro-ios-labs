
import Foundation

struct RegistrationValidator {

    static func isValidName(_ name: String) -> Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    static func isValidEmail(_ email: String) -> Bool {
        let value = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let parts = value.split(separator: "@")

        return parts.count == 2 &&
        parts[1].contains(".") &&
        !value.contains(" ")
    }

    static func isValidPhone(_ phone: String) -> Bool {
        phone.filter { $0.isNumber }.count == 10
    }

    static func isValidForm(
        name: String,
        email: String,
        phone: String
    ) -> Bool {
        isValidName(name) &&
        isValidEmail(email) &&
        isValidPhone(phone)
    }
}
