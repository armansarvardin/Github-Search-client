//
//  SearchViewModel.swift
//  Domain
//
//  Created by Arman Sarvardin on 25.05.2023.
//

import Foundation
import Combine

public final class SearchViewModel: ObservableObject {
    @Published public var receivedError: String?
    @Published public var items: [RepositoryItem] = []
    
    private var cancellables = Set<AnyCancellable>()
    var searchService: SearchServiceProtocol
    
    public init(searchService: SearchServiceProtocol = SearchService()) {
        self.searchService = searchService
    }
    
    public func performSearch(by text: String) {
        if !text.isEmpty {
            searchService.search(by: text)
                .debounce(for: 0.5, scheduler: DispatchQueue.main)
                .sink { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.receivedError = error.localizedDescription
                    case .finished:
                        break
                    }
                } receiveValue: { [weak self] data in
                    self?.items = data.items
                }.store(in: &cancellables)
        }
    }
}
