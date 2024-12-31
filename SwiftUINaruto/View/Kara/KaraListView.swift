//
//  KaraListView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/31/24.
//

import SwiftUI

struct KaraListView: View {
    @StateObject private var viewModel = GenericViewModel<Kara>(
        endpointGenerator: { page, limit in
            .allKara(page: page, limit: limit)
        }
    )

    var body: some View {
        NavigationView {
            content
                .task {
                    await viewModel.fetchItems()
                }
                .navigationTitle("Kara")
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.items.isEmpty {
            ProgressView("Loading Kara...")
                .scaleEffect(1.5)
                .padding()
        } else if viewModel.items.isEmpty {
            Text("No Kara members available.")
                .foregroundColor(.gray)
                .font(.headline)
                .padding()
        } else {
            karaList
        }
    }

    private var karaList: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.items) { member in
                    NavigationLink(destination: KaraDetailView(member: member)) {
                        KaraRowView(member: member)
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



struct KaraRowView: View {
    let member: Kara

    var body: some View {
        HStack {
            memberImage
            VStack(alignment: .leading, spacing: 5) {
                Text(member.name)
                    .font(.headline)
            }
        }
        .padding(.vertical, 5)
    }

    private var memberImage: some View {
        Group {
            if let imageUrl = member.images?.first, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } else if phase.error != nil {
                        placeholderImage
                    } else {
                        ProgressView()
                            .frame(width: 50, height: 50)
                    }
                }
            } else {
                placeholderImage
            }
        }
    }

    private var placeholderImage: some View {
        Image(systemName: "person.crop.circle.fill.badge.xmark")
            .resizable()
            .frame(width: 50, height: 50)
            .foregroundColor(.gray)
    }
}



#Preview {
    KaraListView()
}
