import Foundation

class Comment: Decodable {
    // MARK: - Properties

    var id: Int
    var creation: Date
    var author: String
    var text: String
    var children: [Comment]

    // MARK: - Decodable

    enum CodingKeys: String, CodingKey {
        case id
        case creation = "created_at_i"
        case author
        case text
        case children
    }

    required init(
        from decoder: Decoder
    ) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        creation = try container.decode(Date.self, forKey: .creation)
        text = try container.decode(String.self, forKey: .text)
        author = try container.decode(String.self, forKey: .author)
        children = try container.decode([Comment].self, forKey: .children)
    }
}
