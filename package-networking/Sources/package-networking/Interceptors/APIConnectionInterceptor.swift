//
//  APIConnectionInterceptor.swift
//  merkos-networking
//
//  Created by Viry Gomez on 11/14/20.
//

import Network
import Foundation

protocol InterceptorProtocol: URLProtocol {
    var dataTask: URLSessionDataTask? { get set }
    var receivedData: NSMutableData? { get set }
    var urlResponse: URLResponse? { get set }
}

final class APIConnectionInterceptor: URLProtocol, InterceptorProtocol {
    var urlResponse: URLResponse?
    var dataTask: URLSessionDataTask?
    var receivedData: NSMutableData?

    let monitor = NWPathMonitor()
    var session: URLSession?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }

            if path.status != .satisfied {
                let error = NSError(domain: "",
                                    code: -1,
                                    userInfo: [
                                    NSLocalizedDescriptionKey: "No Internet connection"
                                ])
                self.client?.urlProtocol(self, didFailWithError: error)
                self.client?.urlProtocolDidFinishLoading(self)
            } else if path.status == .satisfied {
                self.session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)

                self.session?.dataTask(with: self.request, completionHandler: { data, response, error in
                    if let error = error {
                        self.client?.urlProtocol(self, didFailWithError: error)
                        self.client?.urlProtocolDidFinishLoading(self)
                    } else if let data = data, let response = response {
                        self.client?.urlProtocol(self, didLoad: data)
                        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                        self.client?.urlProtocolDidFinishLoading(self)
                    }
                }).resume()
            }
        }

        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }

    override func stopLoading() {}
}
