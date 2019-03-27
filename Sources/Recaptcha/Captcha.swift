import Foundation
import Vapor

public protocol Captcha: Service {
    func validate(captchaFormResponse: String) throws -> Future<Bool>
}
