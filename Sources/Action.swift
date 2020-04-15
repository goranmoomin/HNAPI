import Foundation

public enum Action: Equatable, Hashable { case favorite(URL)
    case unfavorite(URL)
    case upvote(URL)
    case unvote(URL)
    case downvote(URL)
    case undown(URL)
    case flag(URL)
    case unflag(URL)

    var url: URL {
        switch self {
        case let .favorite(url): return url
        case let .unfavorite(url): return url
        case let .upvote(url): return url
        case let .unvote(url): return url
        case let .downvote(url): return url
        case let .undown(url): return url
        case let .flag(url): return url
        case let .unflag(url): return url
        }
    }
}

extension Action {
    var inverse: Action {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if components?.queryItems == nil { components?.queryItems = [] }
        components?.queryItems?.removeAll(where: { $0.name == "how" })
        components?.queryItems?.removeAll(where: { $0.name == "un" })
        switch self {
        case .favorite, .flag: components?.queryItems?.append(URLQueryItem(name: "un", value: "t"))
        case .upvote, .downvote:
            components?.queryItems?.append(URLQueryItem(name: "how", value: "un"))
        case .unvote: components?.queryItems?.append(URLQueryItem(name: "how", value: "up"))
        case .undown: components?.queryItems?.append(URLQueryItem(name: "how", value: "down"))
        case .unfavorite, .unflag: break
        }
        let url = components!.url!
        switch self {
        case .favorite: return .unfavorite(url)
        case .unfavorite: return .favorite(url)
        case .upvote: return .unvote(url)
        case .unvote: return .upvote(url)
        case .downvote: return .undown(url)
        case .undown: return .downvote(url)
        case .flag: return .unflag(url)
        case .unflag: return .flag(url)
        }
    }
}
