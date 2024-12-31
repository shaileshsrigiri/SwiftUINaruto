//
//  KekkeiGenkaiListView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//

import SwiftUI

struct KekkeiGenkaiListView: View {
    @StateObject private var viewModel = GenericViewModel<KekkeiGenkai>(
        endpointGenerator: { page, limit in
            .allKekkeiGenkai(page: page, limit: limit)
        }
    )

    var body: some View {
        NavigationView {
            content
                .task {
                    await viewModel.fetchItems()
                }
                .navigationTitle("Kekkei Genkai")
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.items.isEmpty {
            ProgressView("Loading Kekkei Genkai...")
                .scaleEffect(1.5)
                .padding()
        } else if viewModel.items.isEmpty {
            Text("No Kekkei Genkai available.")
                .foregroundColor(.gray)
                .font(.headline)
                .padding()
        } else {
            kekkeiGenkaiList
        }
    }

    private var kekkeiGenkaiList: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.items) { kekkeiGenkai in
                    NavigationLink(destination: KekkeiGenkaiDetailView(kekkeiGenkai: kekkeiGenkai)) {
                        KekkeiGenkaiRowView(kekkeiGenkai: kekkeiGenkai)
                    }
                    .onAppear {
                        Task {
                            await viewModel.loadMoreIfNeeded(currentItem: kekkeiGenkai)
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


struct KekkeiGenkaiRowView: View {
    let kekkeiGenkai: KekkeiGenkai

    var body: some View {
        Text(kekkeiGenkai.name)
            .font(.headline)
            .padding()
    }
}



#Preview {
    KekkeiGenkaiListView()
}
