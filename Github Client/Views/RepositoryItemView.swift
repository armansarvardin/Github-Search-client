//
//  RepositoryItemView.swift
//  Github Client
//
//  Created by Arman Sarvardin on 26.05.2023.
//

import SwiftUI
import Domain

struct RepositoryItemView: View {
    private let item: RepositoryItem
    
    init(item: RepositoryItem) {
        self.item = item
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(item.fullName)
                        .font(.headline)
                        .foregroundColor(.cyan)
                }
                .padding(.bottom ,4)
                Text(item.description ?? "No description")
                    .lineLimit(2)
                    .font(.body)
                    .foregroundColor(.primary)
                HStack {
                    Text("\(item.language ?? "N/A") • \(item.stargazersCount ?? 0) • Built by")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    AsyncImage(url: URL(string: item.owner.avatarUrl ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .failure:
                            Image(systemName: "exclamationmark.icloud.fill")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                        @unknown default:
                            fatalError("Unknown AsyncImage phase")
                        }
                    }
                    .frame(width: 20, height: 20)
                    .cornerRadius(10)
                    
                }
                HStack {
                    Text("Updated at: \(item.updatedDate.formatted(date: .numeric, time: .omitted))")
                    Text("Forks: \(item.forksCount ?? 0)")
                }
                .font(.footnote)
            }
            Spacer()
        }
    }
}
