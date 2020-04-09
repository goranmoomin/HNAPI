import Foundation

extension Optional where Wrapped == Bool { func isTruthy() -> Bool { self ?? false } }
