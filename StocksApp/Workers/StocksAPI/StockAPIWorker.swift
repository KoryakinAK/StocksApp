//
//  StockAPIWorker.swift
//  StocksApp
//
//  Created by Alexey Koryakin on 30.03.2021.
//

import UIKit

class StockAPIWorker {
    class func requestQuote<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = [endpoint.parameters, endpoint.token]

        guard let url = components.url else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            guard response != nil, let data = data else { return }
            DispatchQueue.main.async {
                if let responceObject = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responceObject))
                } else {
                    let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response"])
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
