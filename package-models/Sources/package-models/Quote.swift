
import Foundation

public struct Quote: Identifiable, Codable, Hashable {
    public var id: String
    public let content: String
    public let author: String
    public let tags: [String]

    enum CodingKeys: String, CodingKey {
        case content, author, tags
        case id = "_id"
    }

    public init(id: String, content: String, author: String, tags: [String]) {
        self.id = id
        self.content = content
        self.author = author
        self.tags = tags
    }
}
