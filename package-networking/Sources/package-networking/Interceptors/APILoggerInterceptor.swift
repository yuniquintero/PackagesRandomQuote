//
//  APILoggerInterceptor.swift
//  merkos-networking
//
//  Created by Viry Gomez on 11/15/20.
//

import Foundation

final class APILoggerInterceptor: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        print("📤 Request: \(request.httpMethod ?? "")\n- \(request.url?.absoluteString ?? "")")
        return false
    }
}
