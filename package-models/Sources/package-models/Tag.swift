//
//  File.swift
//  
//
//  Created by Yuni Quintero on 12/4/23.
//

import Foundation

public struct Tag: Identifiable, Codable, Hashable {
    public var id: String
    public let name: String

    enum CodingKeys: String, CodingKey {
        case name
        case id = "_id"
    }

    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
