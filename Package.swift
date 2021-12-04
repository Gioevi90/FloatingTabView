// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FloatingTabView",
    platforms: [.macOS(.v11), .iOS(.v13)],
    products: [
        .library(
            name: "FloatingTabView",
            targets: ["FloatingTabView"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "FloatingTabView",
            dependencies: []),
        .testTarget(
            name: "FloatingTabViewTests",
            dependencies: ["FloatingTabView"]),
    ]
)
