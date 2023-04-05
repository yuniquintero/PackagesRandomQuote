
import Foundation

public struct Quote: Identifiable, Codable, Hashable {
    public var id: String
    public let content: String
    public let author: String

    enum CodingKeys: String, CodingKey {
        case content, author
        case id = "_id"
    }

    public init(id: String, content: String, author: String) {
        self.id = id
        self.content = content
        self.author = author
    }
}
