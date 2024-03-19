//
//  TabBarView.swift
//  Exam
//
//  Created by Евгений Бухарев on 19.03.2024.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = "Main"
    

    var body: some View {
        TabView(selection: $selectedTab) {
            MainView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag("Main")
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
                .tag("Favorites")
        }
        .accentColor(.black) // Цвет активной вкладки
    }
}

#Preview {
    TabBarView()
}
