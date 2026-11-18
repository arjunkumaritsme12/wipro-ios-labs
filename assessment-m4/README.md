
# Milestone 4: SwiftUI and Configuration

## Objective
Build a SwiftUI application demonstrating navigation, shared state,
favourites, form validation and app configuration concepts.

## R1: List-Detail Navigation
- Implemented NavigationStack.
- Used NavigationLink to open course details.
- Passed the selected Course model to CourseDetailView.

## R2: Shared State and Favourites
- Created an observable CourseStore.
- Used @Environment to access shared state.
- Added and removed favourite courses.
- Synchronized Home, Detail and Favourites screens.
- Persisted favourite IDs using UserDefaults.

## R3: Validated Registration Form
- Created an event registration form.
- Added name, email, phone, event picker and toggle.
- Validated required fields.
- Added inline error messages.
- Implemented loading indicator and success confirmation.

Note: Submission is simulated locally. No backend service is connected.

## R4: App Configuration

- App entry point: CourseExplorerApp.swift
- Root scene: WindowGroup
- Bundle identifier: Configured in Xcode
- Deployment target: iOS 17.0 or later
- Privacy: No sensitive permissions requested.
- Info properties: Reviewed in Xcode.

## R5: State and Architecture
- @State: Owns local view state.
- @Binding: Provides access to parent-owned state.
- @Observable: Makes shared model changes observable.
- @Environment: Shares the model across screens.
- App: Defines application structure and lifecycle.
- View: Defines individual interface components.

## Technologies
- Swift
- SwiftUI
- Observation
- NavigationStack
- UserDefaults
- Form and Section

## Project Structure
- CourseExplorerApp.swift
- ContentView.swift
- README.md

## Screenshots
1. Course list.
2. Course detail.
3. Favourites screen.
4. Registration form.
5. Validation error.
6. Loading state.
7. Success confirmation.

## Security
No certificates, private keys, passwords or API secrets
are included in this project.
