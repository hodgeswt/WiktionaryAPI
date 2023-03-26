// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WiktionaryAPI",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "WiktionaryAPI",
            targets: ["WiktionaryAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/immobiliare/RealHTTP", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "WiktionaryAPI",
            dependencies: ["RealHTTP"])
    ]
)
