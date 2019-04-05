# Recaptcha

[![Build Status](https://travis-ci.org/Mikroservices/Recaptcha.svg?branch=master)](https://travis-ci.org/Mikroservices/Recaptcha) [![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat)](ttps://developer.apple.com/swift/) [![Platforms OS X | Linux](https://img.shields.io/badge/Platforms-OS%20X%20%7C%20Linux%20-lightgray.svg?style=flat)](https://developer.apple.com/swift/)

Library is prepared for support Google Recaptcha service to Vapor applications. First you need to obtain a secret key from: https://www.google.com/recaptcha/admin.

Most part of the code was originally created here: [gotranseo/vapor-recaptcha](https://github.com/gotranseo/vapor-recaptcha).

## Installation

Library is available through Swift Package Manager. To install it, simply add the following to your `Package.swift` file:

```swift
.package(url: "https://github.com/Mikroservices/Recaptcha.git", from: "1.0.1")
```

## Usage

### Registering

In `configure.swift`, add this line:

```swift
let captchaConfig = GoogleCaptchaConfig(secretKey: "SECRET-KEY")
try services.register(GoogleCaptchaProvider(config: captchaConfig))
```

Also you can inject "mock" service. 

```swift
try services.register(MockCaptchaProvider())
```

This is especially helpful when you would like to disable verifying captcha (e.g. during development).

```swift
// Register reCaptcha.
guard let recaptchaIsEnabled = Environment.get("LETTERER_RECAPTCHA_ENABLED") else { throw Abort(.internalServerError) }
if recaptchaIsEnabled == "1" {
    guard let recaptchaKey = Environment.get("LETTERER_RECAPTCHA_KEY") else { throw Abort(.internalServerError) }

    let captchaConfig = GoogleCaptchaConfig(secretKey: recaptchaKey)
    try services.register(GoogleCaptchaProvider(config: captchaConfig))
} else {
    try services.register(MockCaptchaProvider())
}
```

### Usage
In your controller, you can do something like this:

```swift
let captchaToken = ... // value from web application
let googleCaptcha = try req.make(GoogleCaptcha.self)
return googleCaptcha.validate(captchaFormResponse: captchaToken).flatMap { success in 
    if success {
        // good :)
    } else {
        // :(
    }
}
```

