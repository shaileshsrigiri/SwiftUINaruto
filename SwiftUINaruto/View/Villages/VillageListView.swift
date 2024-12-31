//
//  TailedBeastListView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//

import SwiftUI

import SwiftUI

struct VillageListView: View {
    @StateObject private var viewModel = GenericViewModel<Village>(
        endpointGenerator: { page, limit in
                .allVillages(page: page, limit: limit)
        }
    )

    var body: some View {
        NavigationView {
            List(viewModel.items) { village in
                NavigationLink(destination: VillageDetailView(village: village)) {
                    Text(village.name)
                        .font(.headline)
                        .padding(.vertical, 5)
                        .onAppear {
                            Task {
                                await viewModel.loadMoreIfNeeded(currentItem: village)
                            }
                        }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Villages")
            .task {
                await viewModel.fetchItems()
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if viewModel.items.isEmpty {
                    Text("No Villages Available")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}



#Preview {
    VillageListView()
}
