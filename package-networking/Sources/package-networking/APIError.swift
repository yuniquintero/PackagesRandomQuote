//
//  APIError.swift
//  ThinkUp
//
//  Created by Viry Gomez on 1/30/20.
//  Copyright © 2020 ThinkUp. All rights reserved.
//

import Foundation

public enum ErrorType: Error {
    case url
    case decoding
    case unauthorized
    case generic
}

public struct APIError: LocalizedError, Codable {
    let code: Int
    let message: String?

    public var errorDescription: String? {
        return message
    }
}
