
import SwiftUI
import Observation

struct Course: Identifiable, Hashable {
    let id: Int
    let title: String
    let subtitle: String
    let category: String
    let duration: String
    let description: String
}

@MainActor
@Observable
final class CourseStore {

    let courses: [Course] = [
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
            description: "Learn SwiftUI views, layouts, state management, reusable components and navigation."
        ),
        Course(
            id: 3,
            title: "Python Programming",
            subtitle: "Start learning Python",
            category: "Programming",
            duration: "5 Weeks",
            description: "Learn Python syntax, data structures, functions and practical programming."
        ),
        Course(
            id: 4,
            title: "Machine Learning",
            subtitle: "Explore intelligent systems",
            category: "Artificial Intelligence",
            duration: "8 Weeks",
            description: "Understand supervised learning, unsupervised learning and model evaluation."
        ),
        Course(
            id: 5,
            title: "Web Development",
            subtitle: "Create websites and web apps",
            category: "Development",
            duration: "6 Weeks",
            description: "Learn HTML, CSS and JavaScript to build responsive websites."
        )
    ]

    private(set) var favoriteIDs: Set<Int> = []

    init() {
        let savedIDs = UserDefaults.standard.array(
            forKey: "favoriteCourseIDs"
        ) as? [Int] ?? []

        favoriteIDs = Set(savedIDs)
    }

    func isFavorite(_ course: Course) -> Bool {
        favoriteIDs.contains(course.id)
    }

    func toggleFavorite(_ course: Course) {
        if favoriteIDs.contains(course.id) {
            favoriteIDs.remove(course.id)
        } else {
            favoriteIDs.insert(course.id)
        }

        UserDefaults.standard.set(
            Array(favoriteIDs),
            forKey: "favoriteCourseIDs"
        )
    }

    var favoriteCourses: [Course] {
        courses.filter {
            favoriteIDs.contains($0.id)
        }
    }
}

struct ContentView: View {

    var body: some View {

        TabView {
            HomeView()
                .tabItem {
                    Label("Courses", systemImage: "book")
                }

            FavoritesView()
                .tabItem {
                    Label("Favourites", systemImage: "heart.fill")
                }

            RegistrationView()
                .tabItem {
                    Label("Register", systemImage: "person.crop.rectangle")
                }
        }
    }
}

struct HomeView: View {

    @Environment(CourseStore.self) private var store
    @State private var searchText = ""

    private var filteredCourses: [Course] {
        if searchText.isEmpty {
            return store.courses
        }

        return store.courses.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.category.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {

        NavigationStack {

            List(filteredCourses) { course in

                HStack(spacing: 12) {

                    NavigationLink(value: course) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(course.title)
                                .font(.headline)

                            Text(course.subtitle)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)

                            Text(course.category)
                                .font(.caption)
                                .foregroundStyle(.blue)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)

                    Button {
                        store.toggleFavorite(course)
                    } label: {
                        Image(
                            systemName: store.isFavorite(course)
                                ? "heart.fill"
                                : "heart"
                        )
                        .font(.title2)
                        .foregroundStyle(.red)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(
                        store.isFavorite(course)
                            ? "Remove favourite"
                            : "Add favourite"
                    )
                }
                .padding(.vertical, 6)
            }
            .searchable(text: $searchText)
            .navigationTitle("Course Explorer")
            .navigationDestination(for: Course.self) { course in
                CourseDetailView(course: course)
            }
        }
    }
}

struct CourseDetailView: View {

    let course: Course

    @Environment(CourseStore.self) private var store

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 18) {

                Image(systemName: "book.closed.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 35)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                Text(course.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(course.category)
                    .foregroundStyle(.blue)

                Divider()

                Text("Course Overview")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(course.description)
                    .foregroundStyle(.secondary)

                Label(
                    "Duration: \(course.duration)",
                    systemImage: "clock"
                )

                Button {
                    store.toggleFavorite(course)
                } label: {
                    Label(
                        store.isFavorite(course)
                            ? "Remove from Favourites"
                            : "Add to Favourites",
                        systemImage: store.isFavorite(course)
                            ? "heart.fill"
                            : "heart"
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
            }
            .padding()
        }
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FavoritesView: View {

    @Environment(CourseStore.self) private var store

    var body: some View {

        NavigationStack {

            List {

                if store.favoriteCourses.isEmpty {
                    ContentUnavailableView(
                        "No Favourites",
                        systemImage: "heart",
                        description: Text(
                            "Add courses to your favourites to see them here."
                        )
                    )
                } else {
                    ForEach(store.favoriteCourses) { course in

                        HStack {

                            NavigationLink(value: course) {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(course.title)
                                        .font(.headline)

                                    Text(course.category)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }

                            Button {
                                store.toggleFavorite(course)
                            } label: {
                                Image(systemName: "heart.fill")
                                    .foregroundStyle(.red)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Remove favourite")
                        }
                    }
                }
            }
            .navigationTitle("My Favourites")
            .navigationDestination(for: Course.self) { course in
                CourseDetailView(course: course)
            }
        }
    }
}

struct RegistrationView: View {

    @State private var fullName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var selectedEvent = "SwiftUI Workshop"
    @State private var receiveUpdates = true

    @State private var isLoading = false
    @State private var errorMessage = ""
    @State private var showSuccess = false

    private let events = [
        "SwiftUI Workshop",
        "iOS Development Bootcamp",
        "AI and Machine Learning",
        "Web Development Seminar"
    ]

    private var isValidEmail: Bool {
        let value = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let parts = value.split(separator: "@")

        return parts.count == 2 &&
        parts[1].contains(".") &&
        !value.contains(" ")
    }

    private var isValidPhone: Bool {
        phone.filter { $0.isNumber }.count == 10
    }

    private var isFormValid: Bool {
        !fullName.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty &&
        isValidEmail &&
        isValidPhone
    }

    var body: some View {

        NavigationStack {

            Form {

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
                            Text(event)
                        }
                    }

                    Toggle(
                        "Receive Event Updates",
                        isOn: $receiveUpdates
                    )
                }

                Section {

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .font(.footnote)
                    }

                    Button {
                        submitRegistration()
                    } label: {
                        HStack {
                            Spacer()

                            if isLoading {
                                ProgressView()
                                    .padding(.trailing, 6)
                                Text("Submitting...")
                            } else {
                                Text("Submit Registration")
                                    .fontWeight(.semibold)
                            }

                            Spacer()
                        }
                    }
                    .disabled(isLoading)
                } footer: {
                    Text("Enter a valid name, email and 10-digit phone number.")
                }
            }
            .navigationTitle("Event Registration")
            .alert(
                "Registration Successful",
                isPresented: $showSuccess
            ) {
                Button("OK", role: .cancel) {
                    resetForm()
                }
            } message: {
                Text("Your registration has been completed successfully.")
            }
        }
    }

    private func submitRegistration() {

        errorMessage = ""

        guard !fullName.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty else {
            errorMessage = "Please enter your full name."
            return
        }

        guard isValidEmail else {
            errorMessage = "Please enter a valid email address."
            return
        }

        guard isValidPhone else {
            errorMessage = "Please enter a valid 10-digit phone number."
            return
        }

        isLoading = true

        Task {
            try? await Task.sleep(for: .seconds(2))

            isLoading = false
            showSuccess = true
        }
    }

    private func resetForm() {
        fullName = ""
        email = ""
        phone = ""
        selectedEvent = events[0]
        receiveUpdates = true
        errorMessage = ""
    }
}

#Preview {
    ContentView()
        .environment(CourseStore())
}
