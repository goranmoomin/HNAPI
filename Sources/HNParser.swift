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

    func commTextEl(id: Int) -> Element {
        // FIXME: Error handling
        let aThingEl = try! document.select(".athing.comtr#\(id)").array()[0]
        let commTextEl = try! aThingEl.select(".commtext").array()[0]
        return commTextEl
    }

    func commentColors() -> [Int: Comment.Color] {
        var commentColors: [Int: Comment.Color] = [:]
        for id in ids() {
            let commTextEl = self.commTextEl(id: id)
            for color in Comment.Color.allCases {
                if commTextEl.hasClass(color.rawValue) {
                    commentColors[id] = color
                    break
                }
            }
        }
        return commentColors
    }

    func sortedCommentTree(original: [Comment]) -> [Comment] {
        let ids = self.ids()
        let commentColors = self.commentColors()
        let sortedTree = original.sorted { left, right in
            guard let leftIndex = ids.firstIndex(of: left.id) else { return false }
            guard let rightIndex = ids.firstIndex(of: right.id) else { return true }
            return leftIndex < rightIndex
        }
        for comment in sortedTree {
            // TODO: Decide whether color should be given for ones that aren't found. cdd, perhaps.
            if let color = commentColors[comment.id] { comment.color = color }
            comment.children = sortedCommentTree(original: comment.children)
        }
        return sortedTree
    }
}
