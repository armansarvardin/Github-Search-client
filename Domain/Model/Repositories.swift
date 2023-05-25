//
//  Repositories.swift
//  Domain
//
//  Created by Arman Sarvardin on 25.05.2023.
//

import Foundation

public struct Repositories: Codable {
    public let totalCount: Int
    public let items: [RepositoryItem]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
