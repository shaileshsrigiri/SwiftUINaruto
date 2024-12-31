//
//  MainView.swift
//  SwiftUINaruto
//
//  Created by Shailesh Srigiri on 12/30/24.
//

import SwiftUI

struct MainView: View {
    let categories = [
        Category(title: "Characters", imageName: "characters"),
        Category(title: "Clans", imageName: "clans"),
        Category(title: "Kara", imageName: "kara"),
        Category(title: "Kekkei Genkai", imageName: "kekkeigenkai"),
        Category(title: "Tailed Beasts", imageName: "tailedbeasts"),
        Category(title: "Teams", imageName: "teams"),
        Category(title: "Villages", imageName: "villages"),
        Category(title: "Akatsuki", imageName: "akatsuki")
    ]
    let title = "Naruto"

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(categories) { category in
                        NavigationLink(destination: destination(for: category.title)) {
                            CategoryCardView(category: category)
                        }
                        .buttonStyle(PlainButtonStyle()) // Remove default button animation
                    }
                }
                .padding()
            }
            .background(Color(.systemBackground))
            .navigationTitle(title)
        }
    }

    @ViewBuilder
    func destination(for category: String) -> some View {
        switch category {
        case "Characters":
            CharacterGridView()
        case "Clans":
            ClanListView()
        case "Kara":
            KaraListView()
        case "Kekkei Genkai":
            KekkeiGenkaiListView()
        case "Tailed Beasts":
            TailedBeastListView()
        case "Teams":
            TeamListView()
        case "Villages":
            VillageListView()
        case "Akatsuki":
            AkatsukiView()
        default:
            Text("Coming Soon!")
        }
    }
}

// MARK: - Category Model
struct Category: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
}

// MARK: - CategoryCardView
struct CategoryCardView: View {
    let category: Category

    var body: some View {
        ZStack {
            Image(category.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 150)
                .clipped()
                .overlay(
                    Color.black.opacity(0.4)
                )

            // Content
            HStack {
                Text(category.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading, 20)

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
                    .padding(.trailing, 20)
            }
        }
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}




#Preview {
    MainView()
}
