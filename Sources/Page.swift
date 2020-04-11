import Foundation

class Page {
    // MARK: - Properties

    var topLevelItem: TopLevelItem
    var children: [Comment]
    var actions: [Int: Set<Action>]

    // MARK: - Init

    init(
        item: TopLevelItem, children: [Comment], actions: [Int: Set<Action>]
    ) {
        topLevelItem = item
        self.children = children
        self.actions = actions
    }
}
