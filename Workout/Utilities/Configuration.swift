import Foundation

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

enum Config {    
    static var environment: String {
        return try! Configuration.value(for: "ENV_NAME")
    }
    
    static var isDevelopment: Bool {
        print("Environment: \(environment)")
        return environment == "DEV"
    }
} 