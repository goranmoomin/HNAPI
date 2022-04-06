import Foundation

protocol NetworkClient {
    typealias Completion = (Result<(Data, HTTPURLResponse), Error>) -> Void

    func request(to endpoint: Endpoint, completionHandler: @escaping Completion)
    func request<T>(_ type: T.Type, from url: URL, decoder: JSONDecoder) async throws -> T
    where T: Decodable
}

extension URLSession: NetworkClient {
    public enum HTTPError: Error, LocalizedError {
        case transportError(Error)
        case serverSideError(statusCode: Int)

        public var errorDescription: String? {
            switch self {
            case .transportError(let error):
                let error = error as NSError
                return error.localizedDescription
            case .serverSideError(let statusCode): return "Server returned \(statusCode)."
            }
        }
    }

    fileprivate static func adapter(_ completionHandler: @escaping Completion) -> (
        Data?, URLResponse?, Error?
    ) -> Void {
        let adapter = { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode >= 400 && response.statusCode < 500 {
                    completionHandler(
                        .failure(HTTPError.serverSideError(statusCode: response.statusCode)))
                } else {
                    completionHandler(.success((data, response)))
                }
            } else if let error = error {
                completionHandler(.failure(HTTPError.transportError(error)))
            } else {
                preconditionFailure("Data and Error can't both be nil")
            }
        }
        return adapter
    }

    func request(to endpoint: Endpoint, completionHandler: @escaping Completion) {
        let dataTask = self.dataTask(
            with: endpoint, completionHandler: Self.adapter(completionHandler))
        dataTask.resume()
    }

    func request<T>(_ type: T.Type, from url: URL, decoder: JSONDecoder) async throws -> T
    where T: Decodable {
        let (data, response) = try await data(from: url)
        if let response = response as? HTTPURLResponse, response.statusCode >= 400 {
            throw HTTPError.serverSideError(statusCode: response.statusCode)
        }
        let model = try decoder.decode(type, from: data)
        return model
    }
}
