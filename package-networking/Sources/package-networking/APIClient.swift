//
//  APIClient.swift
//  ThinkUp
//
//  Created by Viry Gomez on 1/30/20.
//  Copyright © 2020 ThinkUp. All rights reserved.
//

import Foundation

struct APIClient {
    static func request<T: Codable>(request: URLRequest, _ completion: @escaping APIResponseCompletion<T>) {
        let session = URLSession(configuration: getURLSessionConfiguation())

        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return completion(.failure(APIError(code: -1, message: "")))
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.failure(APIError(code: -1, message: "Invalid response")))
            }

            guard let data = data else {
                return completion(.failure(APIError(code: -1, message: "Data was not retrieved from request")))
            }

            guard 200...299 ~= httpResponse.statusCode else {
                print("Status code: \(httpResponse.statusCode)")
                do {
                    guard let errorJson =
                        try JSONSerialization.jsonObject(with: data,
                                                         options: .allowFragments) as? [String: Any] else {
                                                            return completion(.failure(ErrorType.decoding))
                    }

                    let error = NSError(domain: "",
                                        code: httpResponse.statusCode,
                                        userInfo: [ NSLocalizedDescriptionKey: (errorJson["error"] as? String) ?? ""])
                    return completion(.failure(error))
                } catch let error {
                    return completion(.failure(error))
                }
            }

            do {
                let response: T = try JSONDecoder().decode(T.self, from: data)
                return completion(.success(response))
            } catch let error {
                return completion(.failure(error))
            }
        }

        task.resume()
    }

    private static func getURLSessionConfiguation() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [
            APILoggerInterceptor.self,
            APIConnectionInterceptor.self
        ]

        return configuration
    }
}
