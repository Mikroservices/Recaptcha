import Foundation

public struct GoogleCaptchaConfig {
    public var secretKey: String
    
    public init(secretKey: String = "") {
        self.secretKey = secretKey
    }
}
