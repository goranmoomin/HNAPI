import XCTest

@testable import HNAPI

final class StoryTests: XCTestCase {
    func testDecodingURLStory() {
        let jsonData = """
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
            }
            """
            .data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        do {
            let story = try decoder.decode(Story.self, from: jsonData)
            XCTAssertEqual(story.author, "dhouston")
            XCTAssertEqual(story.points, 111)
            XCTAssertEqual(
                story.content, .url(URL(string: "http://www.getdropbox.com/u/2/screencast.html")!))
            XCTAssertEqual(story.commentCount, 68)
            XCTAssertEqual(story.creation, Date(timeIntervalSince1970: 1_175_714_200))
        } catch { XCTFail("Error \(error) thrown.") }
    }

    func testDecodingTextStory() {
        let jsonData = """
            {
              "created_at": "2008-02-22T02:33:40.000Z",
              "title": "Ask HN: The Arc Effect",
              "url": "",
              "author": "tel",
              "points": 25,
              "story_text": "<i>or</i> HN: the Next Iteration<p>I get the impression that with Arc being released a lot of people who never had time for HN before are suddenly dropping in more often. (PG: what are the numbers on this? I'm envisioning a spike.)<p>Not to say that isn't great, but I'm wary of Diggification. Between links comparing programming to sex and a flurry of gratuitous, ostentatious  adjectives in the headlines it's a bit concerning.<p>80% of the stuff that makes the front page is still pretty awesome, but what's in place to keep the signal/noise ratio high? Does the HN model still work as the community scales? What's in store for (++ HN)?",
              "comment_text": null,
              "num_comments": 16,
              "story_id": null,
              "story_title": null,
              "story_url": null,
              "parent_id": null,
              "created_at_i": 1203647620,
              "relevancy_score": 953,
              "_tags": [
                "story",
                "author_tel",
                "story_121003",
                "ask_hn"
              ],
              "objectID": "121003",
              "_highlightResult": {
                "title": {
                  "value": "Ask HN: The Arc Effect",
                  "matchLevel": "none",
                  "matchedWords": []
                },
                "url": {
                  "value": "",
                  "matchLevel": "none",
                  "matchedWords": []
                },
                "author": {
                  "value": "tel",
                  "matchLevel": "none",
                  "matchedWords": []
                },
                "story_text": {
                  "value": "<i>or</i> HN: the Next Iteration<p>I get the impression that with Arc being released a lot of people who never had time for HN before are suddenly dropping in more often. (PG: what are the numbers on this? I'm envisioning a spike.)<p>Not to say that isn't great, but I'm wary of Diggification. Between links comparing programming to sex and a flurry of gratuitous, ostentatious  adjectives in the headlines it's a bit concerning.<p>80% of the stuff that makes the front page is still pretty awesome, but what's in place to keep the signal/noise ratio high? Does the HN model still work as the community scales? What's in store for (++ HN)?",
                  "matchLevel": "none",
                  "matchedWords": []
                }
              }
            }
            """
            .data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        do {
            let story = try decoder.decode(Story.self, from: jsonData)
            XCTAssertEqual(story.author, "tel")
            XCTAssertEqual(story.points, 25)
            XCTAssertEqual(story.commentCount, 16)
            XCTAssert(
                (story.content.text?.starts(with: "<i>or</i> HN: the Next Iteration")).isTruthy())
            XCTAssertEqual(story.creation, Date(timeIntervalSince1970: 1_203_647_620))
        } catch { XCTFail("Error \(error) thrown.") }
    }
}
