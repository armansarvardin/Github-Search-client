//
//  AuthError.swift
//  Domain
//
//  Created by Arman Sarvardin on 28.05.2023.
//

import Foundation

public enum AuthError: Error {
    case credentialError(error: Error)
    case resultError(error: Error)
    case tokenNotExtracted
}
