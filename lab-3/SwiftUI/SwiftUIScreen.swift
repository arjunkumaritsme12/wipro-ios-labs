
import SwiftUI

struct SwiftUIScreen: View {

    @State private var name: String = ""
    @State private var result: String = ""

    var body: some View {
        VStack(spacing: 20) {

            Text("Welcome App")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Enter your name", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Button(action: {
                if name.isEmpty {
                    result = "Please enter your name!"
                } else {
                    result = "Hello, \(name)!"
                }
            }) {
                Text("Say Hello")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Text(result)
                .font(.headline)
                .foregroundColor(.green)
        }
        .padding()
    }
}
