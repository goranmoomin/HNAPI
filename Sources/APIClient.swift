import Foundation

public class APIClient {
    // MARK: - Error

    public enum APIError: Error {
        case loginFailed
        case actionNotValid
        case unknown
    }

    // MARK: - Properties

    var networkClient: NetworkClient = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.httpShouldSetCookies = false
        return URLSession(configuration: configuration)
    }()

    var networkClientWithoutRedirection: NetworkClient = {
        class Delegate: NSObject, URLSessionTaskDelegate {
            public func urlSession(
                _ session: URLSession, task: URLSessionTask,
                willPerformHTTPRedirection response: HTTPURLResponse,
                newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void
            ) { completionHandler(nil) }
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.httpShouldSetCookies = false
        let delegate = Delegate()
        return URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
    }()

    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()

    // MARK: - Init

    public init() {}

    // MARK: - Top Level Items

    struct QueryResult: Decodable { var hits: [TopLevelItem] }

    public func items(
        ids: [Int], completionHandler: @escaping (Result<[TopLevelItem], Error>) -> Void
    ) {
        networkClient.request(to: .algolia(ids: ids)) { result in
            guard case let .success((data, _)) = result else {
                completionHandler(.failure(result.failure!))
                return
            }
            let itemsResult = Result<[TopLevelItem], Error> {
                let queryResult = try self.decoder.decode(QueryResult.self, from: data)
                let hits = queryResult.hits.sorted { left, right in
                    guard let leftIndex = ids.firstIndex(of: left.id) else { return false }
                    guard let rightIndex = ids.firstIndex(of: right.id) else { return true }
                    return leftIndex < rightIndex
                }
                return hits
            }
            completionHandler(itemsResult)
        }
    }

    public func items(
        query: String, completionHandler: @escaping (Result<[TopLevelItem], Error>) -> Void
    ) {
        networkClient.request(to: .algolia(query: query)) { result in
            guard case let .success((data, _)) = result else {
                completionHandler(.failure(result.failure!))
                return
            }
            let itemsResult = Result<[TopLevelItem], Error> {
                let queryResult = try self.decoder.decode(QueryResult.self, from: data)
                return queryResult.hits
            }
            completionHandler(itemsResult)
        }
    }

    public func items(
        category: Category = .top, count: Int = 30,
        completionHandler: @escaping (Result<[TopLevelItem], Error>) -> Void
    ) {
        networkClient.request(to: .firebase(category: category)) { result in
            guard case let .success((data, _)) = result else {
                completionHandler(.failure(result.failure!))
                return
            }
            do {
                let ids = Array(try self.decoder.decode([Int].self, from: data).prefix(count))
                self.items(ids: ids, completionHandler: completionHandler)
            } catch { completionHandler(.failure(error)) }
        }
    }

    public func topItems(
        count: Int = 30, completionHandler: @escaping (Result<[TopLevelItem], Error>) -> Void
    ) { items(category: .top, count: count, completionHandler: completionHandler) }

    // MARK: - Page

    struct AlgoliaItem: Decodable { var children: [Comment] }

    public func page(
        item: TopLevelItem, token: Token? = nil,
        completionHandler: @escaping (Result<Page, Error>) -> Void
    ) {
        networkClient.request(to: .algolia(id: item.id)) { result in
            guard case let .success((data, _)) = result else {
                completionHandler(.failure(result.failure!))
                return
            }
            do {
                let algoliaItem = try self.decoder.decode(AlgoliaItem.self, from: data)
                var comments = algoliaItem.children
                // TODO: Fetch HN & Algolia API concurrently
                self.networkClient.request(to: .hn(id: item.id, token: token)) { result in
                    guard case let .success((data, _)) = result else {
                        completionHandler(.failure(result.failure!))
                        return
                    }
                    let html = String(data: data, encoding: .utf8)!
                    do {
                        let parser = try StoryParser(html: html)
                        comments = parser.sortedCommentTree(original: comments)
                        let actions = parser.actions()
                        let page = Page(item: item, children: comments, actions: actions)
                        completionHandler(.success(page))
                    } catch { completionHandler(.failure(error)) }
                }
            } catch { completionHandler(.failure(error)) }
        }
    }

    public func execute(
        action: Action, token: Token, page: Page? = nil,
        completionHandler: @escaping (Result<Void, Error>) -> Void
    ) {
        networkClient.request(to: Endpoint(url: action.url, token: token)) { result in
            guard case .success = result else {
                completionHandler(.failure(result.failure!))
                return
            }
            if let (id, actionSet) = page?.actions.first(where: { $0.value.contains(action) }) {
                var newActionSet = actionSet
                newActionSet.remove(action)
                newActionSet.insert(action.inverse)
                page?.actions[id] = newActionSet
            }
            completionHandler(.success(()))
        }
    }

    // MARK: - Authentication

    public func login(
        userName: String, password: String,
        completionHandler: @escaping (Result<Token, Error>) -> Void
    ) {
        networkClientWithoutRedirection.request(to: .hn(userName: userName, password: password)) {
            result in
            guard case let .success((_, response)) = result else {
                completionHandler(.failure(result.failure!))
                return
            }
            // FIXME: Error handling
            let headerFields = response.allHeaderFields as! [String: String]
            let base = URL(string: "https://news.ycombinator.com/")!
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: base)
            if let token = cookies.first(where: { $0.name == "user" }) {
                completionHandler(.success(token))
            } else { completionHandler(.failure(APIError.loginFailed)) }
        }
    }

    // MARK: - Commenting

    public func reply(
        toID id: Int, text: String, token: Token,
        completionHandler: @escaping (Result<Void, Error>) -> Void
    ) {
        networkClient.request(to: .hn(replyToID: id, token: token)) { result in
            guard case let .success((data, _)) = result else {
                completionHandler(.failure(result.failure!))
                return
            }
            let html = String(data: data, encoding: .utf8)!
            do {
                let parser = try CommentConfirmationParser(html: html)
                guard let hmac = parser.hmac() else {
                    completionHandler(.failure(APIError.unknown))
                    return
                }
                self.networkClient.request(
                    to: .hn(replyToID: id, token: token, hmac: hmac, text: text)
                ) { result in
                    guard case .success = result else {
                        completionHandler(.failure(result.failure!))
                        return
                    }
                    completionHandler(.success(()))
                }
            } catch { completionHandler(.failure(error)) }
        }
    }
}
