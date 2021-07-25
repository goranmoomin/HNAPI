import Foundation

protocol NetworkClient {
    typealias Completion = (Result<(Data, HTTPURLResponse), Error>) -> Void

    func request(to endpoint: Endpoint, completionHandler: @escaping Completion)
}

extension URLSession: NetworkClient {
    public enum HTTPError: Error {
        case transportError(Error)
        case serverSideError(statusCode: Int)
    }

    fileprivate static func adapter(_ completionHandler: @escaping Completion) -> (
        Data?, URLResponse?, Error?
    ) -> Void {
        let adapter = { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode >= 400 && response.statusCode < 500 {
                    completionHandler(.failure(HTTPError.serverSideError(statusCode: response.statusCode)))
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
}
