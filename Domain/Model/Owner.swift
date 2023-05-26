//
//  Owner.swift
//  Domain
//
//  Created by Arman Sarvardin on 26.05.2023.
//

import Foundation

public struct Owner: Codable {
    public let avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }
}
