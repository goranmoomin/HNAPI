// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HNAPI", platforms: [.macOS(.v12), .iOS(.v15)],
    products: [.library(name: "HNAPI", targets: ["HNAPI"])],
    dependencies: [.package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.0.0")],
    targets: [.target(name: "HNAPI", dependencies: ["SwiftSoup"], path: "Sources")])
