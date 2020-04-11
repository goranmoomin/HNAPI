import Foundation

enum Action: Equatable, Hashable { case favorite(URL)
    case upvote(URL)
    case unvote(URL)
    case downvote(URL)
    case undown(URL)
    case flag(URL)

    var url: URL {
        switch self {
        case let .favorite(url): return url
        case let .upvote(url): return url
        case let .unvote(url): return url
        case let .downvote(url): return url
        case let .undown(url): return url
        case let .flag(url): return url
        }
    }
}
