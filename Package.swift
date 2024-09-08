// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MiniCrossword",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "MiniCrossword",
            targets: ["MiniCrossword"]),
    ],
    targets: [
        .target(
            name: "MiniCrossword",
            dependencies: []
        ),
        .testTarget(
            name: "MiniCrosswordTests",
            dependencies: ["MiniCrossword"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
