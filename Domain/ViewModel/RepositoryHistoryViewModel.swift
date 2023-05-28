//
//  RepositoryHistoryViewModel.swift
//  Domain
//
//  Created by Arman Sarvardin on 26.05.2023.
//

import Foundation
import Combine

public final class RepositoryHistoryViewModel: ObservableObject {
    @Published public var visitedItems: [RepositoryItem] = []
    let manager = RepositoryHistoryManager.shared
    var localCancellables = Set<AnyCancellable>()
    
    public init() {
        manager.$visitedRepos.sink { [weak self] items in
            self?.visitedItems = items
        }.store(in: &localCancellables)
    }
}
