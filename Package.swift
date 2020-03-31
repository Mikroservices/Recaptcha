// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "Recaptcha",
    platforms: [
       .macOS(.v10_15)
    ],
    products: [
        .library(name: "Recaptcha", targets: ["Recaptcha"]),
        .library(name: "RecaptchaTests", targets: ["RecaptchaTests"])
    ],
    dependencies: [
        // 💧 A server-side Swift web framework. 
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "4.0.0-rc.3.12")),
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
