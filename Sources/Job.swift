import Foundation

public class Job: Decodable {
    // MARK: - Error

    enum Error: Swift.Error { case decodingFailed }

    // MARK: - Properties

    public var id: Int
    public var title: String
    public var creation: Date
    public var content: Content

    // MARK: - Decodable

    enum CodingKeys: String, CodingKey {
        case objectID
        case title
        case creation = "created_at_i"
        case url
        case text = "story_text"
    }

    required public init(
        from decoder: Decoder
    ) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let objectID = try container.decode(String.self, forKey: .objectID)
        guard let id = Int(objectID) else { throw Error.decodingFailed }
        self.id = id
        title = try container.decode(String.self, forKey: .title)
        creation = try container.decode(Date.self, forKey: .creation)
        if let url = try? container.decode(URL.self, forKey: .url) {
            content = .url(url)
        } else if let text = try? container.decode(String.self, forKey: .text) {
            content = .text(text)
        } else {
            // FIXME: Don't hardcode this string
            let url = URL(string: "https://news.ycombinator.com/item?id=\(id)")!
            content = .url(url)
        }
    }
}
