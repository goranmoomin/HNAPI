import Foundation

struct Endpoint {
    // MARK: - Properties

    var url: URL
}

// MARK: - Convenience Static Methods

extension Endpoint {
    static var base = URL(string: "https://hn.algolia.com/api/v1/")!

    static func algolia(ids: [Int]) -> Endpoint {
        var components = URLComponents()
        let tags = ids.map({ "story_\($0)" })
        components.path += "search"
        components.queryItems = [
            URLQueryItem(name: "tags", value: "(story,job,poll),(\(tags.joined(separator: ",")))")
        ]
        let url = components.url(relativeTo: base)!
        return Endpoint(url: url)
    }

    static func algolia(query: String) -> Endpoint {
        var components = URLComponents()
        components.path += "search"
        components.queryItems = [
            URLQueryItem(name: "tags", value: "(story,job,poll)"),
            URLQueryItem(name: "query", value: query),
        ]
        let url = components.url(relativeTo: base)!
        return Endpoint(url: url)
    }
}
