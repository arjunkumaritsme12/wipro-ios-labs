import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Preferences") {
                    HStack {
                        Label("Currency", systemImage: "indianrupeesign")
                        Spacer()
                        Text("INR (₹)").foregroundStyle(.secondary)
                    }
                    HStack {
                        Label("Storage", systemImage: "internaldrive")
                        Spacer()
                        Text("On this device").foregroundStyle(.secondary)
                    }
                }
                Section("About") {
                    LabeledContent("App", value: "ExpenseMate")
                    LabeledContent("Version", value: "1.0.0")
                    Text("ExpenseMate helps you record and understand everyday spending. Your expense data is stored locally on this device.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Settings")
        }
    }
}
