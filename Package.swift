// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "swift-crash",
    products: [
        .library(name: "swift-crash", targets: ["swift-crash"]),
    ],
    targets: [
        .target(name: "swift-crash",
                swiftSettings: [
                    .unsafeFlags(["-enable-testing"])
                ]),
        .testTarget(name: "swift-crashTests", dependencies: ["swift-crash"]),
    ]
)
