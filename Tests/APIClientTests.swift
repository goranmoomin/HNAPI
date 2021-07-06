import XCTest

@testable import HNAPI

final class APIClientTests: XCTestCase {
    class MockClient: NetworkClient {
        enum Error: Swift.Error { case unknown }
        func request(to endpoint: Endpoint, completionHandler: @escaping Completion) {
            if endpoint.url?.absoluteString
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
                completionHandler(.success((jsonData, HTTPURLResponse())))
            } else if endpoint.url?.absoluteString
                == "https://hn.algolia.com/api/v1/search?tags=(story,job,poll)&query=foo"
            {
                let jsonData = #"""
                    {
                      "hits": [
                        {
                          "created_at": "2017-06-16T13:03:09.000Z",
                          "title": "Amazon to Acquire Whole Foods for $13.7B",
                          "url": "https://www.bloomberg.com/news/articles/2017-06-16/amazon-to-buy-whole-foods?cmpid=socialflow-twitter-business&utm_content=business&utm_campaign=socialflow-organic&utm_source=twitter&utm_medium=social",
                          "author": "whatok",
                          "points": 1687,
                          "story_text": null,
                          "comment_text": null,
                          "num_comments": 824,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1497618189,
                          "relevancy_score": 7487,
                          "_tags": [
                            "story",
                            "author_whatok",
                            "story_14568468"
                          ],
                          "objectID": "14568468",
                          "_highlightResult": {
                            "title": {
                              "value": "Amazon to Acquire Whole <em>Foo</em>ds for $13.7B",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "https://www.bloomberg.com/news/articles/2017-06-16/amazon-to-buy-whole-<em>foo</em>ds?cmpid=socialflow-twitter-business&utm_content=business&utm_campaign=socialflow-organic&utm_source=twitter&utm_medium=social",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "author": {
                              "value": "whatok",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        },
                        {
                          "created_at": "2011-09-23T13:24:09.000Z",
                          "title": "I was once a Facebook fool",
                          "url": "http://public.numair.com/2011_fbfool.html",
                          "author": "numair",
                          "points": 1368,
                          "story_text": "",
                          "comment_text": null,
                          "num_comments": 168,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1316784249,
                          "relevancy_score": 3469,
                          "_tags": [
                            "story",
                            "author_numair",
                            "story_3029872"
                          ],
                          "objectID": "3029872",
                          "_highlightResult": {
                            "title": {
                              "value": "I was once a Facebook <em>foo</em>l",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "http://public.numair.com/2011_fbfool.html",
                              "matchLevel": "none",
                              "matchedWords": []
                            },
                            "author": {
                              "value": "numair",
                              "matchLevel": "none",
                              "matchedWords": []
                            },
                            "story_text": {
                              "value": "",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        },
                        {
                          "created_at": "2019-04-01T11:48:38.000Z",
                          "title": "Burger King is introducing a vegetarian patty from the start-up Impossible Foods",
                          "url": "https://www.nytimes.com/2019/04/01/technology/burger-king-impossible-whopper.html",
                          "author": "charliepark",
                          "points": 848,
                          "story_text": null,
                          "comment_text": null,
                          "num_comments": 637,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1554119318,
                          "relevancy_score": 8750,
                          "_tags": [
                            "story",
                            "author_charliepark",
                            "story_19542379"
                          ],
                          "objectID": "19542379",
                          "_highlightResult": {
                            "title": {
                              "value": "Burger King is introducing a vegetarian patty from the start-up Impossible <em>Foo</em>ds",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "https://www.nytimes.com/2019/04/01/technology/burger-king-impossible-whopper.html",
                              "matchLevel": "none",
                              "matchedWords": []
                            },
                            "author": {
                              "value": "charliepark",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        },
                        {
                          "created_at": "2018-05-10T22:58:15.000Z",
                          "title": "Emails Show FDA Chemists Have Been Finding Glyphosate in Food",
                          "url": "https://modernfarmer.com/2018/05/emails-show-fda-chemists-have-been-quietly-finding-glyphosate-in-food/",
                          "author": "clumsysmurf",
                          "points": 691,
                          "story_text": null,
                          "comment_text": null,
                          "num_comments": 316,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1525993095,
                          "relevancy_score": 8119,
                          "_tags": [
                            "story",
                            "author_clumsysmurf",
                            "story_17043629"
                          ],
                          "objectID": "17043629",
                          "_highlightResult": {
                            "title": {
                              "value": "Emails Show FDA Chemists Have Been Finding Glyphosate in <em>Foo</em>d",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "https://modernfarmer.com/2018/05/emails-show-fda-chemists-have-been-quietly-finding-glyphosate-in-<em>foo</em>d/",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "author": {
                              "value": "clumsysmurf",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        },
                        {
                          "created_at": "2019-07-26T18:59:17.000Z",
                          "title": "How is China able to provide enough food to feed over 1B people?",
                          "url": "https://www.quora.com/How-is-China-able-to-provide-enough-food-to-feed-its-population-of-over-1-billion-people-Do-they-import-food-or-are-they-self-sustainable?share=1",
                          "author": "carapace",
                          "points": 594,
                          "story_text": null,
                          "comment_text": null,
                          "num_comments": 330,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1564167557,
                          "relevancy_score": 8966,
                          "_tags": [
                            "story",
                            "author_carapace",
                            "story_20537409"
                          ],
                          "objectID": "20537409",
                          "_highlightResult": {
                            "title": {
                              "value": "How is China able to provide enough <em>foo</em>d to feed over 1B people?",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "https://www.quora.com/How-is-China-able-to-provide-enough-<em>foo</em>d-to-feed-its-population-of-over-1-billion-people-Do-they-import-<em>foo</em>d-or-are-they-self-sustainable?share=1",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "author": {
                              "value": "carapace",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        },
                        {
                          "created_at": "2015-04-01T06:49:10.000Z",
                          "title": "List of April Fools' Day Announcements",
                          "url": null,
                          "author": "conroy",
                          "points": 592,
                          "story_text": "Instead of cluttering the front page with fake product announcements, let&#x27;s just post them in here instead. One thread where each top-level comment is just a title and a link.",
                          "comment_text": null,
                          "num_comments": 538,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1427870950,
                          "relevancy_score": 5942,
                          "_tags": [
                            "story",
                            "author_conroy",
                            "story_9302010"
                          ],
                          "objectID": "9302010",
                          "_highlightResult": {
                            "title": {
                              "value": "List of April <em>Foo</em>ls' Day Announcements",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "author": {
                              "value": "conroy",
                              "matchLevel": "none",
                              "matchedWords": []
                            },
                            "story_text": {
                              "value": "Instead of cluttering the front page with fake product announcements, let's just post them in here instead. One thread where each top-level comment is just a title and a link.",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        },
                        {
                          "created_at": "2015-08-10T01:52:23.000Z",
                          "title": "Ask HN: I will help your startup in exchange for food and a place to stay",
                          "url": null,
                          "author": "codeornocode",
                          "points": 584,
                          "story_text": "Hello,<p>This my third and final time posting this post, first time it was labeled as spam and the second time someone suggested that i edit it and so i did.<p>I have 4 years remaining in my U.S visa, each visit i can stay 6 months, i don&#x27;t want to break any U.S rules that&#x27;s why i want to code for your startup for no money, just food and a place to live in transportation would be nice too but i am not going to take money from you and i am not going to ask your for health insurance or be your employee, i don&#x27;t want to break any rules, i have +8 years of experience in JS, PHP, Ruby mainly as a full stack web developer i also do game development using Unity3D + C#, i&#x27;m a Musician since over 15 years at my free time and i can design sounds and soundtracks i work with many DAWs, i&#x27;m bilingual i speak fluent Arabic and English beside having many more skills.<p>I am doing this because i live in a war torn country, some issues happened and i&#x27;ve lost all my savings, I&#x27;m 31 years old and i don&#x27;t want to spend the rest of my life in this place, i&#x27;ve been to California in 2014 and i loved it so much, i can&#x27;t get an H1B visa because i don&#x27;t have a university degree although i have a high school diploma and a college diploma in business management and e-commerce.<p>If you&#x27;d like to interview me please send me an e-mail to life.will.get.better.2016@gmail.com, thank you.<p>Thank you for reading my post.<p>ps: Please if you can&#x27;t help me at least try not to be negative in the comments i already have enough negativity going on in my life and i could really really use some motivation, but after all you are free to write whatever you want of course and i appreciate it.<p>One more thing, thank you &quot;dang&quot; for telling me about the spam filter and helping me.",
                          "comment_text": null,
                          "num_comments": 279,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1439171543,
                          "relevancy_score": 6197,
                          "_tags": [
                            "story",
                            "author_codeornocode",
                            "story_10032299",
                            "ask_hn"
                          ],
                          "objectID": "10032299",
                          "_highlightResult": {
                            "title": {
                              "value": "Ask HN: I will help your startup in exchange for <em>foo</em>d and a place to stay",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "author": {
                              "value": "codeornocode",
                              "matchLevel": "none",
                              "matchedWords": []
                            },
                            "story_text": {
                              "value": "Hello,<p>This my third and final time posting this post, first time it was labeled as spam and the second time someone suggested that i edit it and so i did.<p>I have 4 years remaining in my U.S visa, each visit i can stay 6 months, i don't want to break any U.S rules that's why i want to code for your startup for no money, just <em>foo</em>d and a place to live in transportation would be nice too but i am not going to take money from you and i am not going to ask your for health insurance or be your employee, i don't want to break any rules, i have +8 years of experience in JS, PHP, Ruby mainly as a full stack web developer i also do game development using Unity3D + C#, i'm a Musician since over 15 years at my free time and i can design sounds and soundtracks i work with many DAWs, i'm bilingual i speak fluent Arabic and English beside having many more skills.<p>I am doing this because i live in a war torn country, some issues happened and i've lost all my savings, I'm 31 years old and i don't want to spend the rest of my life in this place, i've been to California in 2014 and i loved it so much, i can't get an H1B visa because i don't have a university degree although i have a high school diploma and a college diploma in business management and e-commerce.<p>If you'd like to interview me please send me an e-mail to life.will.get.better.2016@gmail.com, thank you.<p>Thank you for reading my post.<p>ps: Please if you can't help me at least try not to be negative in the comments i already have enough negativity going on in my life and i could really really use some motivation, but after all you are free to write whatever you want of course and i appreciate it.<p>One more thing, thank you &quot;dang&quot; for telling me about the spam filter and helping me.",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            }
                          }
                        },
                        {
                          "created_at": "2017-11-26T17:43:46.000Z",
                          "title": "Facebook Is the Junk Food of Socializing (2015)",
                          "url": "http://nautil.us/blog/why-facebook-is-the-junk-food-of-socializing",
                          "author": "dnetesn",
                          "points": 571,
                          "story_text": null,
                          "comment_text": null,
                          "num_comments": 200,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1511718226,
                          "relevancy_score": 7796,
                          "_tags": [
                            "story",
                            "author_dnetesn",
                            "story_15782014"
                          ],
                          "objectID": "15782014",
                          "_highlightResult": {
                            "title": {
                              "value": "Facebook Is the Junk <em>Foo</em>d of Socializing (2015)",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "http://nautil.us/blog/why-facebook-is-the-junk-<em>foo</em>d-of-socializing",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "author": {
                              "value": "dnetesn",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        },
                        {
                          "created_at": "2019-04-13T14:20:12.000Z",
                          "title": "South Korea now recycles 95% of its food waste",
                          "url": "https://www.weforum.org/agenda/2019/04/south-korea-recycling-food-waste/",
                          "author": "okket",
                          "points": 538,
                          "story_text": null,
                          "comment_text": null,
                          "num_comments": 163,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1555165212,
                          "relevancy_score": 8764,
                          "_tags": [
                            "story",
                            "author_okket",
                            "story_19653138"
                          ],
                          "objectID": "19653138",
                          "_highlightResult": {
                            "title": {
                              "value": "South Korea now recycles 95% of its <em>foo</em>d waste",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "https://www.weforum.org/agenda/2019/04/south-korea-recycling-<em>foo</em>d-waste/",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "author": {
                              "value": "okket",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        },
                        {
                          "created_at": "2020-03-28T15:24:37.000Z",
                          "title": "From Spain to Germany, farmers warn of fresh food shortages",
                          "url": "https://www.bloomberg.com/news/articles/2020-03-27/from-spain-to-germany-farmers-warn-of-fresh-food-shortages",
                          "author": "montalbano",
                          "points": 464,
                          "story_text": null,
                          "comment_text": null,
                          "num_comments": 567,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1585409077,
                          "_tags": [
                            "story",
                            "author_montalbano",
                            "story_22711661"
                          ],
                          "objectID": "22711661",
                          "_highlightResult": {
                            "title": {
                              "value": "From Spain to Germany, farmers warn of fresh <em>foo</em>d shortages",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "https://www.bloomberg.com/news/articles/2020-03-27/from-spain-to-germany-farmers-warn-of-fresh-<em>foo</em>d-shortages",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "author": {
                              "value": "montalbano",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        },
                        {
                          "created_at": "2019-10-21T10:28:23.000Z",
                          "title": "Amazon is shipping expired food, customers say",
                          "url": "https://www.cnbc.com/2019/10/20/amazon-is-shipping-expired-baby-formula-and-other-out-of-date-foods.html",
                          "author": "rahuldottech",
                          "points": 464,
                          "story_text": null,
                          "comment_text": null,
                          "num_comments": 217,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1571653703,
                          "_tags": [
                            "story",
                            "author_rahuldottech",
                            "story_21310697"
                          ],
                          "objectID": "21310697",
                          "_highlightResult": {
                            "title": {
                              "value": "Amazon is shipping expired <em>foo</em>d, customers say",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "https://www.cnbc.com/2019/10/20/amazon-is-shipping-expired-baby-formula-and-other-out-of-date-<em>foo</em>ds.html",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "author": {
                              "value": "rahuldottech",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        },
                        {
                          "created_at": "2014-04-01T11:18:05.000Z",
                          "title": "The crushing lameness of April Fools Day on the Internet.",
                          "url": "",
                          "author": "hoodoof",
                          "points": 449,
                          "story_text": "I have a sense of humor.  Really I do.<p>I just don&#x27;t find being pounded with systematic absurdity for an entire day every year as being very funny.<p>I don&#x27;t know how to solve it.  It seems every single company and publication that communicates via the web has a corporate communications department or something that thinks it&#x27;s a corporate priority to come out with something for April Fools. The Internet systematizes, amplifies, focuses, fully resources, funds, schedules, plans and implements high production value foolery.  Corporate drone: &quot;Larry, Sergey, have you signed off yet on this years $4M April Fools budget? How are we going to attract and recruit the best engineers unless we&#x27;ve got a reputation for the very best and most foolish April Fools trickery?&quot; Ugh.<p>It&#x27;s just kind of silly and boring and makes we wish April 2 would come as soon as possible. As I read the Internet on April 1 I just try to self filter out all the silly unbelievable garbage. Most news sites (including HN) are hardly worth reading April 1.<p>You know when someone who thinks they are funny insists on telling lame jokes, and the audience feels an obligation to give an acknowledging guffaw? It&#x27;s like an whole Internet day worth of that.<p>I feel like the Grinch Who Stole April Fools but really it has to be said.  If you&#x27;ve got it in mind to do some fine ol&#x27; foolin then maybe the classy thing to do is leave the foolin to others and spare us one more depressingly lame absurdity.",
                          "comment_text": null,
                          "num_comments": 170,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1396351085,
                          "relevancy_score": 5243,
                          "_tags": [
                            "story",
                            "author_hoodoof",
                            "story_7507297"
                          ],
                          "objectID": "7507297",
                          "_highlightResult": {
                            "title": {
                              "value": "The crushing lameness of April <em>Foo</em>ls Day on the Internet.",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "",
                              "matchLevel": "none",
                              "matchedWords": []
                            },
                            "author": {
                              "value": "hoodoof",
                              "matchLevel": "none",
                              "matchedWords": []
                            },
                            "story_text": {
                              "value": "I have a sense of humor.  Really I do.<p>I just don't find being pounded with systematic absurdity for an entire day every year as being very funny.<p>I don't know how to solve it.  It seems every single company and publication that communicates via the web has a corporate communications department or something that thinks it's a corporate priority to come out with something for April <em>Foo</em>ls. The Internet systematizes, amplifies, focuses, fully resources, funds, schedules, plans and implements high production value <em>foo</em>lery.  Corporate drone: &quot;Larry, Sergey, have you signed off yet on this years $4M April <em>Foo</em>ls budget? How are we going to attract and recruit the best engineers unless we've got a reputation for the very best and most <em>foo</em>lish April <em>Foo</em>ls trickery?&quot; Ugh.<p>It's just kind of silly and boring and makes we wish April 2 would come as soon as possible. As I read the Internet on April 1 I just try to self filter out all the silly unbelievable garbage. Most news sites (including HN) are hardly worth reading April 1.<p>You know when someone who thinks they are funny insists on telling lame jokes, and the audience feels an obligation to give an acknowledging guffaw? It's like an whole Internet day worth of that.<p>I feel like the Grinch Who Stole April <em>Foo</em>ls but really it has to be said.  If you've got it in mind to do some fine ol' <em>foo</em>lin then maybe the classy thing to do is leave the <em>foo</em>lin to others and spare us one more depressingly lame absurdity.",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            }
                          }
                        },
                        {
                          "created_at": "2016-07-11T04:58:13.000Z",
                          "title": "How we're scammed into eating phony food",
                          "url": "http://nypost.com/2016/07/10/the-truth-behind-how-were-scammed-into-eating-phony-food/",
                          "author": "apsec112",
                          "points": 439,
                          "story_text": null,
                          "comment_text": null,
                          "num_comments": 458,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1468213093,
                          "relevancy_score": 6842,
                          "_tags": [
                            "story",
                            "author_apsec112",
                            "story_12068983"
                          ],
                          "objectID": "12068983",
                          "_highlightResult": {
                            "title": {
                              "value": "How we're scammed into eating phony <em>foo</em>d",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "http://nypost.com/2016/07/10/the-truth-behind-how-were-scammed-into-eating-phony-<em>foo</em>d/",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "author": {
                              "value": "apsec112",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        },
                        {
                          "created_at": "2011-03-09T14:56:05.000Z",
                          "title": "Sleep is more important than food",
                          "url": "http://blogs.hbr.org/schwartz/2011/03/sleep-is-more-important-than-f.html",
                          "author": "panarky",
                          "points": 437,
                          "story_text": "",
                          "comment_text": null,
                          "num_comments": 169,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1299682565,
                          "relevancy_score": 3092,
                          "_tags": [
                            "story",
                            "author_panarky",
                            "story_2305001"
                          ],
                          "objectID": "2305001",
                          "_highlightResult": {
                            "title": {
                              "value": "Sleep is more important than <em>foo</em>d",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "http://blogs.hbr.org/schwartz/2011/03/sleep-is-more-important-than-f.html",
                              "matchLevel": "none",
                              "matchedWords": []
                            },
                            "author": {
                              "value": "panarky",
                              "matchLevel": "none",
                              "matchedWords": []
                            },
                            "story_text": {
                              "value": "",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        },
                        {
                          "created_at": "2017-08-31T16:35:00.000Z",
                          "title": "ESPN Football Analyst Walks Away, Disturbed by Brain Trauma on Field",
                          "url": "https://www.nytimes.com/2017/08/30/sports/espn-ed-cunningham-football-concussions.html",
                          "author": "daegloe",
                          "points": 436,
                          "story_text": null,
                          "comment_text": null,
                          "num_comments": 383,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1504197300,
                          "relevancy_score": 7635,
                          "_tags": [
                            "story",
                            "author_daegloe",
                            "story_15141495"
                          ],
                          "objectID": "15141495",
                          "_highlightResult": {
                            "title": {
                              "value": "ESPN <em>Foo</em>tball Analyst Walks Away, Disturbed by Brain Trauma on Field",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "https://www.nytimes.com/2017/08/30/sports/espn-ed-cunningham-<em>foo</em>tball-concussions.html",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "author": {
                              "value": "daegloe",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        },
                        {
                          "created_at": "2018-09-06T21:43:25.000Z",
                          "title": "Whole Foods workers seek to unionize",
                          "url": "https://techcrunch.com/2018/09/06/whole-foods-workers-seek-to-unionize-says-amazon-is-exploiting-our-dedication/",
                          "author": "deegles",
                          "points": 433,
                          "story_text": null,
                          "comment_text": null,
                          "num_comments": 391,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1536270205,
                          "relevancy_score": 8347,
                          "_tags": [
                            "story",
                            "author_deegles",
                            "story_17929840"
                          ],
                          "objectID": "17929840",
                          "_highlightResult": {
                            "title": {
                              "value": "Whole <em>Foo</em>ds workers seek to unionize",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "https://techcrunch.com/2018/09/06/whole-<em>foo</em>ds-workers-seek-to-unionize-says-amazon-is-exploiting-our-dedication/",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "author": {
                              "value": "deegles",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        },
                        {
                          "created_at": "2016-04-18T16:26:44.000Z",
                          "title": "Thermal camera footage allegedly shows pro cyclists using motors",
                          "url": "http://fittish.deadspin.com/secret-thermal-camera-footage-allegedly-shows-seven-pro-1771492666",
                          "author": "phreeza",
                          "points": 432,
                          "story_text": null,
                          "comment_text": null,
                          "num_comments": 298,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1460996804,
                          "relevancy_score": 6681,
                          "_tags": [
                            "story",
                            "author_phreeza",
                            "story_11521113"
                          ],
                          "objectID": "11521113",
                          "_highlightResult": {
                            "title": {
                              "value": "Thermal camera <em>foo</em>tage allegedly shows pro cyclists using motors",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "http://fittish.deadspin.com/secret-thermal-camera-<em>foo</em>tage-allegedly-shows-seven-pro-1771492666",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "author": {
                              "value": "phreeza",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        },
                        {
                          "created_at": "2017-04-04T14:51:41.000Z",
                          "title": "Reddit’s April Fools’ experiment",
                          "url": "https://arstechnica.com/gaming/2017/04/in-memoriam-reddits-72-hour-live-graffiti-wall-as-a-social-experiment/",
                          "author": "camtarn",
                          "points": 430,
                          "story_text": null,
                          "comment_text": null,
                          "num_comments": 275,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1491317501,
                          "relevancy_score": 7353,
                          "_tags": [
                            "story",
                            "author_camtarn",
                            "story_14033216"
                          ],
                          "objectID": "14033216",
                          "_highlightResult": {
                            "title": {
                              "value": "Reddit’s April <em>Foo</em>ls’ experiment",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "https://arstechnica.com/gaming/2017/04/in-memoriam-reddits-72-hour-live-graffiti-wall-as-a-social-experiment/",
                              "matchLevel": "none",
                              "matchedWords": []
                            },
                            "author": {
                              "value": "camtarn",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        },
                        {
                          "created_at": "2011-02-04T21:30:58.000Z",
                          "title": "Aerial footage of uncontacted Amazon tribe",
                          "url": "http://www.uncontactedtribes.org/brazilfootage",
                          "author": "timf",
                          "points": 418,
                          "story_text": "",
                          "comment_text": null,
                          "num_comments": 363,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1296855058,
                          "relevancy_score": 3025,
                          "_tags": [
                            "story",
                            "author_timf",
                            "story_2181315"
                          ],
                          "objectID": "2181315",
                          "_highlightResult": {
                            "title": {
                              "value": "Aerial <em>foo</em>tage of uncontacted Amazon tribe",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "http://www.uncontactedtribes.org/brazilfootage",
                              "matchLevel": "none",
                              "matchedWords": []
                            },
                            "author": {
                              "value": "timf",
                              "matchLevel": "none",
                              "matchedWords": []
                            },
                            "story_text": {
                              "value": "",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        },
                        {
                          "created_at": "2017-02-17T16:18:16.000Z",
                          "title": "Dole Food Had Too Many Shares",
                          "url": "https://www.bloomberg.com/view/articles/2017-02-17/dole-food-had-too-many-shares",
                          "author": "ot",
                          "points": 418,
                          "story_text": null,
                          "comment_text": null,
                          "num_comments": 170,
                          "story_id": null,
                          "story_title": null,
                          "story_url": null,
                          "parent_id": null,
                          "created_at_i": 1487348296,
                          "relevancy_score": 7259,
                          "_tags": [
                            "story",
                            "author_ot",
                            "story_13669315"
                          ],
                          "objectID": "13669315",
                          "_highlightResult": {
                            "title": {
                              "value": "Dole <em>Foo</em>d Had Too Many Shares",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "url": {
                              "value": "https://www.bloomberg.com/view/articles/2017-02-17/dole-<em>foo</em>d-had-too-many-shares",
                              "matchLevel": "full",
                              "fullyHighlighted": false,
                              "matchedWords": [
                                "foo"
                              ]
                            },
                            "author": {
                              "value": "ot",
                              "matchLevel": "none",
                              "matchedWords": []
                            }
                          }
                        }
                      ],
                      "nbHits": 35759,
                      "page": 0,
                      "nbPages": 50,
                      "hitsPerPage": 20,
                      "exhaustiveNbHits": true,
                      "query": "foo",
                      "params": "advancedSyntax=true&analytics=true&analyticsTags=backend&query=foo&tags=%28story%2Cjob%2Cpoll%29",
                      "processingTimeMS": 20
                    }
                    """#
                    .data(using: .utf8)!
                completionHandler(.success((jsonData, HTTPURLResponse())))
            } else if endpoint.url?.absoluteString == "https://hn.algolia.com/api/v1/items/1" {
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
                completionHandler(.success((jsonData, HTTPURLResponse())))
            } else if endpoint.url?.absoluteString == "https://news.ycombinator.com/item?id=1" {
                let htmlData = #"""
                    <html op="item"><head><meta name="referrer" content="origin"><meta name="viewport" content="width=device-width, initial-scale=1.0"><link rel="stylesheet" type="text/css" href="news.css?y8aWzq4VWgqzCJyK51Vk">
                            <link rel="shortcut icon" href="favicon.ico">
                            <title>Y Combinator | Hacker News</title></head><body><center><table id="hnmain" border="0" cellpadding="0" cellspacing="0" width="85%" bgcolor="#f6f6ef">
                            <tr><td bgcolor="#ff6600"><table border="0" cellpadding="0" cellspacing="0" width="100%" style="padding:2px"><tr><td style="width:18px;padding-right:4px"><a href="https://news.ycombinator.com"><img src="y18.gif" width="18" height="18" style="border:1px white solid;"></a></td>
                                      <td style="line-height:12pt; height:10px;"><span class="pagetop"><b class="hnname"><a href="news">Hacker News</a></b>
                                  <a href="newest">new</a> | <a href="threads?id=hntestacc">threads</a> | <a href="front">past</a> | <a href="newcomments">comments</a> | <a href="ask">ask</a> | <a href="show">show</a> | <a href="jobs">jobs</a> | <a href="submit">submit</a>            </span></td><td style="text-align:right;padding-right:4px;"><span class="pagetop">
                                                  <a id='me' href="user?id=hntestacc">hntestacc</a>                (1) |
                                    <a id='logout' href="logout?auth=6ddbe2f9205c3aef7269824b9b6ad2a5d5a684c1&amp;goto=item%3Fid%3D1">logout</a>                          </span></td>
                                  </tr></table></td></tr>
                    <tr id="pagespace" title="Y Combinator" style="height:10px"></tr><tr><td><table class="fatitem" border="0">
                            <tr class='athing' id='1'>
                          <td align="right" valign="top" class="title"><span class="rank"></span></td>      <td valign="top" class="votelinks"><center><a id='up_1' onclick='return vote(event, this, "up")' href='vote?id=1&amp;how=up&amp;auth=6b3a83dd1ed1672bde24242367f6429f5377b23e&amp;goto=item%3Fid%3D1'><div class='votearrow' title='upvote'></div></a></center></td><td class="title"><a href="http://ycombinator.com" class="storylink">Y Combinator</a><span class="sitebit comhead"> (<a href="from?site=ycombinator.com"><span class="sitestr">ycombinator.com</span></a>)</span></td></tr><tr><td colspan="2"></td><td class="subtext">
                            <span class="score" id="score_1">57 points</span> by <a href="user?id=pg" class="hnuser">pg</a> <span class="age"><a href="item?id=1">on Oct 9, 2006</a></span> <span id="unv_1"></span> | <a href="hide?id=1&amp;auth=6b3a83dd1ed1672bde24242367f6429f5377b23e&amp;goto=item%3Fid%3D1">hide</a> | <a href="https://hn.algolia.com/?query=Y%20Combinator&sort=byDate&dateRange=all&type=story&storyText=false&prefix&page=0" class="hnpast">past</a> | <a href="https://www.google.com/search?q=Y%20Combinator">web</a> | <a href="fave?id=1&amp;auth=6b3a83dd1ed1672bde24242367f6429f5377b23e">favorite</a> | <a href="item?id=1">19&nbsp;comments</a>              </td></tr>
                            </table><br><br>
                      <table border="0" class='comment-tree'>
                                <tr class='athing comtr ' id='15'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="0"></td><td valign="top" class="votelinks"><center><a id='up_15' onclick='return vote(event, this, "up")' href='vote?id=15&amp;how=up&amp;auth=ac3e098260a5b7b36ea85b30fa7c73659c50517a&amp;goto=item%3Fid%3D1#15' class='nosee'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=sama" class="hnuser">sama</a> <span class="age"><a href="item?id=15">on Oct 9, 2006</a></span> <span id="unv_15"> | <a id='un_15' onclick='return vote(event, this, "un")' href='vote?id=15&amp;how=un&amp;auth=ac3e098260a5b7b36ea85b30fa7c73659c50517a&amp;goto=item%3Fid%3D1#15'>unvote</a></span><span class="par"></span> <a class="togg" n="3" href="javascript:void(0)" onclick="return toggle(event, 15)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">&#34;the rising star of venture capital&#34; -unknown VC eating lunch on SHR</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='17'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="40"></td><td valign="top" class="votelinks"><center><a id='up_17' onclick='return vote(event, this, "up")' href='vote?id=17&amp;how=up&amp;auth=be985ad57bbc9341c6ad15517c2d502c45b968dc&amp;goto=item%3Fid%3D1#17'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=pg" class="hnuser">pg</a> <span class="age"><a href="item?id=17">on Oct 9, 2006</a></span> <span id="unv_17"></span><span class="par"></span> <a class="togg" n="2" href="javascript:void(0)" onclick="return toggle(event, 17)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">Is there anywhere to eat on Sandhill Road?</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='1079'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="80"></td><td valign="top" class="votelinks"><center><a id='up_1079' onclick='return vote(event, this, "up")' href='vote?id=1079&amp;how=up&amp;auth=beba6e283e6f6adbc05bfbb507996a8e361b8975&amp;goto=item%3Fid%3D1#1079'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=dmon" class="hnuser">dmon</a> <span class="age"><a href="item?id=1079">on Feb 25, 2007</a></span> <span id="unv_1079"></span><span class="par"></span> <a class="togg" n="1" href="javascript:void(0)" onclick="return toggle(event, 1079)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">sure</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                                      <tr class='athing comtr ' id='234509'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="0"></td><td valign="top" class="votelinks"><center><a id='up_234509' onclick='return vote(event, this, "up")' href='vote?id=234509&amp;how=up&amp;auth=f467e89792d6ccad7f1ace08aa70f9a12cd167a1&amp;goto=item%3Fid%3D1#234509'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=kleevr" class="hnuser">kleevr</a> <span class="age"><a href="item?id=234509">on July 2, 2008</a></span> <span id="unv_234509"></span><span class="par"></span> <a class="togg" n="11" href="javascript:void(0)" onclick="return toggle(event, 234509)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">sequential numbering
                      I must be bored</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='234621'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="40"></td><td valign="top" class="votelinks"><center><a id='up_234621' onclick='return vote(event, this, "up")' href='vote?id=234621&amp;how=up&amp;auth=9e2e0f4ddb11af0945922f7d4a157c58a79e3283&amp;goto=item%3Fid%3D1#234621'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=kleevr" class="hnuser">kleevr</a> <span class="age"><a href="item?id=234621">on July 2, 2008</a></span> <span id="unv_234621"></span><span class="par"></span> <a class="togg" n="1" href="javascript:void(0)" onclick="return toggle(event, 234621)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">I guess that news.yc is 1-indexed :)<p><a href="http://news.ycombinator.com/item?id=0" rel="nofollow">http://news.ycombinator.com/item?id=0</a> , DNE</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                        <tr class='athing comtr ' id='234560'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="40"></td><td valign="top" class="votelinks"><center><a id='up_234560' onclick='return vote(event, this, "up")' href='vote?id=234560&amp;how=up&amp;auth=2aa94b8a1a8d87bd29f0734484de5716bb1c8b4f&amp;goto=item%3Fid%3D1#234560'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=sebg" class="hnuser">sebg</a> <span class="age"><a href="item?id=234560">on July 2, 2008</a></span> <span id="unv_234560"></span><span class="par"></span> <a class="togg" n="4" href="javascript:void(0)" onclick="return toggle(event, 234560)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">Interesting - post 1 has comments.  no more comments until post 15.  which then has the same conversation between pg and dnom as the first post.  To top it off, post 17 is the conversation in posts 1 and 15.</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='234593'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="80"></td><td valign="top" class="votelinks"><center><a id='up_234593' onclick='return vote(event, this, "up")' href='vote?id=234593&amp;how=up&amp;auth=01f7db276ccd10e0fc8f449ca4055ddc5077fbc1&amp;goto=item%3Fid%3D1#234593'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=kleevr" class="hnuser">kleevr</a> <span class="age"><a href="item?id=234593">on July 2, 2008</a></span> <span id="unv_234593"></span><span class="par"></span> <a class="togg" n="1" href="javascript:void(0)" onclick="return toggle(event, 234593)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">I'm sure the first fifteen were used primarily to populate the burgeoning news.yc</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                        <tr class='athing comtr ' id='234568'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="80"></td><td valign="top" class="votelinks"><center><a id='up_234568' onclick='return vote(event, this, "up")' href='vote?id=234568&amp;how=up&amp;auth=62ed17641aa9754c1921493cb9d6d93d0652d6c7&amp;goto=item%3Fid%3D1#234568'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=byrneseyeview" class="hnuser">byrneseyeview</a> <span class="age"><a href="item?id=234568">on July 2, 2008</a></span> <span id="unv_234568"></span><span class="par"></span> <a class="togg" n="2" href="javascript:void(0)" onclick="return toggle(event, 234568)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">I think those 'items' are comments, not posts.</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='234633'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="120"></td><td valign="top" class="votelinks"><center><a id='up_234633' onclick='return vote(event, this, "up")' href='vote?id=234633&amp;how=up&amp;auth=896d4824a5db0a03ef10f2deb5e414cd43383f8f&amp;goto=item%3Fid%3D1#234633'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=kleevr" class="hnuser">kleevr</a> <span class="age"><a href="item?id=234633">on July 2, 2008</a></span> <span id="unv_234633"></span><span class="par"></span> <a class="togg" n="1" href="javascript:void(0)" onclick="return toggle(event, 234633)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">items: comments || posts...
                    they're also arranged in a hierarchy...</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='234548'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="40"></td><td valign="top" class="votelinks"><center><a id='up_234548' onclick='return vote(event, this, "up")' href='vote?id=234548&amp;how=up&amp;auth=74141c432dedccf27f7d7e091be2023b55b036b8&amp;goto=item%3Fid%3D1#234548'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=byrneseyeview" class="hnuser">byrneseyeview</a> <span class="age"><a href="item?id=234548">on July 2, 2008</a></span> <span id="unv_234548"></span><span class="par"></span> <a class="togg" n="5" href="javascript:void(0)" onclick="return toggle(event, 234548)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">I think I agree?</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='234549'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="80"></td><td valign="top" class="votelinks"><center><a id='up_234549' onclick='return vote(event, this, "up")' href='vote?id=234549&amp;how=up&amp;auth=381e0fe299e138a3852c3fd899ba1471b5cf61d8&amp;goto=item%3Fid%3D1#234549'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=kf" class="hnuser">kf</a> <span class="age"><a href="item?id=234549">on July 2, 2008</a></span> <span id="unv_234549"></span><span class="par"></span> <a class="togg" n="4" href="javascript:void(0)" onclick="return toggle(event, 234549)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">i hear that there is an awesome easter egg in the -100s somewhere</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='234551'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="120"></td><td valign="top" class="votelinks"><center><a id='up_234551' onclick='return vote(event, this, "up")' href='vote?id=234551&amp;how=up&amp;auth=f5efd3b111d6962e98e29f7ca6391298efc39a2f&amp;goto=item%3Fid%3D1#234551'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=byrneseyeview" class="hnuser">byrneseyeview</a> <span class="age"><a href="item?id=234551">on July 2, 2008</a></span> <span id="unv_234551"></span><span class="par"></span> <a class="togg" n="3" href="javascript:void(0)" onclick="return toggle(event, 234551)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">How many people are lurking on this thread?</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='234567'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="160"></td><td valign="top" class="votelinks"><center><a id='up_234567' onclick='return vote(event, this, "up")' href='vote?id=234567&amp;how=up&amp;auth=54c266dbe8641fcac9f304217083792bb8f20cdd&amp;goto=item%3Fid%3D1#234567'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=kf" class="hnuser">kf</a> <span class="age"><a href="item?id=234567">on July 2, 2008</a></span> <span id="unv_234567"></span><span class="par"></span> <a class="togg" n="2" href="javascript:void(0)" onclick="return toggle(event, 234567)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">it's the new comments page for me...</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                            <tr class='athing comtr ' id='234580'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="200"></td><td valign="top" class="votelinks"><center><a id='up_234580' onclick='return vote(event, this, "up")' href='vote?id=234580&amp;how=up&amp;auth=41e46ab47759d8cac85365bb5f8b0fbb2f267414&amp;goto=item%3Fid%3D1#234580'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=sebg" class="hnuser">sebg</a> <span class="age"><a href="item?id=234580">on July 2, 2008</a></span> <span id="unv_234580"></span><span class="par"></span> <a class="togg" n="1" href="javascript:void(0)" onclick="return toggle(event, 234580)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">ditto.  (thanks for pointing out posts vs. items.)</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                                            <tr class='athing comtr ' id='487171'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="0"></td><td valign="top" class="votelinks"><center><a id='up_487171' onclick='return vote(event, this, "up")' href='vote?id=487171&amp;how=up&amp;auth=3b25f6f392bada7b7c316802103ff0a6b70c4530&amp;goto=item%3Fid%3D1#487171'><div class='votearrow' title='upvote'></div></a></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=jacquesm" class="hnuser">jacquesm</a> <span class="age"><a href="item?id=487171">on Feb 19, 2009</a></span> <span id="unv_487171"></span><span class="par"></span> <a class="togg" n="1" href="javascript:void(0)" onclick="return toggle(event, 487171)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext c00">So, just to see how hard it is to make the longest span between article and comment :)<p>Congratulations on your second birthday YC, and thanks to Paul Graham for writing this forum. I had a really good look at the good a few days ago and I was quite impressed with how elegant the whole thing is put together.<p>Lisp would not be my language of choice for a website like this, and yet, after seeing how concise it was I'm tempted to play around with lisp in a web environment.</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                                  <tr class='athing comtr ' id='454426'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="0"></td><td valign="top" class="votelinks"><center><img src="s.gif" height="1" width="14"></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=Arrington" class="hnuser">Arrington</a> <span class="age"><a href="item?id=454426">on Jan 28, 2009</a></span> <span id="unv_454426"></span><span class="par"></span> [dead]  <a class="togg" n="1" href="javascript:void(0)" onclick="return toggle(event, 454426)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext cdd">This is why we can't have nice things.</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                                  <tr class='athing comtr ' id='454424'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="0"></td><td valign="top" class="votelinks"><center><img src="s.gif" height="1" width="14"></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=Arrington" class="hnuser">Arrington</a> <span class="age"><a href="item?id=454424">on Jan 28, 2009</a></span> <span id="unv_454424"></span><span class="par"></span> [dead]  <a class="togg" n="1" href="javascript:void(0)" onclick="return toggle(event, 454424)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext cdd">This is why we can't have nice things.</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                                  <tr class='athing comtr ' id='454410'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="0"></td><td valign="top" class="votelinks"><center><img src="s.gif" height="1" width="14"></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=Arrington" class="hnuser">Arrington</a> <span class="age"><a href="item?id=454410">on Jan 28, 2009</a></span> <span id="unv_454410"></span><span class="par"></span> [dead]  <a class="togg" n="1" href="javascript:void(0)" onclick="return toggle(event, 454410)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext cdd">This is why we can't have nice things.</span>
                                  <div class='reply'>        <p><font size="1">
                                      </font>
                          </div></div></td></tr>
                          </table></td></tr>
                                  <tr class='athing comtr ' id='82729'><td>
                                <table border='0'>  <tr>    <td class='ind'><img src="s.gif" height="1" width="0"></td><td valign="top" class="votelinks"><center><img src="s.gif" height="1" width="14"></center></td><td class="default"><div style="margin-top:2px; margin-bottom:-10px;"><span class="comhead">
                              <a href="user?id=vice" class="hnuser">vice</a> <span class="age"><a href="item?id=82729">on Nov 22, 2007</a></span> <span id="unv_82729"></span><span class="par"></span> [dead]  <a class="togg" n="1" href="javascript:void(0)" onclick="return toggle(event, 82729)"></a>          <span class='storyon'></span>
                                      </span></div><br><div class="comment">
                                      <span class="commtext cdd">I'm nX 1 too<p>;)
                    </span>
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
                          </table></center></body><script type='text/javascript' src='hn.js?y8aWzq4VWgqzCJyK51Vk'></script></html>
                    """#
                    .data(using: .utf8)!
                completionHandler(.success((htmlData, HTTPURLResponse())))
            } else {
                completionHandler(.failure(Error.unknown))
            }
        }
    }

    let client: APIClient = {
        let client = APIClient()
        client.networkClient = MockClient()
        return client
    }()

    func testLoadingItems() {
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

    func testSearchingItems() {
        client.items(query: "foo") { result in
            guard case let .success(items) = result else {
                XCTFail("Error \(result.failure!) thrown.")
                return
            }
            let item = items[0]
            XCTAssertEqual(item.story?.title, "Amazon to Acquire Whole Foods for $13.7B")
            XCTAssertEqual(item.story?.author, "whatok")
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
                XCTAssertEqual(page.children[0].color, .c00)
                XCTAssertEqual(page.children[4].color, .cdd)
                XCTAssertEqual(page.actions[15]?.count, 0)
                XCTAssertEqual(page.actions[17]?.count, 1)
            }
        }
    }

    // TODO: Add test for login & getting tokens
}
