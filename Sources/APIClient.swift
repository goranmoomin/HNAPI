import Foundation

class APIClient {
    // MARK: - Properties

    var networkClient: NetworkClient = URLSession.shared
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()

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
        networkClient.request(to: .algolia(id: item.id)) { result in
            guard case let .success((data, _)) = result else {
                completionHandler(.failure(result.failure!))
                return
            }
            let pageResult = Result<Page, Error> {
                let algoliaItem = try self.decoder.decode(AlgoliaItem.self, from: data)
                // TODO: Fetch HN & reorder the comment tree
                let comments = algoliaItem.children
                return Page(item: item, children: comments)
            }
            completionHandler(pageResult)
        }
    }
}
