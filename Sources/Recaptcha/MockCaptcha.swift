import Foundation
import Vapor

public struct MockCaptcha: Captcha {

    private let container: Container

    public init(container: Container) {
        self.container = container
    }

    public func validate(captchaFormResponse: String) throws -> EventLoopFuture<Bool> {
        return self.container.eventLoop.newSucceededFuture(result: true)
    }
}
