//
//  Data+Extension.swift
//  Artcurator
//
//  Created by Viry Gomez on 7/15/20.
//  Copyright © 2020 ThinkUp. All rights reserved.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
