import XCTest

@testable import HNAPI

final class TopLevelItemTests: XCTestCase {
    func testDecodingTopLevelItems() {
        let jsonData = """
            [
              {
                "created_at": "2007-04-04T19:16:40.000Z",
                "title": "My YC app: Dropbox - Throw away your USB drive",
                "url": "http://www.getdropbox.com/u/2/screencast.html",
                "author": "dhouston",
                "points": 111,
                "story_text": null,
                "comment_text": null,
                "num_comments": 68,
                "story_id": null,
                "story_title": null,
                "story_url": null,
                "parent_id": null,
                "created_at_i": 1175714200,
                "relevancy_score": 336,
                "_tags": [
                  "story",
                  "author_dhouston",
                  "story_8863"
                ],
                "objectID": "8863",
                "_highlightResult": {
                  "title": {
                    "value": "My YC app: Dropbox - Throw away your USB drive",
                    "matchLevel": "none",
                    "matchedWords": []
                  },
                  "url": {
                    "value": "http://www.getdropbox.com/u/2/screencast.html",
                    "matchLevel": "none",
                    "matchedWords": []
                  },
                  "author": {
                    "value": "dhouston",
                    "matchLevel": "none",
                    "matchedWords": []
                  }
                }
              },
              {
                "created_at": "2020-04-08T22:57:12.000Z",
                "title": "Genius (YC S11) Is Hiring a Senior Full Stack Engineer (NYC or U.S. Remote)",
                "url": "https://boards.greenhouse.io/genius/jobs/1456158",
                "author": "tomlemon",
                "points": 1,
                "story_text": null,
                "comment_text": null,
                "num_comments": null,
                "story_id": null,
                "story_title": null,
                "story_url": null,
                "parent_id": null,
                "created_at_i": 1586386632,
                "_tags": [
                  "job",
                  "author_tomlemon",
                  "story_22818097"
                ],
                "objectID": "22818097",
                "_highlightResult": {
                  "title": {
                    "value": "Genius (YC S11) Is Hiring a Senior Full Stack Engineer (NYC or U.S. Remote)",
                    "matchLevel": "none",
                    "matchedWords": []
                  },
                  "url": {
                    "value": "https://boards.greenhouse.io/genius/jobs/1456158",
                    "matchLevel": "none",
                    "matchedWords": []
                  },
                  "author": {
                    "value": "tomlemon",
                    "matchLevel": "none",
                    "matchedWords": []
                  }
                }
              }
            ]
            """
            .data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        do {
            let items = try decoder.decode([TopLevelItem].self, from: jsonData)
            XCTAssertEqual(items[0].id, 8863)
            XCTAssertEqual(items[0].story?.title, "My YC app: Dropbox - Throw away your USB drive")
            XCTAssertEqual(items[1].id, 22_818_097)
            XCTAssertEqual(
                items[1].job?.content.url?.absoluteString,
                "https://boards.greenhouse.io/genius/jobs/1456158")
        } catch { XCTFail("Error \(error) thrown.") }
    }
}
