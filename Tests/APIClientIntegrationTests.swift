import XCTest

@testable import HNAPI

final class APIClientIntegrationTests: XCTestCase {
    func testLoadingTopItems() {
        let client = APIClient()
        let expectation = self.expectation(description: "Expect for items to be loaded")
        client.topItems { result in
            guard case let .success(items) = result else {
                XCTFail("Error \(result.failure!) thrown.")
                expectation.fulfill()
                return
            }
            XCTAssertEqual(items.count, 30)
            expectation.fulfill()
        }
        waitForExpectations(timeout: .infinity, handler: nil)
    }

    func testSearchingItems() {
        let client = APIClient()
        let expectation = self.expectation(description: "Expect for items to be loaded")
        client.items(query: "foo") { result in
            guard case .success = result else {
                XCTFail("Error \(result.failure!) thrown.")
                expectation.fulfill()
                return
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: .infinity, handler: nil)
    }

    func testLoadingPage() {
        let client = APIClient()
        let expectation = self.expectation(description: "Expect for page to be loaded")
        client.items(ids: [1]) { result in
            guard case let .success(items) = result else {
                XCTFail("Error \(result.failure!) thrown.")
                expectation.fulfill()
                return
            }
            let item = items[0]
            client.page(item: item) { result in
                guard case let .success(page) = result else {
                    XCTFail("Error \(result.failure!) thrown.")
                    expectation.fulfill()
                    return
                }
                XCTAssertEqual(page.children[0].children[0].children[0].text, "<p>sure</p>")
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: .infinity, handler: nil)
    }

    func testLoggingIn() {
        let client = APIClient()
        let expectation = self.expectation(description: "Expect for login to succeed")
        client.login(userName: "hntestacc", password: "hntestpwd") { result in
            guard case let .success(token) = result else {
                XCTFail("Error \(result.failure!) thrown.")
                expectation.fulfill()
                return
            }
            client.items(ids: [1]) { result in
                guard case let .success(items) = result else {
                    XCTFail("Error \(result.failure!) thrown.")
                    expectation.fulfill()
                    return
                }
                let item = items[0]
                client.page(item: item, token: token) { result in
                    guard case let .success(page) = result else {
                        XCTFail("Error \(result.failure!) thrown.")
                        expectation.fulfill()
                        return
                    }
                    XCTAssertEqual(page.actions[17]?.count, 1)
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: .infinity, handler: nil)
    }

    func testCommenting() {
        let client = APIClient()
        let expectation = self.expectation(description: "Expect for commenting to succeed")
        client.login(userName: "hntestacc", password: "hntestpwd") { result in
            guard case let .success(token) = result else {
                XCTFail("Error \(result.failure!) thrown.")
                expectation.fulfill()
                return
            }
            client.topItems { result in
                guard case let .success(topItems) = result else {
                    XCTFail("Error \(result.failure!) thrown.")
                    expectation.fulfill()
                    return
                }
                let item = topItems[0]
                let id = item.id
                client.reply(
                    toID: id, text: "This is a test. If you see this, please pass through.",
                    token: token
                ) { result in
                    guard case .success = result else {
                        XCTFail("Error \(result.failure!) thrown.")
                        expectation.fulfill()
                        return
                    }
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: .infinity, handler: nil)
    }

    func testUpvoting() {
        let client = APIClient()
        let expectation = self.expectation(description: "Expect the upvote to succeed")
        client.login(userName: "hntestacc", password: "hntestpwd") { result in
            guard case let .success(token) = result else {
                XCTFail("Error \(result.failure!) thrown.")
                expectation.fulfill()
                return
            }
            client.topItems { result in
                guard case let .success(topItems) = result else {
                    XCTFail("Error \(result.failure!) thrown.")
                    expectation.fulfill()
                    return
                }
                let item = topItems[0]
                client.page(item: item, token: token) { result in
                    guard case let .success(page) = result else {
                        XCTFail("Error \(result.failure!) thrown.")
                        expectation.fulfill()
                        return
                    }
                    let id = page.children[0].id
                    guard
                        let action = page.actions[id]?
                            .first(where: {
                                if case .upvote = $0 { return true } else { return false }
                            })
                    else {
                        XCTFail("Upvote action not found.")
                        expectation.fulfill()
                        return
                    }
                    client.execute(action: action, token: token, page: page) { result in
                        print("client.execute(action:page:completionHandler:)")
                        guard case .success = result else {
                            XCTFail("Error \(result.failure!) thrown.")
                            expectation.fulfill()
                            return
                        }
                        expectation.fulfill()
                    }
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: .infinity, handler: nil)
    }
}
