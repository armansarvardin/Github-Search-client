//
//  BaseTargetType.swift
//  Domain
//
//  Created by Arman Sarvardin on 28.05.2023.
//

import Foundation

protocol TargetType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var queryParameters: [String: String]? { get }
    var decoder: JSONDecoder { get }
}
