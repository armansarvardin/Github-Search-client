//
//  RepositoryItems.swift
//  Domain
//
//  Created by Arman Sarvardin on 25.05.2023.
//

import Foundation

public struct RepositoryItem: Codable, Identifiable {
    public let id: Int
    public let fullName: String
    public let description: String?
    public let url: String
    public let language: String?
    public let stargazersCount: Int?
    public let updatedAt: String
    public let forksCount: Int?
    public let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case id, url, description, language, owner
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
        case updatedAt = "updated_at"
        case forksCount = "forks_count"
    }
    
    public var updatedDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: updatedAt) ?? Date()
    }
}
