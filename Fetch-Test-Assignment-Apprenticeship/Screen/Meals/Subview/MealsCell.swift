//
//  MealsCell.swift
//  Fetch-Test-Assignment-Apprenticeship
//
//  Created by piro2 on 12/7/24.
//

import SwiftUI

struct MealsCell: View {
    var meal: Meal
    
    // MARK: - Body
    var body: some View {
        HStack {
            CachedAsyncImage(meal.displayImageUrl) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 6))
            } placeholder: {
                ProgressView()
            }
            .frame(width: 56, height: 56)

            Text(meal.displayName)
        }
    }
}
