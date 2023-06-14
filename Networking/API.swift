
import Foundation

struct API {
    private static let baseURL: String = "https://api.quotable.io"

    enum Path {
        static let getRandomQuote: String = baseURL + "/quotes/random" //?limit=50
        static let getRandomQuotes: String = baseURL + "/quotes/random?limit=50"
        static let getTags: String = baseURL + "/tags"
        static let getTagQuote: String = baseURL + "/quotes/random?tags=" // &limit=50"
        static let getTagQuotes: String = baseURL + "/quotes/random?limit=50&tags="
    }
}
