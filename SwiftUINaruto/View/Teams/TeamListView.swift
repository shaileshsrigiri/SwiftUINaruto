//
//  TailedBeastListView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//

import SwiftUI

struct TeamListView: View {
    @StateObject private var viewModel = GenericViewModel<Team>(
        endpointGenerator: { page, limit in
                .allTeams(page: page, limit: limit)
        }
    )

    var body: some View {
        NavigationView {
            List(viewModel.items) { team in
                NavigationLink(destination: TeamDetailView(team: team)) {
                    Text(team.name)
                        .font(.headline)
                        .padding(.vertical, 5)
                        .onAppear {
                            Task {
                                await viewModel.loadMoreIfNeeded(currentItem: team)
                            }
                        }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Teams")
            .task {
                await viewModel.fetchItems()
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if viewModel.items.isEmpty {
                    Text("No Teams Available")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}


#Preview {
    TeamListView()
}
