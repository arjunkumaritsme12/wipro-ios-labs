// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ExpenseMateCore",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(name: "ExpenseMateCore", targets: ["ExpenseMateCore"])
    ],
    targets: [
        .target(name: "ExpenseMateCore"),
        .testTarget(name: "ExpenseMateCoreTests", dependencies: ["ExpenseMateCore"])
    ]
)
