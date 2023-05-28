//
//  GlobalContants.swift
//  Domain
//
//  Created by Arman Sarvardin on 25.05.2023.
//

import Foundation

public enum GlobalContants {
    public static let apiKey: String = "GlobalContants"
    public static let tokenKeychainKey: String = "TokenKey"
    public static let isAuthorized: String = "isAuthed"
    public static let userInfo: String = "UserInfo"
}

public extension Notification.Name {
    static let authorizationEvent = Notification.Name("authorization.event")
}
