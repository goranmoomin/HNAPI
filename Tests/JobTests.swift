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
            XCTAssertEqual(job.id, 22_818_097)
            XCTAssertEqual(
                job.content, .url(URL(string: "https://boards.greenhouse.io/genius/jobs/1456158")!))
            XCTAssertEqual(job.creation, Date(timeIntervalSince1970: 1_586_386_632))
            XCTAssertEqual(
                job.title,
                "Genius (YC S11) Is Hiring a Senior Full Stack Engineer (NYC or U.S. Remote)")
        } catch { XCTFail("Error \(error) thrown.") }
    }

    func testDecodingTextJob() {
        let jsonData = #"""
            {
              "created_at": "2008-05-16T23:40:17.000Z",
              "title": "Justin.tv is looking for a Lead Flash Engineer!",
              "url": "",
              "author": "justin",
              "points": 6,
              "story_text": "Justin.tv is the biggest live video site online. We serve hundreds of thousands of video streams a day, and have supported up to 50k live concurrent viewers. Our site is growing every week, and we just added a 10 gbps line to our colo. Our unique visitors are up 900% since January.<p>There are a lot of pieces that fit together to make Justin.tv work: our video cluster, IRC server, our web app, and our monitoring and search services, to name a few. A lot of our website is dependent on Flash, and we're looking for talented Flash Engineers who know AS2 and AS3 very well who want to be leaders in the development of our Flash.<p>Responsibilities<p><pre><code>    * Contribute to product design and implementation discussions\n    * Implement projects from the idea phase to production\n    * Test and iterate code before and after production release \n</code></pre>\nQualifications<p><pre><code>    * You should know AS2, AS3, and maybe a little be of Flex.\n    * Experience building web applications.\n    * A strong desire to work on website with passionate users and ideas for how to improve it.\n    * Experience hacking video streams, python, Twisted or rails all a plus.\n</code></pre>\nWhile we're growing rapidly, Justin.tv is still a small, technology focused company, built by hackers for hackers. Seven of our ten person team are engineers or designers. We believe in rapid development, and push out new code releases every week. We're based in a beautiful office in the SOMA district of SF, one block from the caltrain station. If you want a fun job hacking on code that will touch a lot of people, JTV is for you.<p>Note: You must be physically present in SF to work for JTV. Completing the technical problem at <a href=\"http://www.justin.tv/problems/bml\" rel=\"nofollow\">http://www.justin.tv/problems/bml</a> will go a long way with us. Cheers!",
              "comment_text": null,
              "num_comments": null,
              "story_id": null,
              "story_title": null,
              "story_url": null,
              "parent_id": null,
              "created_at_i": 1210981217,
              "relevancy_score": 1115,
              "_tags": [
                "job",
                "author_justin",
                "story_192327"
              ],
              "objectID": "192327",
              "_highlightResult": {
                "title": {
                  "value": "Justin.tv is looking for a Lead Flash Engineer!",
                  "matchLevel": "none",
                  "matchedWords": []
                },
                "url": {
                  "value": "",
                  "matchLevel": "none",
                  "matchedWords": []
                },
                "author": {
                  "value": "justin",
                  "matchLevel": "none",
                  "matchedWords": []
                },
                "story_text": {
                  "value": "Justin.tv is the biggest live video site online. We serve hundreds of thousands of video streams a day, and have supported up to 50k live concurrent viewers. Our site is growing every week, and we just added a 10 gbps line to our colo. Our unique visitors are up 900% since January.<p>There are a lot of pieces that fit together to make Justin.tv work: our video cluster, IRC server, our web app, and our monitoring and search services, to name a few. A lot of our website is dependent on Flash, and we're looking for talented Flash Engineers who know AS2 and AS3 very well who want to be leaders in the development of our Flash.<p>Responsibilities<p><pre><code>    * Contribute to product design and implementation discussions\n    * Implement projects from the idea phase to production\n    * Test and iterate code before and after production release \n</code></pre>\nQualifications<p><pre><code>    * You should know AS2, AS3, and maybe a little be of Flex.\n    * Experience building web applications.\n    * A strong desire to work on website with passionate users and ideas for how to improve it.\n    * Experience hacking video streams, python, Twisted or rails all a plus.\n</code></pre>\nWhile we're growing rapidly, Justin.tv is still a small, technology focused company, built by hackers for hackers. Seven of our ten person team are engineers or designers. We believe in rapid development, and push out new code releases every week. We're based in a beautiful office in the SOMA district of SF, one block from the caltrain station. If you want a fun job hacking on code that will touch a lot of people, JTV is for you.<p>Note: You must be physically present in SF to work for JTV. Completing the technical problem at <a href=\"http://www.justin.tv/problems/bml\" rel=\"nofollow\">http://www.justin.tv/problems/bml</a> will go a long way with us. Cheers!",
                  "matchLevel": "none",
                  "matchedWords": []
                }
              }
            }
            """#
            .data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        do {
            let job = try decoder.decode(Job.self, from: jsonData)
            XCTAssertEqual(job.id, 192327)
            XCTAssert((job.content.text?.starts(with: "Justin.tv")).isTruthy())
            XCTAssertEqual(job.creation, Date(timeIntervalSince1970: 1_210_981_217))
            XCTAssertEqual(job.title, "Justin.tv is looking for a Lead Flash Engineer!")
        } catch { XCTFail("Error \(error) thrown.") }
    }
}
