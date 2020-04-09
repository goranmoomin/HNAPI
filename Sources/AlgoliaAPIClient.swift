import Foundation

class AlgoliaAPIClient {
    let networkClient: NetworkClient = URLSession.shared
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()

    struct QueryResult: Decodable { var hits: [TopLevelItem] }

    func topItems(
        count: Int = 30, completionHandler: @escaping (Result<[TopLevelItem], Error>) -> Void
    ) {
        networkClient.request(to: .firebase(category: .top)) { result in
            guard case let .success((data, _)) = result else {
                completionHandler(.failure(result.failure!))
                return
            }
            do {
                let ids = Array(try self.decoder.decode([Int].self, from: data).prefix(count))
                self.networkClient.request(to: .algolia(ids: ids)) { result in
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
            } catch { completionHandler(.failure(error)) }
        }
    }
}
