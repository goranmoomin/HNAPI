import Foundation

typealias Token = HTTPCookie

extension URLRequest {
    mutating func add(_ token: Token) {
        for (field, value) in HTTPCookie.requestHeaderFields(with: [token]) {
            addValue(value, forHTTPHeaderField: field)
        }
    }
}
