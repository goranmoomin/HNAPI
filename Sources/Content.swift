import Foundation

public enum Content: Equatable {
    case text(String)
    case url(URL)

    public var text: String? {
        switch self {
        case let .text(text): return text
        case .url: return nil
        }
    }

    public var url: URL? {
        switch self {
        case let .url(url): return url
        case .text: return nil
        }
    }
}
