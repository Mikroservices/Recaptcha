// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "Recaptcha",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(name: "Recaptcha", targets: ["Recaptcha"])
    ],
    dependencies: [
        // 💧 A server-side Swift web framework. 
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "4.0.1")),
    ],
    targets: [
        .target(name: "Recaptcha", dependencies: [
            .product(name: "Vapor", package: "vapor")
        ]),
        .testTarget(name: "RecaptchaTests", dependencies: [
            .product(name: "Vapor", package: "vapor"),
            .target(name: "Recaptcha")
        ])
    ]
)
