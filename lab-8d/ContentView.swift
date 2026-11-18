
import SwiftUI

struct ContentView: View {

    @State private var fullName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var selectedEvent = "iOS Development Workshop"
    @State private var receiveUpdates = true

    @State private var showReview = false
    @State private var showSuccess = false
    @State private var validationMessage = ""

    private let events = [
        "iOS Development Workshop",
        "SwiftUI Bootcamp",
        "AI and Machine Learning",
        "Web Development Seminar"
    ]

    private var isFormValid: Bool {
        !fullName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        isValidEmail &&
        phone.filter { $0.isNumber }.count == 10
    }

    private var isValidEmail: Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let parts = trimmedEmail.split(separator: "@")

        return parts.count == 2 &&
        parts[1].contains(".") &&
        !trimmedEmail.contains(" ")
    }

    var body: some View {

        NavigationStack {

            Form {

                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Event Registration")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("Fill in your details to reserve your event seat.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                Section("Personal Information") {

                    TextField("Full Name", text: $fullName)
                        .textContentType(.name)
                        .textInputAutocapitalization(.words)

                    TextField("Email Address", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()

                    TextField("Phone Number", text: $phone)
                        .keyboardType(.phonePad)
                }

                Section("Event Details") {

                    Picker("Select Event", selection: $selectedEvent) {
                        ForEach(events, id: \.self) { event in
                            Text(event).tag(event)
                        }
                    }

                    Toggle("Receive event updates", isOn: $receiveUpdates)
                }

                Section {

                    if !validationMessage.isEmpty {
                        Text(validationMessage)
                            .font(.footnote)
                            .foregroundStyle(.red)
                    }

                    Button {
                        if isFormValid {
                            validationMessage = ""
                            showReview = true
                        } else {
                            validationMessage = "Please enter a valid name, email address and 10-digit phone number."
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Review Registration")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    .disabled(!isFormValid)
                } footer: {
                    Text("All personal information fields are required.")
                }
            }
            .navigationTitle("Register")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showReview) {
                reviewScreen
            }
            .alert("Registration Successful!", isPresented: $showSuccess) {
                Button("OK", role: .cancel) {
                    resetForm()
                }
            } message: {
                Text("Your registration has been submitted successfully.")
            }
        }
    }

    private var reviewScreen: some View {

        Form {

            Section("Review Your Information") {
                LabeledContent("Name", value: fullName)
                LabeledContent("Email", value: email)
                LabeledContent("Phone", value: phone)
            }

            Section("Event Selection") {
                LabeledContent("Event", value: selectedEvent)
                LabeledContent(
                    "Email Updates",
                    value: receiveUpdates ? "Enabled" : "Disabled"
                )
            }

            Section {

                Button {
                    showReview = false
                    showSuccess = true
                } label: {
                    HStack {
                        Spacer()
                        Text("Confirm Registration")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }

                Button("Go Back and Edit", role: .cancel) {
                    showReview = false
                }
            }
        }
        .navigationTitle("Review")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func resetForm() {
        fullName = ""
        email = ""
        phone = ""
        selectedEvent = events[0]
        receiveUpdates = true
        validationMessage = ""
    }
}

#Preview {
    ContentView()
}
