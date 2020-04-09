import Foundation

class Job: Decodable {
    // MARK: - Error

    enum Error: Swift.Error { case decodingFailed }

    // MARK: - Properties

    var title: String
    var creation: Date
    var content: Content

    // MARK: - Decodable

    enum CodingKeys: String, CodingKey {
        case title
        case creation = "created_at_i"
        case url
        case text = "story_text"
    }

    required init(
        from decoder: Decoder
    ) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        creation = try container.decode(Date.self, forKey: .creation)
        if let url = try? container.decode(URL.self, forKey: .url) {
            content = .url(url)
        } else if let text = try? container.decode(String.self, forKey: .text) {
            content = .text(text)
        } else { throw Error.decodingFailed }
    }
}
