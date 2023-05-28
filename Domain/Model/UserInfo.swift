//
//  UserInfo.swift
//  Domain
//
//  Created by Arman Sarvardin on 29.05.2023.
//

import Foundation

public struct UserInfo: Codable {
    public var name: String
    public var email: String
    public var avatarUrlString: String
    
    public var avatarUrl: URL {
        return URL(string: avatarUrlString) ?? URL(string: "www.google.com")!
    }
}
