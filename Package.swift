// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Randomizable",
    products: [
        .library(
            name: "Randomizable",
            targets: ["Randomizable"]
        ),
        .library(
            name: "CodableUpdating",
            targets: ["CodableUpdating"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/refined-swift/Wrapper.git", .branch("master")),
        .package(url: "https://github.com/hectr/swift-idioms.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "Randomizable",
            dependencies: []
        ),
        .target(
            name: "CodableUpdating",
            dependencies: ["Wrapper", "Randomizable", "Idioms"]
        ),
        .testTarget(
            name: "RandomizableTests",
            dependencies: ["Randomizable"]
        ),
        .testTarget(
            name: "CodableUpdatingTests",
            dependencies: ["CodableUpdating"]),
    ]
)
