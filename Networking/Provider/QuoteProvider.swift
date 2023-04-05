//
//  GenresProvider.swift
//  DemoApp
//
//  Created by Roselyn Vasquez on 15/2/23.
//

import Foundation
import package_networking
import package_models

struct QuoteProvider {
    private let repository: QuoteRepository = .init()

    func getRandomQuote(completion: @escaping APIResponseCompletion<RandomQuoteResponse>) {
        repository.getRandomQuote(completion: completion)
    }
}
