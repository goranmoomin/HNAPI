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
            } else if endpoint.url.absoluteString == "https://news.ycombinator.com/item?id=1" {
                let htmlData = #"""
                    <html op="item"><head><meta name="referrer" content="origin"><meta name="viewport" content="width=device-width, initial-scale=1.0"><link rel="stylesheet" type="text/css" href="news.css?8TojdIkfXE2jenmubhu1">
                            <link rel="shortcut icon" href="favicon.ico">
                            <title>Y Combinator | Hacker News</title></head><body><center><table id="hnmain" border="0" cellpadding="0" cellspacing="0" width="85%" bgcolor="#f6f6ef">
                            <tr><td bgcolor="#ff6600"><table border="0" cellpadding="0" cellspacing="0" width="100%" style="padding:2px"><tr><td style="width:18px;padding-right:4px"><a href="https://news.ycombinator.com"><img src="y18.gif" width="18" height="18" style="border:1px white solid;"></a></td>
                                      <td style="line-height:12pt; height:10px;"><span class="pagetop"><b class="hnname"><a href="news">Hacker News</a></b>
                                  <a href="newest">new</a> | <a href="front">past</a> | <a href="newcomments">comments</a> | <a href="ask">ask</a> | <a href="show">show</a> | <a href="jobs">jobs</a> | <a href="submit">submit</a>            </span></td><td style="text-align:right;padding-right:4px;"><span class="pagetop">
                                                  <a href="login?goto=item%3Fid%3D1">login</a>
                                              </span></td>
                                  </tr></table></td></tr>
                    <tr id="pagespace" title="Y Combinator" style="height:10px"></tr><tr><td><table class="fatitem" border="0">
                            <tr class='athing' id='1'>
                          <td align="right" valign="top" class="title"><span class="rank"></span></td>      <td valign="top" class="votelinks"><center><a id='up_1' href='vote?id=1&amp;how=up&amp;goto=item%3Fid%3D1'><div class='votearrow' title='upvote'></div></a></center></td><td class="title"><a href="http://ycombinator.com" class="storylink">Y Combinator</a><span class="sitebit comhead"> (<a href="from?site=ycombinator.com"><span class="sitestr">ycombinator.com</span></a>)</span></td></tr><tr><td colspan="2"></td><td class="subtext">
                            <span class="score" id="score_1">57 points</span> by <a href="user?id=pg" class="hnuser">pg</a> <span class="age"><a href="item?id=1">on Oct 9, 2006</a></span> <span id="unv_1"></span> | <a href="hide?id=1&amp;goto=item%3Fid%3D1">hide</a> | <a href="https://hn.algolia.com/?query=Y%20Combinator&sort=byDate&dateRange=all&type=story&storyText=false&prefix&page=0" class="hnpast">past</a> | <a href="https://www.google.com/search?q=Y%20Combinator">web</a> | <a href="fave?id=1&amp;auth=a60f2a4b75b2ef5300e9142ed071c4b23f07168b">favorite</a> | <a href="item?id=1">15&nbsp;comments</a>              </td></tr>
                            </table><br><br>
                      <table border="0" class='comment-tree'>
                                <tr class='athing comtr ' id='15'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="0"></td><td valign="top" class="votelinks"><center><a id='up_15' href='vote?id=15&amp;how=up&amp;goto=item%3Fid%3D1'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=sama" class="hnuser">sama</a> <span class="age"><a href="item?id=15">on Oct 9, 2006</a></span> <span id="unv_15"></span><span class="par"></span> <a class="togg" n="3" href="javascript:void(0)" onclick="return toggle(event, 15)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">&#34;the rising star of venture capital&#34; -unknown VC eating lunch on SHR</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='17'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="40"></td><td valign="top" class="votelinks"><center><a id='up_17' href='vote?id=17&amp;how=up&amp;goto=item%3Fid%3D1'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=pg" class="hnuser">pg</a> <span class="age"><a href="item?id=17">on Oct 9, 2006</a></span> <span id="unv_17"></span><span class="par"></span> <a class="togg" n="2" href="javascript:void(0)" onclick="return toggle(event, 17)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">Is there anywhere to eat on Sandhill Road?</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='1079'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="80"></td><td valign="top" class="votelinks"><center><a id='up_1079' href='vote?id=1079&amp;how=up&amp;goto=item%3Fid%3D1'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=dmon" class="hnuser">dmon</a> <span class="age"><a href="item?id=1079">on Feb 25, 2007</a></span> <span id="unv_1079"></span><span class="par"></span> <a class="togg" n="1" href="javascript:void(0)" onclick="return toggle(event, 1079)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">sure</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                                      <tr class='athing comtr ' id='234509'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="0"></td><td valign="top" class="votelinks"><center><a id='up_234509' href='vote?id=234509&amp;how=up&amp;goto=item%3Fid%3D1'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=kleevr" class="hnuser">kleevr</a> <span class="age"><a href="item?id=234509">on July 2, 2008</a></span> <span id="unv_234509"></span><span class="par"></span> <a class="togg" n="11" href="javascript:void(0)" onclick="return toggle(event, 234509)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">sequential numbering
                      I must be bored</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='234621'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="40"></td><td valign="top" class="votelinks"><center><a id='up_234621' href='vote?id=234621&amp;how=up&amp;goto=item%3Fid%3D1'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=kleevr" class="hnuser">kleevr</a> <span class="age"><a href="item?id=234621">on July 2, 2008</a></span> <span id="unv_234621"></span><span class="par"></span> <a class="togg" n="1" href="javascript:void(0)" onclick="return toggle(event, 234621)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">I guess that news.yc is 1-indexed :)<p><a href="http://news.ycombinator.com/item?id=0" rel="nofollow">http://news.ycombinator.com/item?id=0</a> , DNE</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                        <tr class='athing comtr ' id='234560'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="40"></td><td valign="top" class="votelinks"><center><a id='up_234560' href='vote?id=234560&amp;how=up&amp;goto=item%3Fid%3D1'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=sebg" class="hnuser">sebg</a> <span class="age"><a href="item?id=234560">on July 2, 2008</a></span> <span id="unv_234560"></span><span class="par"></span> <a class="togg" n="4" href="javascript:void(0)" onclick="return toggle(event, 234560)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">Interesting - post 1 has comments.  no more comments until post 15.  which then has the same conversation between pg and dnom as the first post.  To top it off, post 17 is the conversation in posts 1 and 15.</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='234593'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="80"></td><td valign="top" class="votelinks"><center><a id='up_234593' href='vote?id=234593&amp;how=up&amp;goto=item%3Fid%3D1'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=kleevr" class="hnuser">kleevr</a> <span class="age"><a href="item?id=234593">on July 2, 2008</a></span> <span id="unv_234593"></span><span class="par"></span> <a class="togg" n="1" href="javascript:void(0)" onclick="return toggle(event, 234593)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">I'm sure the first fifteen were used primarily to populate the burgeoning news.yc</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                        <tr class='athing comtr ' id='234568'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="80"></td><td valign="top" class="votelinks"><center><a id='up_234568' href='vote?id=234568&amp;how=up&amp;goto=item%3Fid%3D1'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=byrneseyeview" class="hnuser">byrneseyeview</a> <span class="age"><a href="item?id=234568">on July 2, 2008</a></span> <span id="unv_234568"></span><span class="par"></span> <a class="togg" n="2" href="javascript:void(0)" onclick="return toggle(event, 234568)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">I think those 'items' are comments, not posts.</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='234633'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="120"></td><td valign="top" class="votelinks"><center><a id='up_234633' href='vote?id=234633&amp;how=up&amp;goto=item%3Fid%3D1'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=kleevr" class="hnuser">kleevr</a> <span class="age"><a href="item?id=234633">on July 2, 2008</a></span> <span id="unv_234633"></span><span class="par"></span> <a class="togg" n="1" href="javascript:void(0)" onclick="return toggle(event, 234633)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">items: comments || posts...
                    they're also arranged in a hierarchy...</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='234548'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="40"></td><td valign="top" class="votelinks"><center><a id='up_234548' href='vote?id=234548&amp;how=up&amp;goto=item%3Fid%3D1'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=byrneseyeview" class="hnuser">byrneseyeview</a> <span class="age"><a href="item?id=234548">on July 2, 2008</a></span> <span id="unv_234548"></span><span class="par"></span> <a class="togg" n="5" href="javascript:void(0)" onclick="return toggle(event, 234548)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">I think I agree?</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='234549'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="80"></td><td valign="top" class="votelinks"><center><a id='up_234549' href='vote?id=234549&amp;how=up&amp;goto=item%3Fid%3D1'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=kf" class="hnuser">kf</a> <span class="age"><a href="item?id=234549">on July 2, 2008</a></span> <span id="unv_234549"></span><span class="par"></span> <a class="togg" n="4" href="javascript:void(0)" onclick="return toggle(event, 234549)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">i hear that there is an awesome easter egg in the -100s somewhere</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='234551'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="120"></td><td valign="top" class="votelinks"><center><a id='up_234551' href='vote?id=234551&amp;how=up&amp;goto=item%3Fid%3D1'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=byrneseyeview" class="hnuser">byrneseyeview</a> <span class="age"><a href="item?id=234551">on July 2, 2008</a></span> <span id="unv_234551"></span><span class="par"></span> <a class="togg" n="3" href="javascript:void(0)" onclick="return toggle(event, 234551)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">How many people are lurking on this thread?</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='234567'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="160"></td><td valign="top" class="votelinks"><center><a id='up_234567' href='vote?id=234567&amp;how=up&amp;goto=item%3Fid%3D1'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=kf" class="hnuser">kf</a> <span class="age"><a href="item?id=234567">on July 2, 2008</a></span> <span id="unv_234567"></span><span class="par"></span> <a class="togg" n="2" href="javascript:void(0)" onclick="return toggle(event, 234567)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">it's the new comments page for me...</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='234580'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="200"></td><td valign="top" class="votelinks"><center><a id='up_234580' href='vote?id=234580&amp;how=up&amp;goto=item%3Fid%3D1'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=sebg" class="hnuser">sebg</a> <span class="age"><a href="item?id=234580">on July 2, 2008</a></span> <span id="unv_234580"></span><span class="par"></span> <a class="togg" n="1" href="javascript:void(0)" onclick="return toggle(event, 234580)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">ditto.  (thanks for pointing out posts vs. items.)</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                                            <tr class='athing comtr ' id='487171'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="0"></td><td valign="top" class="votelinks"><center><a id='up_487171' href='vote?id=487171&amp;how=up&amp;goto=item%3Fid%3D1'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=jacquesm" class="hnuser">jacquesm</a> <span class="age"><a href="item?id=487171">on Feb 19, 2009</a></span> <span id="unv_487171"></span><span class="par"></span> <a class="togg" n="1" href="javascript:void(0)" onclick="return toggle(event, 487171)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">So, just to see how hard it is to make the longest span between article and comment :)<p>Congratulations on your second birthday YC, and thanks to Paul Graham for writing this forum. I had a really good look at the good a few days ago and I was quite impressed with how elegant the whole thing is put together.<p>Lisp would not be my language of choice for a website like this, and yet, after seeing how concise it was I'm tempted to play around with lisp in a web environment.</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                                </table>
                          <br><br>
                      </td></tr>
                    <tr><td><img src="s.gif" height="10" width="0"><table width="100%" cellspacing="0" cellpadding="1"><tr><td bgcolor="#ff6600"></td></tr></table><br><center><span class="yclinks"><a href="newsguidelines.html">Guidelines</a>
                            | <a href="newsfaq.html">FAQ</a>
                            | <a href="mailto:hn@ycombinator.com">Support</a>
                            | <a href="https://github.com/HackerNews/API">API</a>
                            | <a href="security.html">Security</a>
                            | <a href="lists">Lists</a>
                            | <a href="bookmarklet.html" rel="nofollow">Bookmarklet</a>
                            | <a href="http://www.ycombinator.com/legal/">Legal</a>
                            | <a href="http://www.ycombinator.com/apply/">Apply to YC</a>
                            | <a href="mailto:hn@ycombinator.com">Contact</a></span><br><br><form method="get" action="//hn.algolia.com/">Search:
                              <input type="text" name="q" value="" size="17" autocorrect="off" spellcheck="false" autocapitalize="off" autocomplete="false"></form>
                                </center></td></tr>
                          </table></center></body><script type='text/javascript' src='hn.js?8TojdIkfXE2jenmubhu1'></script></html>
                    """#
                    .data(using: .utf8)!
                completionHandler(.success((htmlData, URLResponse())))
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
                XCTAssertEqual(page.children[0].children[0].children[0].text, "<p>sure</p>")
            }
        }
    }
}
