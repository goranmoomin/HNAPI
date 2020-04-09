import Foundation

enum Content: Equatable {
    case text(String)
    case url(URL)

    var text: String? {
        switch self {
        case let .text(text): return text
        case .url: return nil
        }
    }

    var url: URL? {
        switch self {
        case let .url(url): return url
        case .text: return nil
        }
    }
}
