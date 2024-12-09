//
//  DetailMealScreen.swift
//  Fetch-Test-Assignment-Apprenticeship
//
//  Created by piro2 on 12/7/24.
//

import SwiftUI

struct DetailMealScreen: View {
    let detailMeal: DetailMeal
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                image
                
                section("Instruction") {
                    Text(detailMeal.displayInstructions)
                }
                
                Divider()
                
                section("Ingredients") {
                    ForEach(detailMeal.displayIngredientsAndMeasures.indices, id: \.self) { index in
                        Text("\(index + 1)) \(detailMeal.displayIngredientsAndMeasures[index])")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                }
            }
            .navigationTitle(detailMeal.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}

// MARK: - Private
extension DetailMealScreen {
    var image: some View {
        CachedAsyncImage(detailMeal.displayImageUrl) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
        }
        .frame(height: 240)
        .clipShape(.rect(cornerRadius: 24))
        .clipped()
    }
    
    func section<Content: View>(_ text: String, content: () -> Content) -> some View {
        Section {
            content()
        } header: {
            HStack {
                Text(text)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        DetailMealScreen(detailMeal: Preview.detailMeal)
    }
}
