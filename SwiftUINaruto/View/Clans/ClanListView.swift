//
//  ClanListView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//

import SwiftUI

struct ClanListView: View {
    @StateObject private var viewModel = GenericViewModel<Clan>(
        endpointGenerator: { page, limit in
            .allClans(page: page, limit: limit)
        }
    )

    var body: some View {
        NavigationView {
            content
                .task {
                    await viewModel.fetchItems()
                }
                .navigationTitle("Clans")
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.items.isEmpty {
            ProgressView("Loading Clans...")
                .scaleEffect(1.5)
                .padding()
        } else if viewModel.items.isEmpty {
            Text("No clans available.")
                .foregroundColor(.gray)
                .font(.headline)
                .padding()
        } else {
            clanList
        }
    }

    private var clanList: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.items) { clan in
                    NavigationLink(destination: ClanDetailView(clan: clan)) {
                        ClanRowView(clan: clan)
                    }
                    .onAppear {
                        Task {
                            await viewModel.loadMoreIfNeeded(currentItem: clan)
                        }
                    }
                }

                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
            }
            .padding(.horizontal)
        }
    }
}



struct ClanRowView: View {
    let clan: Clan

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(clan.name)
                .font(.headline)
            Text("\(clan.characters.count) members")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 5)
    }
}


#Preview {
    ClanListView()
}
