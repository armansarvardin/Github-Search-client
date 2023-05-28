//
//  AuthService.swift
//  Domain
//
//  Created by Arman Sarvardin on 28.05.2023.
//

import Foundation
import Combine
import FirebaseAuth
import KeychainSwift

fileprivate enum Constants {
    static let oauthProvider: String = "github.com"
    static let providerParameters: [String: String] = [
        "allow_signup": "false"
    ]
}

public protocol AuthServiceProtocol {
    func signIn() -> AnyPublisher<OAuthCredential, AuthError>
    func saveToken(token: String)
    func signOut()
}

public final class AuthService: AuthServiceProtocol {
    public init() {}
    public func signIn() -> AnyPublisher<OAuthCredential, AuthError> {
        let subject = PassthroughSubject<OAuthCredential, AuthError>()
        
        let provider = OAuthProvider(providerID: Constants.oauthProvider)
        provider.customParameters = Constants.providerParameters
        
        provider.getCredentialWith(nil) { _, _ in }
        
        Auth.auth().signIn(with: provider, uiDelegate: nil) { authDataResult, error in
            if let result = authDataResult,
               let oauthCredentials = result.credential as? OAuthCredential {
                UserDataManager.shared.saveUserData(from: result.user)
                subject.send(oauthCredentials)
                subject.send(completion: .finished)
            } else {
                subject.send(completion: .failure(.tokenNotExtracted))
            }
        }
        return subject.eraseToAnyPublisher()
    }
    
    public func saveToken(token: String) {
        let keychain = KeychainSwift()
        keychain.set(token, forKey: GlobalContants.tokenKeychainKey)
    }
    
    public func signOut() {
        let keychain = KeychainSwift()
        keychain.clear()
        flushUserDefaults()
        do {
            try Auth.auth().signOut()
        } catch {
            print("Did not sign out")
        }
    }
    
    private func flushUserDefaults() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
}


