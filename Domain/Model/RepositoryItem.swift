//
//  RepositoryItems.swift
//  Domain
//
//  Created by Arman Sarvardin on 25.05.2023.
//

import Foundation

public struct RepositoryItem: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let url: String
}
