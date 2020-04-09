import Foundation

extension Result {

    var failure: Failure? {
        switch self {
        case let .failure(failure): return failure
        case .success: return nil
        }
    }
}
