
import SwiftUI

struct ContentView: View {

    private var bundleIdentifier: String {
        Bundle.main.bundleIdentifier ?? "Not Available"
    }

    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Not Set"
    }

    private var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Not Set"
    }

    private var appName: String {
        Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ??
        Bundle.main.infoDictionary?["CFBundleName"] as? String ??
        "Application"
    }

    private let auditItems: [(String, String)] = [
        ("Signing", "Verified in Xcode"),
        ("Deployment Target", "Verified in Xcode"),
        ("Supported Orientations", "Verified in Xcode"),
        ("Privacy Permissions", "No sensitive permissions required")
    ]

    var body: some View {

        NavigationStack {

            List {

                Section("Application Information") {

                    LabeledContent("App Name", value: appName)

                    LabeledContent(
                        "Bundle Identifier",
                        value: bundleIdentifier
                    )

                    LabeledContent("Version", value: appVersion)

                    LabeledContent("Build Number", value: buildNumber)
                }

                Section("Configuration Audit") {

                    ForEach(auditItems, id: \.0) { item in

                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.0)
                                    .font(.headline)

                                Text(item.1)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                        }
                        .padding(.vertical, 4)
                    }
                }

                Section("Privacy and Security") {

                    Label(
                        "No sensitive permission requested",
                        systemImage: "lock.shield.fill"
                    )
                    .foregroundStyle(.green)

                    Text("This application does not request camera, microphone, location or photo-library access.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                Section("Audit Summary") {

                    Text("The application configuration can be reviewed through the Xcode project settings. Bundle metadata is displayed directly from the running application.")
                        .font(.subheadline)
                }
            }
            .navigationTitle("Configuration Audit")
        }
    }
}

#Preview {
    ContentView()
}
