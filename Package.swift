// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Randomizable",
    products: [
        .library(
            name: "Randomizable",
            targets: ["Randomizable"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Randomizable",
            dependencies: []
        ),
        .testTarget(
            name: "RandomizableTests",
            dependencies: ["Randomizable"]
        ),
    ]
)
