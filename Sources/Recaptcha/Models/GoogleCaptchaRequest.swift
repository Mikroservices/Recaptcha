import Foundation
import Vapor

struct GoogleCaptchaRequest: Content {
    var secret: String
    var response: String
}
