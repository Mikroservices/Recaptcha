import XCTest
import Vapor
@testable import Recaptcha

final class RecaptchaTests: XCTestCase {
    func testValidationWithoutSecretKeyShouldReturnTrue() throws {
        let application = Application()
        defer {
            application.shutdown()
        }
        
        let request = Request(application: application, on: application.eventLoopGroup.next())
        try request.validate(captchaFormResponse: "123").flatMapThrowing { result in
            XCTAssertTrue(result)
        }.wait()
    }

    static var allTests = [
        ("testValidationWithoutSecretKeyShouldReturnTrue", testValidationWithoutSecretKeyShouldReturnTrue),
    ]
}
