import XCTest

@testable import HNAPI

final class JobTests: XCTestCase {
    func testDecodingURLJob() {
        let jsonData = """
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
            """
            .data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        do {
            let job = try decoder.decode(Job.self, from: jsonData)
            XCTAssertEqual(
                job.content, .url(URL(string: "https://boards.greenhouse.io/genius/jobs/1456158")!))
            XCTAssertEqual(job.creation, Date(timeIntervalSince1970: 1_586_386_632))
            XCTAssertEqual(
                job.title,
                "Genius (YC S11) Is Hiring a Senior Full Stack Engineer (NYC or U.S. Remote)")
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
