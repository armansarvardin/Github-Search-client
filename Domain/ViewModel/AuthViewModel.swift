//
//  AuthViewModel.swift
//  Domain
//
//  Created by Arman Sarvardin on 28.05.2023.
//

import Foundation
import Combine

public final class AuthViewModel: ObservableObject {
    var authService: AuthServiceProtocol
    @Published public var errorMessage: String = ""
    @Published public var isAuthorized: Bool = UserDefaults.standard.bool(forKey: GlobalContants.isAuthorized)
    private var localSubscriptions = Set<AnyCancellable>()
    public init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
        
    }
    
    public func signIn() {
        authService.signIn()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] credential in
                guard let accessToken = credential.accessToken else { return }
                self?.authService.saveToken(token: accessToken)
                self?.isAuthorized = true
                UserDefaults.standard.set(true, forKey: GlobalContants.isAuthorized)
                NotificationCenter.default.post(name: .authorizationEvent, object: true)
            }.store(in: &localSubscriptions)
    }
    
}
