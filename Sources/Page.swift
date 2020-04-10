import Foundation

class Page {
    // MARK: - Properties

    var topLevelItem: TopLevelItem
    var children: [Comment]

    // MARK: - Init

    init(
        item: TopLevelItem, children: [Comment]
    ) {
        topLevelItem = item
        self.children = children
    }
}
