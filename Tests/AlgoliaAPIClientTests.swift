import XCTest

@testable import HNAPI

final class AlgoliaAPIClientTests: XCTestCase {
    class MockClient: NetworkClient {
        enum Error: Swift.Error { case unknown }
        func request(to endpoint: Endpoint, completionHandler: @escaping Completion) {
            if endpoint.url.absoluteString
                == "https://hn.algolia.com/api/v1/search?tags=(story,job,poll),(story_1)&hitsPerPage=1"
            {
                let jsonData = """
                    {
                      "hits": [
                        {
                          "created_at": "2006-10-09T18:21:51.000Z",
                          "title": "Y Combinator",
                          "url": "http://ycombinator.com",
                          "author": "pg",
                          "points": 61,
                          "story_text": null,
                          "comment_text": null,
                          "num_comments": 15,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1160418111,
                          "relevancy_score": 0,
                          "_tags": [
                            "story",
                            "author_pg",
                            "story_1"
                          ],
                          "objectID": "1",
                          "_highlightResult": {
                            "title": {
                              "value": "Y Combinator",
                              "matchLevel": "none",
                              "matchedWords": []
                            },
                            "url": {
                              "value": "http://ycombinator.com",
                              "matchLevel": "none",
                              "matchedWords": []
                            },
                            "author": {
                              "value": "pg",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        }
                      ],
                      "nbHits": 1,
                      "page": 0,
                      "nbPages": 1,
                      "hitsPerPage": 1,
                      "exhaustiveNbHits": true,
                      "query": "",
                      "params": "advancedSyntax=true&analytics=true&analyticsTags=backend&hitsPerPage=1&tags=%28story%2Cjob%2Cpoll%29%2Cstory_1",
                      "processingTimeMS": 1
                    }
                    """
                    .data(using: .utf8)!
                completionHandler(.success((jsonData, URLResponse())))
            } else { completionHandler(.failure(Error.unknown)) }
        }
    }

    func testLoadingTopItems() {
        let client = AlgoliaAPIClient()
        client.networkClient = MockClient()
        client.items(ids: [1]) { result in
            guard case let .success(items) = result else {
                XCTFail("Error \(result.failure!) thrown.")
                return
            }
            let item = items[0]
            XCTAssertEqual(item.story?.title, "Y Combinator")
            XCTAssertEqual(item.story?.author, "pg")
        }
    }
}
