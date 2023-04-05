//
//  APIHeader.swift
//  
//
//  Created by Viry Gomez on 24/7/22.
//

import Foundation

public struct APIHeader {
    public let header: String
    public let value: String

    public init(header: String, value: String) {
        self.header = header
        self.value = value
    }
}
