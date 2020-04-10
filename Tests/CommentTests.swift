import XCTest

@testable import HNAPI

final class CommentTests: XCTestCase {
    func testDecodingCommentTree() {
        let jsonData = #"""
            {
              "id": 121108,
              "created_at": "2008-02-22T06:23:54.000Z",
              "created_at_i": 1203661434,
              "type": "comment",
              "author": "cstejerean",
              "title": null,
              "url": null,
              "text": "<p>I upvoted the current \"fluff link\". I found it entertaining and at least somewhat on topic (more than the post about Castro). Personally I'm more concerned that the link about 37signals releasing numbers was still on the front page today. Ok, it was news, I read it and it was relevant. but it stopped being relevant after 5 minutes.</p><p>I think the solution is not to keep the inevitable influx of stories that will annoy some long time users, but to figure out a way to show users only stories they care about.</p>",
              "points": null,
              "parent_id": 121016,
              "story_id": 121003,
              "children": [
                {
                  "id": 121132,
                  "created_at": "2008-02-22T07:02:28.000Z",
                  "created_at_i": 1203663748,
                  "type": "comment",
                  "author": "matstc",
                  "title": null,
                  "url": null,
                  "text": "<p>I'm not sure I understand your concern about the 37signals article: 99% of articles will be irrelevant once you've read them.</p><p>Also do you not think the top stories should be the same for everyone?   It's the easiest way to keep the community focused and self-serving.</p>",
                  "points": null,
                  "parent_id": 121108,
                  "story_id": 121003,
                  "children": [
                    {
                      "id": 121286,
                      "created_at": "2008-02-22T14:55:43.000Z",
                      "created_at_i": 1203692143,
                      "type": "comment",
                      "author": "cstejerean",
                      "title": null,
                      "url": null,
                      "text": "<p>for some of the stories I want to follow the conversation. But I check HN quite often and it annoys me when I see the same stories in the front page that I read the day before.</p>",
                      "points": null,
                      "parent_id": 121132,
                      "story_id": 121003,
                      "children": [
                        {
                          "id": 122395,
                          "created_at": "2008-02-24T06:58:09.000Z",
                          "created_at_i": 1203836289,
                          "type": "comment",
                          "author": "kingnothing",
                          "title": null,
                          "url": null,
                          "text": "<p>Check out the new page and vote some of those stories up in order to help get them to the front page.</p>",
                          "points": null,
                          "parent_id": 121286,
                          "story_id": 121003,
                          "children": [],
                          "options": []
                        }
                      ],
                      "options": []
                    }
                  ],
                  "options": []
                }
              ],
              "options": []
            }
            """#
            .data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        do {
            let comment = try decoder.decode(Comment.self, from: jsonData)
            XCTAssertEqual(comment.id, 121108)
            XCTAssertEqual(comment.author, "cstejerean")
            XCTAssertEqual(comment.children[0].id, 121132)
            XCTAssertEqual(comment.children[0].children[0].id, 121286)
            XCTAssertEqual(comment.children[0].children[0].children[0].id, 122395)
        } catch { XCTFail("Error \(error) thrown.") }
    }
}
