// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Argon2",
    products: [
        .library(name: "Argon2", targets: ["Argon2"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Argon2", dependencies: []),
        .testTarget(name: "Argon2Tests", dependencies: ["Argon2"]),
    ]
)