//
//  API.swift
//  DemoApp
//
//  Created by Roselyn Vasquez on 15/2/23.
//

import Foundation

struct API {
    private static let baseURL: String = "https://api.quotable.io"
    //static let apiKey: String = "ad22b3649de04aadbaefe3d83be21faa"

    enum Path {
        static let getRandomQuote: String = baseURL + "/random"
        //static let genreDetailURL: String = genresURL + "/%i"
    }

   // static let defaultParams = [:]
}
