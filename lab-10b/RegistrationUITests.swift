
import XCTest

final class RegistrationUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testRegistrationFormSubmitsSuccessfully() {
        let app = XCUIApplication()
        app.launch()

        let nameField = app.textFields["registration.name"]
        let emailField = app.textFields["registration.email"]
        let phoneField = app.textFields["registration.phone"]

        XCTAssertTrue(nameField.waitForExistence(timeout: 5))
        nameField.tap()
        nameField.typeText("Arjun Kumar")

        emailField.tap()
        emailField.typeText("arjun@example.com")

        phoneField.tap()
        phoneField.typeText("9876543210")

        let doneButton = app.buttons["registration.keyboardDone"]
        if doneButton.waitForExistence(timeout: 2) {
            doneButton.tap()
        }

        let submitButton = app.buttons["registration.submit"]
        XCTAssertTrue(submitButton.exists)
        submitButton.tap()

        let successMessage = app.staticTexts["registration.success"]
        XCTAssertTrue(successMessage.waitForExistence(timeout: 5))
        XCTAssertEqual(successMessage.label, "Registration successful!")
    }

    func testEmptyFormDisplaysValidationError() {
        let app = XCUIApplication()
        app.launch()

        let submitButton = app.buttons["registration.submit"]
        XCTAssertTrue(submitButton.waitForExistence(timeout: 5))
        submitButton.tap()

        let errorMessage = app.staticTexts["registration.validationError"]
        XCTAssertTrue(errorMessage.waitForExistence(timeout: 5))
        XCTAssertTrue(errorMessage.label.contains("Please enter a valid name"))
    }
}
