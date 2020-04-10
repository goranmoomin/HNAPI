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
}
