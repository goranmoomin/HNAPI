import Foundation

typealias Endpoint = URLRequest

// MARK: - Convenience Static Methods

extension Endpoint {
    static var algoliaBase = URL(string: "https://hn.algolia.com/api/v1/")!
    static var firebaseBase = URL(string: "https://hacker-news.firebaseio.com/v0/")!
    static var hnBase = URL(string: "https://news.ycombinator.com/")!

    init(url: URL, token: Token) {
        var endpoint = Endpoint(url: url)
        endpoint.add(token)
        self = endpoint
    }

    static func algolia(id: Int) -> Endpoint {
        var components = URLComponents()
        components.path += "items/\(id)"
        let url = components.url(relativeTo: algoliaBase)!
        return Endpoint(url: url)
    }

    static func algolia(ids: [Int]) -> Endpoint {
        var components = URLComponents()
        let tags = ids.map({ "story_\($0)" })
        components.path += "search"
        components.queryItems = [
            URLQueryItem(name: "tags", value: "(story,job,poll),(\(tags.joined(separator: ",")))"),
            URLQueryItem(name: "hitsPerPage", value: "\(ids.count)"),
        ]
        let url = components.url(relativeTo: algoliaBase)!
        return Endpoint(url: url)
    }

    static func algolia(query: String) -> Endpoint {
        var components = URLComponents()
        components.path += "search"
        components.queryItems = [
            URLQueryItem(name: "tags", value: "(story,job,poll)"),
            URLQueryItem(name: "query", value: query),
        ]
        let url = components.url(relativeTo: algoliaBase)!
        return Endpoint(url: url)
    }

    static func firebase(category: Category) -> Endpoint {
        let url = firebaseBase.appendingPathComponent("\(category.rawValue).json")
        return Endpoint(url: url)
    }

    static func hn(id: Int, token: Token? = nil) -> Endpoint {
        var components = URLComponents()
        components.path += "item"
        components.queryItems = [URLQueryItem(name: "id", value: "\(id)")]
        let url = components.url(relativeTo: hnBase)!
        var endpoint = Endpoint(url: url)
        if let token = token { endpoint.add(token) }
        return endpoint
    }

    static func hn(userName: String, password: String) -> Endpoint {
        var components = URLComponents()
        components.path += "login"
        components.queryItems = [
            URLQueryItem(name: "acct", value: userName), URLQueryItem(name: "pw", value: password),
        ]
        let url = components.url(relativeTo: hnBase)!
        return Endpoint(url: url)
    }

    static func hn(
        replyToID id: Int, token: Token, hmac: String? = nil, text: String? = nil
    ) -> Endpoint {
        var components = URLComponents()
        components.path += "comment"
        components.queryItems = [URLQueryItem(name: "parent", value: "\(id)")]
        if let hmac = hmac {
            components.queryItems?.append(URLQueryItem(name: "hmac", value: hmac))
        }
        if let text = text {
            components.queryItems?.append(URLQueryItem(name: "text", value: text))
        }
        let url = components.url(relativeTo: hnBase)!
        var endpoint = Endpoint(url: url)
        endpoint.add(token)
        return endpoint
    }
}
