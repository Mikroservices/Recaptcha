import Foundation

public struct GoogleCaptchaConfig {
    let secretKey: String
    
    public init(secretKey: String) {
        self.secretKey = secretKey
    }
}
