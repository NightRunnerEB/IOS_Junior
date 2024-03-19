//
//  MainView.swift
//  Exam
//
//  Created by Евгений Бухарев on 19.03.2024.
//

import SwiftUI

struct MainView: View {
    @State private var favorites = FavoritesManager.shared.getFavorites()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) { // Добавлен отступ между элементами
                    ForEach(PhotoModel.urls, id: \.self) { urlString in
                        VStack {
                            if let url = URL(string: urlString) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ZStack {
                                            Color.black
                                                .frame(width: 300, height: 400)
                                            ProgressView()
                                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                                .scaleEffect(1.5) // Больший индикатор загрузки
                                        }
                                    case .success(let image):
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 300, height: 400)
                                            .cornerRadius(10) // Закругленные углы карточки
                                            .shadow(radius: 5) // Тень для карточки
                                    case .failure(_):
                                        Color.gray // Серый фон для неудачной загрузки
                                            .frame(width: 300, height: 400)
                                            .cornerRadius(10)
                                            .overlay(Text("Не удалось загрузить изображение"))
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .clipped()
                            } else {
                                Color.gray
                                    .frame(width: 300, height: 400)
                                    .cornerRadius(10)
                                    .overlay(Text("Неверный URL"))
                            }
                            Button(action: {
                                withAnimation {
                                    if favorites.contains(urlString) {
                                        favorites.removeAll { $0 == urlString }
                                    } else {
                                        favorites.append(urlString)
                                    }
                                    FavoritesManager.shared.saveFavorites(favorites)
                                }
                            }) {
                                Image(systemName: favorites.contains(urlString) ? "heart.fill" : "heart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 27, height: 27)
                                    .padding()
                                    .foregroundColor(favorites.contains(urlString) ? .red : .gray)
                                    .background(Circle().fill(Color.white))
                                    .shadow(radius: 3)
                                    .accessibility(label: Text(favorites.contains(urlString) ? "Удалить из избранных" : "Добавить в избранное"))
                            }
                            .padding(.top, -30) // Поднимаем кнопку ближе к изображению
                        }
                    }
                }
                .padding() // Общий отступ внутри ScrollView
            }
            .navigationBarTitle("Фотографии", displayMode: .large)
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    MainView()
}
