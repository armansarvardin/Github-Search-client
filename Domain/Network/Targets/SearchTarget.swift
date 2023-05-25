//
//  SearchTarget.swift
//  Domain
//
//  Created by Arman Sarvardin on 25.05.2023.
//

import Foundation

fileprivate enum Constants {
    static let perPage: Int = 30
}

enum SearchTarget: TargetType {
    case search(name: String)
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        return "/search/repositories"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return defaultHeaders
    }
    
    var body: Data? {
        return nil
    }
    
    var queryParameters: [String : String]? {
        switch self {
        case .search(let name):
            return [
                "q": name,
                "per_page": "\(Constants.perPage)"
            ]
        }
    }
    
    var decoder: JSONDecoder {
        JSONDecoder()
    }
}