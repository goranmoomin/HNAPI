import Foundation

protocol NetworkClient {
    typealias Completion = (Result<(Data, URLResponse), Error>) -> Void

    func request(to endpoint: Endpoint, completionHandler: @escaping Completion)
}

extension URLSession: NetworkClient {
    fileprivate static func adapter(
        _ completionHandler: @escaping Completion
    ) -> (Data?, URLResponse?, Error?) -> Void {
        let adapter = { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data, let response = response {
                completionHandler(.success((data, response)))
            } else if let error = error { completionHandler(.failure(error)) } else {
                preconditionFailure("Data and Error can't both be nil")
            }
        }
        return adapter
    }

    func request(to endpoint: Endpoint, completionHandler: @escaping Completion) {
        let url = endpoint.url
        let dataTask = self.dataTask(with: url, completionHandler: Self.adapter(completionHandler))
        dataTask.resume()
    }
}
