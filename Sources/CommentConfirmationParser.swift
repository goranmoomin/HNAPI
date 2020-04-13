import Foundation
import SwiftSoup

class CommentConfirmationParser {
    // MARK: - Properties

    var document: Document

    // MARK: - Init

    init(html: String) throws { document = try Parser.parse(html, "https://news.ycombinator.com/") }

    // MARK: - Methods

    func hmac() -> String? {
        let hmacEl = try! document.select("input[name=hmac]").array()[0]
        let hmac = try? hmacEl.val()
        return hmac
    }
}
