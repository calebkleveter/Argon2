// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Argon2",
    products: [
        .library(name: "Argon2", targets: ["Argon2"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "CArgon2", dependencies: [], path: "./Sources/phc-winner-argon2"),
        .target(name: "Argon2", dependencies: ["CArgon2"]),
        .testTarget(name: "Argon2Tests", dependencies: ["Argon2"]),
    ]
)
