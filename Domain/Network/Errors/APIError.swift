//
//  APIError.swift
//  Domain
//
//  Created by Arman Sarvardin on 28.05.2023.
//

import Foundation

public enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    // Add more error cases as needed
}
