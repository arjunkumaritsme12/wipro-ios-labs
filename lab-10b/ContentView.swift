
import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var showValidationError = false
    @State private var showSuccess = false
    @FocusState private var isFieldFocused: Bool

    private var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        email.contains("@") &&
        email.contains(".") &&
        phone.filter(\.isNumber).count == 10
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 18) {
                Text("Event Registration")
                    .font(.largeTitle)
                    .bold()
                    .accessibilityIdentifier("registration.title")

                TextField("Enter your name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.name)
                    .accessibilityIdentifier("registration.name")

                TextField("Enter your email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .accessibilityIdentifier("registration.email")

                TextField("Enter 10-digit phone number", text: $phone)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .accessibilityIdentifier("registration.phone")

                if showValidationError {
                    Text("Please enter a valid name, email and 10-digit phone number.")
                        .foregroundStyle(.red)
                        .font(.subheadline)
                        .accessibilityIdentifier("registration.validationError")
                }

                if showSuccess {
                    Text("Registration successful!")
                        .font(.headline)
                        .foregroundStyle(.green)
                        .accessibilityIdentifier("registration.success")
                }

                Button("Submit Registration") {
                    isFieldFocused = false
                    showValidationError = false

                    if isFormValid {
                        showSuccess = true
                    } else {
                        showSuccess = false
                        showValidationError = true
                    }
                }
                .buttonStyle(.borderedProminent)
                .accessibilityIdentifier("registration.submit")

                Spacer()
            }
            .padding()
            .navigationTitle("Register")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFieldFocused = false
                    }
                    .accessibilityIdentifier("registration.keyboardDone")
                }
            }
        }
    }
}
