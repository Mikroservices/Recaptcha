import Foundation
import Vapor

public extension Request {
    
    /// Validating Google captcha.
    ///
    /// - parameters:
    ///     - captchaFormResponse: Captcha token to validate.
    /// - returns: An `EventLoopFuture<Bool>` with information about captcha validation result.
    func validate(captchaFormResponse: String) -> EventLoopFuture<Bool> {
        
        let configuration = self.application.captcha.configuration
        if configuration.secretKey == "" {
            return self.eventLoop.makeSucceededFuture(true)
        }
        
        let requestData = GoogleCaptchaRequest(secret: configuration.secretKey, response: captchaFormResponse)
        let endpoint = URI(string: "https://www.google.com/recaptcha/api/siteverify")
        
        let googleRequest = self.application.client.post(endpoint) { req in
            try req.content.encode(requestData, as: .urlEncodedForm)
        }
        
        let emailSentPromise: EventLoopPromise<Bool> = self.eventLoop.makePromise()
        _ = googleRequest.map { clientResponse in
            do {
                let response = try clientResponse.content.decode(GoogleCaptchaResponse.self)
                emailSentPromise.succeed(response.success ?? false)
            } catch {
                emailSentPromise.succeed(false)
            }
        }
        
        return emailSentPromise.futureResult
    }
    
    /// Validating Google captcha.
    ///
    /// - parameters:
    ///     - captchaFormResponse: Captcha token to validate.
    /// - returns: An `EventLoopFuture<Bool>` with information about captcha validation result.
    func validate(captchaFormResponse: String) async throws -> Bool {
        
        let configuration = self.application.captcha.configuration
        if configuration.secretKey == "" {
            return true
        }
        
        let requestData = GoogleCaptchaRequest(secret: configuration.secretKey, response: captchaFormResponse)
        let endpoint = URI(string: "https://www.google.com/recaptcha/api/siteverify")
        
        let clientResponse = try await self.application.client.post(endpoint, beforeSend: { request in
            try request.content.encode(requestData, as: .urlEncodedForm)
        })

        do {
            let response = try clientResponse.content.decode(GoogleCaptchaResponse.self)
            return response.success ?? false
        } catch {
            return false
        }
    }
}
