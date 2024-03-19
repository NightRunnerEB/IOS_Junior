//
//  MainView.swift
//  Exam
//
//  Created by Евгений Бухарев on 19.03.2024.
//

import SwiftUI

struct FavoritesView: View {
    @State private var favorites: [String] = FavoritesManager.shared.getFavorites()
    @State private var isHeartPulsating = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                if favorites.isEmpty {
                    Text("Список понравившихся фотографий пуст!")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    LazyVStack(spacing: 20) { // Добавляем отступы между элементами
                        ForEach(favorites, id: \.self) { urlString in
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
                                            Color.black // Серый фон для неудачной загрузки
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
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Понравившиеся", displayMode: .large)
            .toolbar {
                // Используем ToolbarItem для добавления количества понравившихся фотографий
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .scaleEffect(isHeartPulsating ? 1.2 : 1.0) // Пульсирующий эффект
                            .onTapGesture {
                                isHeartPulsating = true
                                // Сбрасываем эффект пульсации через короткий промежуток времени
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    isHeartPulsating = false
                                }
                            }
                            .animation(.easeInOut(duration: 0.5).repeatCount(3, autoreverses: true), value: isHeartPulsating) // Плавная анимация пульсации
                        Text("\(favorites.count)")
                            .foregroundColor(.primary)
                    }
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .onAppear {
                self.favorites = FavoritesManager.shared.getFavorites()
            }
        }
    }
}

#Preview {
    FavoritesView()
}
