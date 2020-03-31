import Vapor

extension Application {
    public var captcha: Captcha {
        .init(application: self)
    }

    public struct Captcha {
        let application: Application

        struct ConfigurationKey: StorageKey {
            typealias Value = GoogleCaptchaConfig
        }

        public var configuration: GoogleCaptchaConfig {
            get {
                self.application.storage[ConfigurationKey.self] ?? .init()
            }
            nonmutating set {
                self.application.storage[ConfigurationKey.self] = newValue
            }
        }
    }
}
