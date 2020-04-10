import Foundation

class APIClient {
    // MARK: - Properties

    var networkClient: NetworkClient = URLSession.shared
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    // FIXME: How can I just use the OperationQueue provided from the URLSession
    let queue = DispatchQueue(label: "io.pcr910303.HNAPI.APIClientQueue", qos: .userInitiated)

    // MARK: - Top Level Items

    struct QueryResult: Decodable { var hits: [TopLevelItem] }

    func items(ids: [Int], completionHandler: @escaping (Result<[TopLevelItem], Error>) -> Void) {
        networkClient.request(to: .algolia(ids: ids)) { result in
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

    func items(
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

    func topItems(
        count: Int = 30, completionHandler: @escaping (Result<[TopLevelItem], Error>) -> Void
    ) { items(category: .top, count: count, completionHandler: completionHandler) }

    // MARK: - Page

    struct AlgoliaItem: Decodable { var children: [Comment] }

    func page(item: TopLevelItem, completionHandler: @escaping (Result<Page, Error>) -> Void) {
        var comments: [Comment]!
        var html: String!
        let group = DispatchGroup()
        group.enter()
        networkClient.request(to: .algolia(id: item.id)) { result in defer { group.leave() }
            guard case let .success((data, _)) = result else {
                completionHandler(.failure(result.failure!))
                return
            }
            do {
                let algoliaItem = try self.decoder.decode(AlgoliaItem.self, from: data)
                comments = algoliaItem.children
            } catch { completionHandler(.failure(error)) }
        }
        group.enter()
        self.networkClient.request(to: .hn(id: item.id)) { result in defer { group.leave() }
            guard case let .success((data, _)) = result else {
                completionHandler(.failure(result.failure!))
                return
            }
            html = String(data: data, encoding: .utf8)
        }
        group.notify(queue: queue) {
            do {
                let parser = try HNParser(html: html)
                comments = parser.sortedCommentTree(original: comments)
                let page = Page(item: item, children: comments)
                completionHandler(.success(page))
            } catch { completionHandler(.failure(error)) }
        }
    }
}
