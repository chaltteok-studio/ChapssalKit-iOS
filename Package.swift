// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChapssalKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ChapssalKit",
            targets: ["ChapssalKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/wlsdms0122/Compose.git", .upToNextMajor(from: "1.2.1")),
        .package(url: "https://github.com/wlsdms0122/Validator.git", .upToNextMajor(from: "1.0.3")),
        .package(url: "https://github.com/wlsdms0122/JSToast.git", .upToNextMajor(from: "2.6.1")),
        .package(url: "https://github.com/airbnb/lottie-ios.git", .upToNextMajor(from: "4.1.2"))
    ],
    targets: [
        .target(
            name: "ChapssalKit",
            dependencies: [
                "Compose",
                "Validator",
                "JSToast",
                .product(
                    name: "Lottie",
                    package: "lottie-ios"
                )
            ],
            resources: [
                .process("Resource/Lottie")
            ]
        ),
        .testTarget(
            name: "ChapssalKitTests",
            dependencies: [
                "ChapssalKit"
            ]
        )
    ]
)
