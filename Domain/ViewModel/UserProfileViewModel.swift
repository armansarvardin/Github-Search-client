//
//  UserProfileView.swift
//  Domain
//
//  Created by Arman Sarvardin on 29.05.2023.
//

import Foundation
import FirebaseAuth
import WebKit

public class UserProfileViewModel: ObservableObject {
    @Published public var userInfo: UserInfo?
    @Published public var dismissAction: Bool = false
    public var authService: AuthServiceProtocol?
    
    public init(
        userInfo: UserInfo? = nil,
        authService: AuthServiceProtocol? = AuthService()
    ) {
        self.userInfo = UserDataManager.shared.getUserData()
        self.authService = authService
    }
    
    public func signOut() {
        authService?.signOut()
        dismissAction = true
        UserDefaults.standard.set(false, forKey: GlobalContants.isAuthorized)
        NotificationCenter.default.post(name: .authorizationEvent, object: false)
    }
}
