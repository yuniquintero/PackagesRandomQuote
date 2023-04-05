//
//  APIResponse.swift
//  ThinkUp
//
//  Created by Viry Gomez on 1/30/20.
//  Copyright © 2020 ThinkUp. All rights reserved.
//

import Foundation

public typealias APIResponseCompletion<T> = (Result<T, Error>) -> Void
