//
//  AppConstants.swift
//  Fetch-Test-Assignment-Apprenticeship
//
//  Created by piro2 on 12/6/24.
//

import Foundation

struct AppConstants {
    
}

// MARK: - Endpoints
extension AppConstants {
    enum Endpoints {
        static let listDessertCategory = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        static let listDetailMeal = "https://themealdb.com/api/json/v1/1/lookup.php?i=%@"
        
        static func listDetailMeal(by id: String) -> String {
            String(format: listDetailMeal, id)
        }
    }
}

// MARK: - Errors
extension AppConstants {
    enum Errors {
        enum Network: Error {
            case invalidUrl
            case unexpectedStatusCode
            case decode
            case unknown
        }
        
        enum Cache: Error {
            case invalidURL
            case decodingFailed
            case networkError
        }
    }
}
