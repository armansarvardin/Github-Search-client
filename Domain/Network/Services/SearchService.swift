//
//  SearchService.swift
//  Domain
//
//  Created by Arman Sarvardin on 25.05.2023.
//

import Foundation
import Combine

public protocol SearchServiceProtocol {
    func search(by name: String, in page: Int) -> AnyPublisher<Repositories, APIError>
}

public class SearchService: SearchServiceProtocol {
    public init() {}
    
    let apiRouter = NetworkManager()
    
    public func search(
        by name: String,
        in page: Int
    ) -> AnyPublisher<Repositories, APIError> {
        return apiRouter.request(
            SearchTarget.search(name: name, pageNumber: page),
            responseType: Repositories.self
        )
    }
}
