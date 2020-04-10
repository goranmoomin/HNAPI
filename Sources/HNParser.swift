import Foundation
import SwiftSoup

class HNParser {
    // MARK: - Properties

    var document: Document

    // MARK: - Init

    init(html: String) throws { document = try Parser.parse(html, "https://news.ycombinator.com/") }

    // MARK: - Methods

    func ids() -> [Int] {
        let aThingEls = try! document.select(".athing.comtr")
        let ids = aThingEls.compactMap { Int($0.id()) }
        return ids
    }

    func sortedCommentTree(original: [Comment]) -> [Comment] {
        let ids = self.ids()
        let sortedTree = original.sorted { left, right in
            guard let leftIndex = ids.firstIndex(of: left.id) else { return false }
            guard let rightIndex = ids.firstIndex(of: right.id) else { return true }
            return leftIndex < rightIndex
        }
        for comment in sortedTree {
            comment.children = sortedCommentTree(original: comment.children)
        }
        return sortedTree
    }
}
