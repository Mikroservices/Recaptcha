import XCTest
@testable import Recaptcha

final class RecaptchaTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Recaptcha().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
