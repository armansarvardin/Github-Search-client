//
//  SearchViewModel.swift
//  Domain
//
//  Created by Arman Sarvardin on 25.05.2023.
//

import Foundation
import Combine

public enum SortingPickerType: String {
    case stars
    case forks
    case updated
}

public final class SearchViewModel: ObservableObject {
    var localCancellable = Set<AnyCancellable>()
    private var searchSubscription : AnyCancellable?
    @Published public var searchText: String = ""
    @Published public var receivedError: String?
    @Published public var items: [RepositoryItem] = []
    @Published private var pageNumber: Int = 1
    @Published public var sortingPickerType: SortingPickerType = .stars
    @Published public var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    var searchService: SearchServiceProtocol
    
    public init(searchService: SearchServiceProtocol = SearchService()) {
        self.searchService = searchService
        
        searchSubscription = $searchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] searchText in
                self?.items.removeAll()
                self?.pageNumber = 1
                self?.performSearch(
                    by: searchText,
                    in: self?.pageNumber ?? 1,
                    sortingType: self?.sortingPickerType.rawValue ?? "stars"
                )
            })
        
        $pageNumber.sink { [weak self] page in
            guard let self else { return }
            performSearch(
                by: searchText,
                in: pageNumber,
                sortingType: sortingPickerType.rawValue
            )
        }.store(in: &localCancellable)
        
        $sortingPickerType
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] type in
            guard let self else { return  }
            items.removeAll()
            pageNumber = 1
            performSearch(
                by: searchText,
                in: pageNumber,
                sortingType: type.rawValue
            )
        }.store(in: &localCancellable)
    }
    
    public func incrementPage() {
        pageNumber += 1
    }
    
    public func markRepoAsViewed(repoId: Int) {
        if let repoIndex = items.firstIndex(where: { $0.id == repoId }) {
            items[repoIndex].isViewed = true
        }
    }
    
    private func performSearch(
        by text: String,
        in page: Int,
        sortingType: String
    ) {
        if !text.isEmpty {
            isLoading = true
            searchService.search(by: text, in: page, sortingType: sortingType)
                .print("Search subscription: ")
                .sink { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.receivedError = error.localizedDescription
                    case .finished:
                        break
                    }
                    self?.isLoading = false
                } receiveValue: { [weak self] data in
                    self?.isLoading = false
                    self?.items.append(contentsOf: data.items)
                }.store(in: &localCancellable)
        }
    }
    
}
