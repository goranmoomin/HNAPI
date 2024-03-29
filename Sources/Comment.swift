import Foundation
import SwiftSoup

public class Comment: Decodable {
    public enum Color: String, CaseIterable {
        case c00
        case c5a
        case c73
        case c82
        case c88
        case c9c
        case cae
        case cbe
        case cce
        case cdd
    }

    // MARK: - Properties

    public var id: Int
    public var creation: Date
    public var author: String
    public var text: String
    var isDeleted: Bool
    public var color: Color = .c00
    public var children: [Comment]
    public var commentCount: Int { children.reduce(1, { $0 + $1.commentCount }) }

    // MARK: - Decodable

    enum CodingKeys: String, CodingKey {
        case id
        case creation = "created_at_i"
        case author
        case text
        case children
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        creation = try container.decode(Date.self, forKey: .creation)
        do {
            text = try container.decode(String.self, forKey: .text)
            author = try container.decode(String.self, forKey: .author)
            isDeleted = false
        } catch {
            text = ""
            author = ""
            isDeleted = true
        }
        children = try container.decode([Comment].self, forKey: .children).filter { !$0.isDeleted }
    }
}
