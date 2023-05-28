//
//  RepositoryHistoryManager.swift
//  Domain
//
//  Created by Arman Sarvardin on 26.05.2023.
//

import Combine
import Foundation

fileprivate enum Constants {
    static let maxHistoryCount = 20
    static let userDefaultsKey = "VisitedRepos"
}

public final class RepositoryHistoryManager {
    public static let shared = RepositoryHistoryManager()
    
    @Published var visitedRepos: [RepositoryItem] = []
    
    private init() {
        loadVisitedRepos()
    }
    
    private func loadVisitedRepos() {
        guard
            let data = UserDefaults.standard.data(forKey: Constants.userDefaultsKey),
            let visitedRepos = try? JSONDecoder().decode([RepositoryItem].self, from: data)
        else {
            return
        }
        self.visitedRepos = visitedRepos.map { visitedRepo in
            var visitedRepo = visitedRepo
            visitedRepo.isViewed = true
            return visitedRepo
        }
    }
    
    private func saveVisitedPages() {
        guard let data = try? JSONEncoder().encode(visitedRepos) else {
            return
        }
        UserDefaults.standard.set(data, forKey: Constants.userDefaultsKey)
    }
    
    public func addVisitedRepo(_ repo: RepositoryItem) {
        guard !visitedRepos.contains(where: { item in
            item.id == repo.id
        }) else { return }
        if visitedRepos.count >= Constants.maxHistoryCount{
            visitedRepos.removeFirst()
        }
        var repo = repo
        repo.isViewed = true
        visitedRepos.append(repo)
        saveVisitedPages()
    }
}
