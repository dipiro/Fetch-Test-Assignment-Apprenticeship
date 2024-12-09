//
//  Meal.swift
//  Fetch-Test-Assignment-Apprenticeship
//
//  Created by piro2 on 12/6/24.
//

import Foundation

struct Meal: Identifiable, Decodable, Hashable  {
    let id: String
    let name: String?
    let imageUrlString: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageUrlString = "strMealThumb"
    }
}

// MARK: - 
extension Meal {
    var displayName: String {
        name ?? ""
    }
    
    var displayImageUrl: URL? {
        if let imageUrlString {
            return URL(string: imageUrlString)
        }
        
        return nil
    }
}
 
