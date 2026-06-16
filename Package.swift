// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MarkdownDisplayView",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "MarkdownDisplayView",
            targets: ["MarkdownDisplayView"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-markdown.git", from: "0.8.0"),
    ],
    targets: [
        .target(
            name: "MarkdownDisplayView",
            dependencies: [
                .product(name: "Markdown", package: "swift-markdown")
            ],
            path: "./MarkdownDisplayView/Sources",
            resources: [
                .process("Resources")
            ],
//            swiftSettings: [
//                .define("ENABLE_LOGGING"),
//            ]
        ),
        .testTarget(
            name: "MarkdownDisplayViewTests",
            dependencies: ["MarkdownDisplayView"],
            path: "./MarkdownDisplayView/Tests"
        ),
    ]
)
