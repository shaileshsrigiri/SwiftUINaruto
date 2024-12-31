//
//  AkatsukiView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//

import SwiftUI

struct AkatsukiView: View {
    @StateObject private var viewModel = GenericViewModel<Akatsuki>(
        endpointGenerator: { page, limit in
            .allAkatsuki(page: page, limit: limit)
        }
    )

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading && viewModel.items.isEmpty {
                    ProgressView("Loading Akatsuki Members...")
                        .scaleEffect(1.5)
                        .padding()
                } else if viewModel.items.isEmpty {
                    Text("No Akatsuki members available.")
                        .foregroundColor(.gray)
                        .font(.headline)
                        .padding()
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 16) {
                            ForEach(viewModel.items) { member in
                                NavigationLink(destination: AkatsukiDetailView(member: member)) {
                                    AkatsukiRowView(member: member)
                                }
                                .onAppear {
                                    Task {
                                        await viewModel.loadMoreIfNeeded(currentItem: member)
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
            .task {
                await viewModel.fetchItems()
            }
            .navigationTitle("Akatsuki Members")
        }
    }
}



#Preview {
    AkatsukiView()
}
