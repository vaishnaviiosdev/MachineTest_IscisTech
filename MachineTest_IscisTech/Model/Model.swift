
import Foundation

struct AllData: Codable {
    let results: [Results]
}

struct Results: Codable {
    let id: Int
    let title: String
    let url: String
    let image_url: String
    let summary: String
    let authors: [Authors]
}

struct Authors: Codable {
    let name: String
}
