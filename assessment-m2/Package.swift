// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Milestone2",
    products: [
        .library(name: "Milestone2", targets: ["Milestone2"]),
        .executable(name: "Milestone2Demo", targets: ["Milestone2Demo"])
    ],
    targets: [
        .target(name: "Milestone2"),
        .executableTarget(name: "Milestone2Demo", dependencies: ["Milestone2"]),
        .testTarget(name: "Milestone2Tests", dependencies: ["Milestone2"])
    ]
)
