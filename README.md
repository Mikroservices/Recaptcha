# Recaptcha

![Build Status](https://github.com/Mikroservices/Recaptcha/workflows/Build/badge.svg)
[![Swift 5.2](https://img.shields.io/badge/Swift-5.2-orange.svg?style=flat)](ttps://developer.apple.com/swift/)
[![Vapor 4](https://img.shields.io/badge/vapor-4.0-blue.svg?style=flat)](https://vapor.codes)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://swift.org/package-manager/)
[![Platforms OS X | Linux](https://img.shields.io/badge/Platforms-OS%20X%20%7C%20Linux%20-lightgray.svg?style=flat)](https://developer.apple.com/swift/)


Library is prepared for support Google Recaptcha service to Vapor applications. First you need to obtain a secret key from: [https://www.google.com/recaptcha/admin](https://www.google.com/recaptcha/admin).

Most part of the code was originally created here: [gotranseo/vapor-recaptcha](https://github.com/gotranseo/vapor-recaptcha).

## Getting started

You need to add library to `Package.swift` file:

 - add package to dependencies:
```swift
.package(url: "https://github.com/Mikroservices/Recaptcha.git", from: "2.0.0")
```

- and add product to your target:
```swift
.target(name: "App", dependencies: [
    .product(name: "Vapor", package: "vapor"),
    .product(name: "Recaptcha", package: "Recaptcha")
])
```

Set the Recaptcha configuration (e.g. in `main.swift` file).

```swift
import App
import Vapor
import Recaptcha

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)

let app = Application(env)
defer { app.shutdown() }

// Recaptcha.
app.captcha.configuration.secretKey = "SecretKey"

try configure(app)
try app.run()

```

Using Recaptcha client in your controller.

```swift
app.get("recaptcha") { req -> EventLoopFuture<String> in
    let captchaToken = try req.query.get(String.self, at: "captchaToken")

    let validationFuture = req.validate(captchaFormResponse: captchaToken)
    return validationFuture.map { result -> String in
        return result ? "Recaptcha ok" : "Recaptcha failed"
    }
}
```

## Developing

Download the source code and run in command line:

```bash
$ git clone https://github.com/Mikroservices/Recaptcha.git
$ swift package update
$ swift build
```
Run the following command if you want to open project in Xcode:

```bash
$ open Package.swift
```

## Contributing

You can fork and clone repository. Do your changes and pull a request.
