//
//  TailedBeastListView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//

import SwiftUI

struct TailedBeastListView: View {
    @StateObject private var viewModel = GenericViewModel<TailedBeast>(
        endpointGenerator: { page, limit in
                .allTailedBeasts(page: page, limit: limit)
        }
    )

    var body: some View {
        NavigationView {
            List(viewModel.items) { tailedBeast in
                NavigationLink(destination: TailedBeastDetailView(tailedBeast: tailedBeast)) {
                    HStack {
                        if let imageUrl = tailedBeast.images?.first, let url = URL(string: imageUrl) {
                            AsyncImage(url: url) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } else if phase.error != nil {
                                    Image(systemName: "questionmark.circle")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.gray)
                                } else {
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                }
                            }
                        }

                        Text(tailedBeast.name)
                            .font(.headline)
                    }
                    .padding(.vertical, 5)
                    .onAppear {
                        Task {
                            await viewModel.loadMoreIfNeeded(currentItem: tailedBeast)
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Tailed Beasts")
            .task {
                await viewModel.fetchItems()
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if viewModel.items.isEmpty {
                    Text("No Tailed Beasts Available")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}


#Preview {
    TailedBeastListView()
}
