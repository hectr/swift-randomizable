// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Randomizable",
    products: [
        .library(
            name: "Randomizable",
            targets: ["Randomizable"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hectr/swift-idioms.git", from: "1.7.0"),
    ],
    targets: [
        .target(
            name: "Randomizable",
            dependencies: ["Idioms"]),
        .testTarget(
            name: "RandomizableTests",
            dependencies: ["Randomizable"]),
    ]
)
