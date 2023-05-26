//
//  SearchViewModel.swift
//  Domain
//
//  Created by Arman Sarvardin on 25.05.2023.
//

import Foundation
import Combine

public final class SearchViewModel: ObservableObject {
    var localCancellable = Set<AnyCancellable>()
    private var searchSubscription : AnyCancellable?
    @Published public var searchText: String = ""
    @Published public var receivedError: String?
    @Published public var items: [RepositoryItem] = []
    @Published private var pageNumber: Int = 1
    
    private var cancellables = Set<AnyCancellable>()
    var searchService: SearchServiceProtocol
    
    public init(searchService: SearchServiceProtocol = SearchService()) {
        self.searchService = searchService
        searchSubscription = $searchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] searchText in
                self?.performSearch(by: searchText, in: self?.pageNumber ?? 1)
            })
        $pageNumber.sink { [weak self] page in
            guard let self else { return }
            performSearch(by: searchText, in: pageNumber)
        }.store(in: &localCancellable)
    }
    
    public func incrementPage() {
        pageNumber += 1
    }
    
    private func performSearch(by text: String, in page: Int) {
        if !text.isEmpty {
            searchService.search(by: text, in: page)
                .sink { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.receivedError = error.localizedDescription
                    case .finished:
                        break
                    }
                } receiveValue: { data in
                    print(data.items)
                    self.items.append(contentsOf: data.items)
                }.store(in: &localCancellable)
        }
    }
}
