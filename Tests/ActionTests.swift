import XCTest

@testable import HNAPI

final class ActionTests: XCTestCase {
    func testInverseActions() {
        let favoriteAction = Action.favorite(
            URL(string: "fave?id=22858254&auth=8a1b497e8f6d0cada8700a445da2bcfafb0bde1b")!)
        XCTAssertEqual(
            favoriteAction.inverse.url.absoluteString,
            "fave?id=22858254&auth=8a1b497e8f6d0cada8700a445da2bcfafb0bde1b&un=t")
        XCTAssertEqual(
            favoriteAction.inverse.inverse.url.absoluteString,
            "fave?id=22858254&auth=8a1b497e8f6d0cada8700a445da2bcfafb0bde1b")
        let upvoteAction = Action.upvote(
            URL(string: "vote?id=22859090&how=up&auth=aae9081569d59f6cb252bc130f7987f80e4774f0")!)
        XCTAssertEqual(
            upvoteAction.inverse.url.absoluteString,
            "vote?id=22859090&auth=aae9081569d59f6cb252bc130f7987f80e4774f0&how=un")
        XCTAssertEqual(
            upvoteAction.inverse.inverse.url.absoluteString,
            "vote?id=22859090&auth=aae9081569d59f6cb252bc130f7987f80e4774f0&how=up")
    }
}
