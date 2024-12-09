//
//  DetailMeal.swift
//  Fetch-Test-Assignment-Apprenticeship
//
//  Created by piro2 on 12/8/24.
//

import Foundation

struct DetailMeal: Codable {
    let idMeal: String?
    let strMeal: String?
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strIngredient1, strIngredient2, strIngredient3, strIngredient4: String?
    let strIngredient5, strIngredient6, strIngredient7, strIngredient8: String?
    let strIngredient9, strIngredient10, strIngredient11, strIngredient12: String?
    let strIngredient13, strIngredient14, strIngredient15, strIngredient16: String?
    let strIngredient17, strIngredient18, strIngredient19, strIngredient20: String?
    let strMeasure1, strMeasure2, strMeasure3, strMeasure4: String?
    let strMeasure5, strMeasure6, strMeasure7, strMeasure8: String?
    let strMeasure9, strMeasure10, strMeasure11, strMeasure12: String?
    let strMeasure13, strMeasure14, strMeasure15, strMeasure16: String?
    let strMeasure17, strMeasure18, strMeasure19, strMeasure20: String?
    let strSource: String?
    let strImageSource, strCreativeCommonsConfirmed, dateModified: String?
}

// MARK: - 
extension DetailMeal {
    var displayId: String {
        idMeal ?? ""
    }
    
    var displayName: String {
        strMeal ?? ""
    }
    
    var displayIngredients: [String] {
        let ingredients = [
            strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6,
            strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12,
            strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18,
            strIngredient19, strIngredient20
        ]
            .compactMap { $0?.isEmpty == false ? $0 : nil }
        
        return ingredients
    }
    
    var displayMeasures: [String] {
        let measures = [
            strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
            strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11,
            strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17,
            strMeasure18, strMeasure19, strMeasure20
        ]
            .compactMap { $0?.isEmpty == false ? $0 : nil }
        
        return measures
    }
    
    var displayIngredientsAndMeasures: [String] {
        zip(displayIngredients, displayMeasures)
            .map { "\($0): \($1)" }
    }
    
    var displayInstructions: String {
        strInstructions ?? ""
    }
    
    var displayImageUrl: URL? {
        if let strMealThumb {
            return URL(string: strMealThumb)
        }
        
        return nil
    }
}
