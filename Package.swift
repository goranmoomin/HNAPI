// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HNAPI", products: [.library(name: "HNAPI", targets: ["HNAPI"])], dependencies: [],
    targets: [
        .target(name: "HNAPI", dependencies: [], path: "Sources"),
        .testTarget(name: "HNAPITests", dependencies: ["HNAPI"], path: "Tests"),
    ])
