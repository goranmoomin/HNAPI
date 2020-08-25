import XCTest

@testable import HNAPI

final class ActionTests: XCTestCase {
    func testInverseActions() {
        let favoriteAction = Action.favorite(
            URL(string: "fave?id=22858254&auth=8a1b497e8f6d0cada8700a445da2bcfafb0bde1b")!)
        XCTAssertEqual(favoriteAction.inverseSet.count, 1)
        XCTAssert(favoriteAction.inverseSet.contains(where: { $0.url.absoluteString == "fave?id=22858254&auth=8a1b497e8f6d0cada8700a445da2bcfafb0bde1b&un=t" }))
        let upvoteAction = Action.upvote(
            URL(string: "vote?id=22859090&auth=aae9081569d59f6cb252bc130f7987f80e4774f0&how=up")!)
        XCTAssertEqual(upvoteAction.inverseSet.count, 1)
        XCTAssert(upvoteAction.inverseSet.contains(where: { $0.url.absoluteString == "vote?id=22859090&auth=aae9081569d59f6cb252bc130f7987f80e4774f0&how=un" }))
        let unvoteAction = Action.unvote(URL(string: "vote?id=22859090&auth=aae9081569d59f6cb252bc130f7987f80e4774f0&how=un")!)
        XCTAssertEqual(unvoteAction.inverseSet.count, 2)
        XCTAssert(unvoteAction.inverseSet.contains(where: { $0.url.absoluteString == "vote?id=22859090&auth=aae9081569d59f6cb252bc130f7987f80e4774f0&how=up" }))
        XCTAssert(unvoteAction.inverseSet.contains(where: { $0.url.absoluteString == "vote?id=22859090&auth=aae9081569d59f6cb252bc130f7987f80e4774f0&how=down" }))
    }
}
