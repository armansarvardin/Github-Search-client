//
//  UserDataManager.swift
//  Domain
//
//  Created by Arman Sarvardin on 29.05.2023.
//

import Foundation
import FirebaseAuth

final class UserDataManager {
    public static let shared = UserDataManager()
    private init() {}
    
    func saveUserData(from user: User) {
        let userInfo = UserInfo(
            name: user.displayName ?? "",
            email: user.email ?? "",
            avatarUrlString: user.photoURL?.absoluteString ?? ""
        )
        
        guard let data = try? JSONEncoder().encode(userInfo) else { return }
        
        UserDefaults.standard.set(data, forKey: GlobalContants.userInfo)
    }
    
    func getUserData() -> UserInfo? {
        guard let data = UserDefaults.standard.data(forKey: GlobalContants.userInfo),
              let userInfo = try? JSONDecoder().decode(UserInfo.self, from: data) else { return nil }
        return userInfo
    }
}
