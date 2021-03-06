import XCTest

@testable import HNAPI

final class EndpointTests: XCTestCase {
    func testIDsEndpoint() {
        let endpoint = Endpoint.algolia(ids: [126809, 22_818_097])
        XCTAssertEqual(
            endpoint.url?.absoluteString,
            "https://hn.algolia.com/api/v1/search?tags=(story,job,poll),(story_126809,story_22818097)&hitsPerPage=2"
        )
    }

    func testQueryEndpoint() {
        let endpoint = Endpoint.algolia(query: "foo")
        XCTAssertEqual(
            endpoint.url?.absoluteString,
            "https://hn.algolia.com/api/v1/search?tags=(story,job,poll)&query=foo")
    }

    func testCategoryEndpoint() {
        let endpoint = Endpoint.firebase(category: .top)
        XCTAssertEqual(
            endpoint.url?.absoluteString, "https://hacker-news.firebaseio.com/v0/topstories.json")
    }

    func testHNEndpoint() {
        let endpoint = Endpoint.hn(id: 1)
        XCTAssertEqual(endpoint.url?.absoluteString, "https://news.ycombinator.com/item?id=1")
    }

    func testHNLoginEndpoint() {
        let endpoint = Endpoint.hn(userName: "hntestacc", password: "hntestpwd")
        XCTAssertEqual(
            endpoint.url?.absoluteString,
            "https://news.ycombinator.com/login?acct=hntestacc&pw=hntestpwd")
    }
}
