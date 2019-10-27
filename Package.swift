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
    ],
    targets: [
        .target(
            name: "Randomizable",
            dependencies: []
        ),
        .target(
            name: "CodableUpdating",
            dependencies: ["Randomizable"]
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
