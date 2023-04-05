//
//  ModuleNetworkingswift
//  
//
//  Created by Viry Gomez on 14/11/21.
//

import Foundation

public class ModuleNetworking {
    public static var shared: ModuleNetworking = .init()
    var headers: [APIHeader] = []

    public static func setup(headers: [APIHeader] = []) {
        ModuleNetworking.shared.headers = headers

        URLProtocol.registerClass(APILoggerInterceptor.self)
        URLProtocol.registerClass(APIConnectionInterceptor.self)
    }

    public static func request<T: Codable>(request: URLRequest,
                                           _ completion: @escaping APIResponseCompletion<T>) {
        APIClient.request(request: request, completion)
    }

    public func set(headers: [APIHeader]) {
        self.headers = headers
    }
}
