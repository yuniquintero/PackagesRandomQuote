//
//  APIRequest.swift
//  ThinkUp
//
//  Created by Viry Gomez on 1/30/20.
//  Copyright © 2020 ThinkUp. All rights reserved.
//

import Foundation

public enum HttpMethod: String {
    case get = "GET"
    case put = "PUT"
    case update = "UPDATE"
    case post = "POST"
    case delete = "DELETE"
}

public enum MimeType: String {
    case jpg = "image/jpeg"
    case png = "image/png"
    case file
}

public extension URLRequest {
    init(url: URL, httpMethod: HttpMethod, headers: [String: String] = [:], params: Data? = nil) {
        if httpMethod == .get {
            guard var urlComponents: URLComponents = .init(string: url.absoluteString) else { fatalError() }
            urlComponents.queryItems = []

            if let params = params {
                do {
                    let paramsDict = try JSONSerialization.jsonObject(with: params, options: .allowFragments)

                    if let paramsArray = paramsDict as? [[String: Any]] {
                        var queryItems: [URLQueryItem] = []
                        for params in paramsArray {
                            queryItems.append(contentsOf: URLRequest.getQueryItems(params: params))
                        }
                        urlComponents.queryItems = queryItems
                    } else {
                        urlComponents.queryItems = URLRequest.getQueryItems(params: paramsDict as? [String: Any] ?? [:])
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
                guard let paramsURL = urlComponents.url else { fatalError() }
                self.init(url: paramsURL)
            } else {
                self.init(url: url)
            }
        } else {
            self.init(url: url)
            self.httpBody = params
        }

        self.httpMethod = httpMethod.rawValue

        for (key, value) in headers {
            addValue(value, forHTTPHeaderField: key)
        }

        if value(forHTTPHeaderField: "Content-Type") == nil {
            addValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        for header in ModuleNetworking.shared.headers {
            if value(forHTTPHeaderField: header.header) == nil {
                addValue(header.value, forHTTPHeaderField: header.header)
            }
        }
    }

    static func uploadRequest(nameKey: String,
                              fileName: String,
                              params: [String: String] = [:],
                              mimeType: MimeType,
                              url: URL,
                              headers: [String: String] = [:],
                              imageData: Data) -> URLRequest {
        let boundary = "----WebKitFormBoundary" + UUID().uuidString

        var body = Data()

        for param in params {
            body.append("--\(boundary)")
            body.append("\r\n")
            body.append("Content-Disposition: form-data; name=\"\(param.key)\"")
            body.append("\r\n")
            body.append("\r\n")
            body.append(param.value)
            body.append("\r\n")
        }

        body.append("--\(boundary)")
        body.append("\r\n")
        body.append("Content-Disposition: form-data; name=\"\(nameKey)\"; filename=\"\(fileName)\"")

        if mimeType != .file {
            body.append("\r\n")
            body.append("Content-Type: \(mimeType.rawValue)")
        }

        body.append("\r\n")
        body.append("\r\n")
        body.append(imageData)
        body.append("\r\n")
        body.append("--\(boundary)--")
        body.append("\r\n")

        let request = URLRequest(url: url,
                                 httpMethod: .post,
                                 headers: [
                                    "Content-Type": "multipart/form-data; boundary=\(boundary)"],
                                 params: body)

        return request
    }

    private static func getQueryItems(params: [String: Any]) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []

        for (key, value) in params {
            let queryItem: URLQueryItem = .init(name: key, value: value as? String ?? "")
            queryItems.append(queryItem)
        }

        return queryItems
    }
}
