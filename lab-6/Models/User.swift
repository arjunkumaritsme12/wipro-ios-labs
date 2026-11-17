
import Foundation

struct User: Codable, Identifiable, Sendable {

    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String

    let address: Address
    let company: Company
}

struct Company: Codable, Sendable {
    let name: String
}
