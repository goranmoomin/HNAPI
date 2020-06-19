import Foundation
import SwiftSoup

class StoryParser {
    // MARK: - Properties

    var document: Document

    lazy var aThingEls: Elements = try! document.select(".athing.comtr")
    lazy var ids: [Int] = aThingEls.compactMap { Int($0.id()) }

    // MARK: - Init

    init(html: String) throws { document = try Parser.parse(html, "https://news.ycombinator.com/") }

    // MARK: - Methods

    func aThingEl(id: Int) -> Element {
        // FIXME: Error handling
        return aThingEls.first(where: { $0.id() == "\(id)" })!
    }

    func commTextEl(id: Int) -> Element {
        let aThingEl = self.aThingEl(id: id)
        // FIXME: Error handling
        let commTextEl = try! aThingEl.select(".commtext").array()[0]
        return commTextEl
    }

    func commentColors() -> [Int: Comment.Color] {
        var commentColors: [Int: Comment.Color] = [:]
        for id in ids {
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

    func voteLinkEls(id: Int) -> [Element] {
        let aThingEl = self.aThingEl(id: id)
        let voteLinkEls = try! aThingEl.select(".votelinks a:has(.votearrow):not(.nosee)").array()
        return voteLinkEls
    }

    func actions() -> [Int: Set<Action>] {
        var actions: [Int: Set<Action>] = [:]
        let base = URL(string: "https://news.ycombinator.com")!
        // TODO: Add getting story action
        for id in ids {
            var actionSet: Set<Action> = []
            let voteLinkEls = self.voteLinkEls(id: id)
            for voteLinkEl in voteLinkEls {
                let href = try! voteLinkEl.attr("href")
                guard var components = URLComponents(string: href) else { continue }
                if components.queryItems?.contains(where: { $0.name == "auth" }) == false {
                    continue
                }
                components.queryItems?.removeAll(where: { $0.name == "goto" })
                guard let url = components.url(relativeTo: base) else { continue }
                // FIXME: Error handling
                let voteArrowEl = try! voteLinkEl.select(".votearrow").array()[0]
                let title = try! voteArrowEl.attr("title")
                switch title {
                case "upvote": actionSet.insert(.upvote(url))
                case "downvote": actionSet.insert(.downvote(url))
                default: break
                }
            }
            actions[id] = actionSet  // TODO: Add getting unvoting action
        }
        return actions
    }

    func sortedCommentTree(original: [Comment], colors: [Int: Comment.Color]? = nil) -> [Comment] {
        let colors = colors ?? self.commentColors()
        let sortedTree = original.sorted { left, right in
            guard let leftIndex = ids.firstIndex(of: left.id) else { return false }
            guard let rightIndex = ids.firstIndex(of: right.id) else { return true }
            return leftIndex < rightIndex
        }
        for comment in sortedTree {
            // TODO: Decide whether color should be given for ones that aren't found. cdd, perhaps.
            if let color = colors[comment.id] { comment.color = color }
            comment.children = sortedCommentTree(original: comment.children, colors: colors)
        }
        return sortedTree
    }
}
