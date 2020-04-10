import XCTest

@testable import HNAPI

final class APIClientTests: XCTestCase {
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
            } else if endpoint.url.absoluteString == "https://hn.algolia.com/api/v1/items/1" {
                let jsonData = #"""
                    {
                      "id": 1,
                      "created_at": "2006-10-09T18:21:51.000Z",
                      "created_at_i": 1160418111,
                      "type": "story",
                      "author": "pg",
                      "title": "Y Combinator",
                      "url": "http://ycombinator.com",
                      "text": null,
                      "points": 61,
                      "parent_id": null,
                      "story_id": null,
                      "children": [
                        {
                          "id": 487171,
                          "created_at": "2009-02-19T12:21:23.000Z",
                          "created_at_i": 1235046083,
                          "type": "comment",
                          "author": "jacquesm",
                          "title": null,
                          "url": null,
                          "text": "<p>So, just to see how hard it is to make the longest span between article and comment :)</p><p>Congratulations on your second birthday YC, and thanks to Paul Graham for writing this forum. I had a really good look at the good a few days ago and I was quite impressed with how elegant the whole thing is put together.</p><p>Lisp would not be my language of choice for a website like this, and yet, after seeing how concise it was I'm tempted to play around with lisp in a web environment.</p>",
                          "points": null,
                          "parent_id": 1,
                          "story_id": 1,
                          "children": [],
                          "options": []
                        },
                        {
                          "id": 454410,
                          "created_at": "2009-01-28T20:31:34.000Z",
                          "created_at_i": 1233174694,
                          "type": "comment",
                          "author": "Arrington",
                          "title": null,
                          "url": null,
                          "text": "<p>This is why we can't have nice things.</p>",
                          "points": null,
                          "parent_id": 1,
                          "story_id": 1,
                          "children": [],
                          "options": []
                        },
                        {
                          "id": 234509,
                          "created_at": "2008-07-02T20:29:48.000Z",
                          "created_at_i": 1215030588,
                          "type": "comment",
                          "author": "kleevr",
                          "title": null,
                          "url": null,
                          "text": "<p>sequential numbering\n  I must be bored</p>",
                          "points": null,
                          "parent_id": 1,
                          "story_id": 1,
                          "children": [
                            {
                              "id": 234548,
                              "created_at": "2008-07-02T21:09:38.000Z",
                              "created_at_i": 1215032978,
                              "type": "comment",
                              "author": "byrneseyeview",
                              "title": null,
                              "url": null,
                              "text": "<p>I think I agree?</p>",
                              "points": null,
                              "parent_id": 234509,
                              "story_id": 1,
                              "children": [
                                {
                                  "id": 234549,
                                  "created_at": "2008-07-02T21:11:02.000Z",
                                  "created_at_i": 1215033062,
                                  "type": "comment",
                                  "author": "rms",
                                  "title": null,
                                  "url": null,
                                  "text": "<p>i hear that there is an awesome easter egg in the -100s somewhere</p>",
                                  "points": null,
                                  "parent_id": 234548,
                                  "story_id": 1,
                                  "children": [
                                    {
                                      "id": 234551,
                                      "created_at": "2008-07-02T21:13:37.000Z",
                                      "created_at_i": 1215033217,
                                      "type": "comment",
                                      "author": "byrneseyeview",
                                      "title": null,
                                      "url": null,
                                      "text": "<p>How many people are lurking on this thread?</p>",
                                      "points": null,
                                      "parent_id": 234549,
                                      "story_id": 1,
                                      "children": [
                                        {
                                          "id": 234567,
                                          "created_at": "2008-07-02T21:24:23.000Z",
                                          "created_at_i": 1215033863,
                                          "type": "comment",
                                          "author": "rms",
                                          "title": null,
                                          "url": null,
                                          "text": "<p>it's the new comments page for me...</p>",
                                          "points": null,
                                          "parent_id": 234551,
                                          "story_id": 1,
                                          "children": [
                                            {
                                              "id": 234580,
                                              "created_at": "2008-07-02T21:35:08.000Z",
                                              "created_at_i": 1215034508,
                                              "type": "comment",
                                              "author": "sebg",
                                              "title": null,
                                              "url": null,
                                              "text": "<p>ditto.  (thanks for pointing out posts vs. items.)</p>",
                                              "points": null,
                                              "parent_id": 234567,
                                              "story_id": 1,
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
                              ],
                              "options": []
                            },
                            {
                              "id": 234560,
                              "created_at": "2008-07-02T21:20:36.000Z",
                              "created_at_i": 1215033636,
                              "type": "comment",
                              "author": "sebg",
                              "title": null,
                              "url": null,
                              "text": "<p>Interesting - post 1 has comments.  no more comments until post 15.  which then has the same conversation between pg and dnom as the first post.  To top it off, post 17 is the conversation in posts 1 and 15.</p>",
                              "points": null,
                              "parent_id": 234509,
                              "story_id": 1,
                              "children": [
                                {
                                  "id": 234568,
                                  "created_at": "2008-07-02T21:24:27.000Z",
                                  "created_at_i": 1215033867,
                                  "type": "comment",
                                  "author": "byrneseyeview",
                                  "title": null,
                                  "url": null,
                                  "text": "<p>I think those 'items' are comments, not posts.</p>",
                                  "points": null,
                                  "parent_id": 234560,
                                  "story_id": 1,
                                  "children": [
                                    {
                                      "id": 234591,
                                      "created_at": "2008-07-02T21:45:55.000Z",
                                      "created_at_i": 1215035155,
                                      "type": "comment",
                                      "author": null,
                                      "title": null,
                                      "url": null,
                                      "text": null,
                                      "points": null,
                                      "parent_id": 234568,
                                      "story_id": null,
                                      "children": [],
                                      "options": []
                                    },
                                    {
                                      "id": 234633,
                                      "created_at": "2008-07-02T22:22:09.000Z",
                                      "created_at_i": 1215037329,
                                      "type": "comment",
                                      "author": "kleevr",
                                      "title": null,
                                      "url": null,
                                      "text": "<p>items: comments || posts... \nthey're also arranged in a hierarchy...</p>",
                                      "points": null,
                                      "parent_id": 234568,
                                      "story_id": 1,
                                      "children": [],
                                      "options": []
                                    }
                                  ],
                                  "options": []
                                },
                                {
                                  "id": 234593,
                                  "created_at": "2008-07-02T21:47:18.000Z",
                                  "created_at_i": 1215035238,
                                  "type": "comment",
                                  "author": "kleevr",
                                  "title": null,
                                  "url": null,
                                  "text": "<p>I'm sure the first fifteen were used primarily to populate the burgeoning news.yc</p>",
                                  "points": null,
                                  "parent_id": 234560,
                                  "story_id": 1,
                                  "children": [],
                                  "options": []
                                }
                              ],
                              "options": []
                            },
                            {
                              "id": 234621,
                              "created_at": "2008-07-02T22:10:58.000Z",
                              "created_at_i": 1215036658,
                              "type": "comment",
                              "author": "kleevr",
                              "title": null,
                              "url": null,
                              "text": "<p>I guess that news.yc is 1-indexed :)</p><p><a href=\"http://news.ycombinator.com/item?id=0\" rel=\"nofollow\">http://news.ycombinator.com/item?id=0</a> , DNE</p>",
                              "points": null,
                              "parent_id": 234509,
                              "story_id": 1,
                              "children": [],
                              "options": []
                            }
                          ],
                          "options": []
                        },
                        {
                          "id": 15,
                          "created_at": "2006-10-09T19:51:01.000Z",
                          "created_at_i": 1160423461,
                          "type": "comment",
                          "author": "sama",
                          "title": null,
                          "url": null,
                          "text": "<p>&#34;the rising star of venture capital&#34; -unknown VC eating lunch on SHR</p>",
                          "points": null,
                          "parent_id": 1,
                          "story_id": 1,
                          "children": [
                            {
                              "id": 17,
                              "created_at": "2006-10-09T19:52:45.000Z",
                              "created_at_i": 1160423565,
                              "type": "comment",
                              "author": "pg",
                              "title": null,
                              "url": null,
                              "text": "<p>Is there anywhere to eat on Sandhill Road?</p>",
                              "points": null,
                              "parent_id": 15,
                              "story_id": 1,
                              "children": [
                                {
                                  "id": 454426,
                                  "created_at": "2009-01-28T20:32:27.000Z",
                                  "created_at_i": 1233174747,
                                  "type": "comment",
                                  "author": "Arrington",
                                  "title": null,
                                  "url": null,
                                  "text": "<p>This is why we can't have nice things.</p>",
                                  "points": null,
                                  "parent_id": 17,
                                  "story_id": 1,
                                  "children": [],
                                  "options": []
                                },
                                {
                                  "id": 1079,
                                  "created_at": "2007-02-25T22:18:23.000Z",
                                  "created_at_i": 1172441903,
                                  "type": "comment",
                                  "author": "dmon",
                                  "title": null,
                                  "url": null,
                                  "text": "<p>sure</p>",
                                  "points": null,
                                  "parent_id": 17,
                                  "story_id": 1,
                                  "children": [],
                                  "options": []
                                }
                              ],
                              "options": []
                            },
                            {
                              "id": 454424,
                              "created_at": "2009-01-28T20:32:21.000Z",
                              "created_at_i": 1233174741,
                              "type": "comment",
                              "author": "Arrington",
                              "title": null,
                              "url": null,
                              "text": "<p>This is why we can't have nice things.</p>",
                              "points": null,
                              "parent_id": 15,
                              "story_id": 1,
                              "children": [],
                              "options": []
                            }
                          ],
                          "options": []
                        },
                        {
                          "id": 82729,
                          "created_at": "2007-11-22T12:50:54.000Z",
                          "created_at_i": 1195735854,
                          "type": "comment",
                          "author": "vice",
                          "title": null,
                          "url": null,
                          "text": "<p>I'm nX 1 too</p><p>;)\n</p>",
                          "points": null,
                          "parent_id": 1,
                          "story_id": 1,
                          "children": [],
                          "options": []
                        }
                      ],
                      "options": []
                    }

                    """#
                    .data(using: .utf8)!
                completionHandler(.success((jsonData, URLResponse())))
            } else { completionHandler(.failure(Error.unknown)) }
        }
    }

    let client: APIClient = {
        let client = APIClient()
        client.networkClient = MockClient()
        return client
    }()

    func testLoadingTopItems() {
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

    func testLoadingPage() {
        client.items(ids: [1]) { result in
            guard case let .success(items) = result else {
                XCTFail("Error \(result.failure!) thrown.")
                return
            }
            let item = items[0]
            self.client.page(item: item) { result in
                guard case let .success(page) = result else {
                    XCTFail("Error \(result.failure!) thrown.")
                    return
                }
                XCTAssertEqual(page.children.count, 5)
                XCTAssertEqual(
                    page.children[2].children[0].children[0].text,
                    "<p>i hear that there is an awesome easter egg in the -100s somewhere</p>")
            }
        }
    }
}
