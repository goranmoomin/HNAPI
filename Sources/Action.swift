import Foundation

public enum Action: Equatable, Hashable {
    case favorite(URL)
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
    var inverseSet: Set<Action> {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if components?.queryItems == nil { components?.queryItems = [] }
        components?.queryItems?.removeAll(where: { $0.name == "how" })
        components?.queryItems?.removeAll(where: { $0.name == "un" })
        switch self {
        case .favorite, .flag: components?.queryItems?.append(URLQueryItem(name: "un", value: "t"))
        case .upvote, .downvote:
            components?.queryItems?.append(URLQueryItem(name: "how", value: "un"))
        case .unvote, .undown, .unfavorite, .unflag: break
        }

        switch self {
        case .favorite:
            let url = components!.url!
            return [.unfavorite(url)]
        case .unfavorite:
            let url = components!.url!
            return [.favorite(url)]
        case .upvote:
            let url = components!.url!
            return [.unvote(url)]
        case .downvote:
            let url = components!.url!
            return [.undown(url)]
        case .unvote, .undown:
            // FIXME: Unvote's inverse might not include downvote
            var upvoteComponents = components
            upvoteComponents?.queryItems?.append(URLQueryItem(name: "how", value: "up"))
            var downvoteComponents = components
            downvoteComponents?.queryItems?.append(URLQueryItem(name: "how", value: "down"))
            let upvoteURL = upvoteComponents!.url!
            let downvoteURL = downvoteComponents!.url!
            return [.upvote(upvoteURL), .downvote(downvoteURL)]
        case .flag:
            let url = components!.url!
            return [.unflag(url)]
        case .unflag:
            let url = components!.url!
            return [.flag(url)]
        }
    }
}
