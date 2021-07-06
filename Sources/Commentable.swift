import Foundation

public protocol Commentable { var id: Int { get } }

extension TopLevelItem: Commentable {}
extension Comment: Commentable {}
extension Story: Commentable {}
