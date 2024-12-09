//
//  UserEndpoints.swift
//  Fetch-Test-Assignment-Apprenticeship
//
//  Created by piro2 on 12/8/24.
//

enum UserEndpoints {
    case listMeals
    case listMealsBy(id: String)
    
    var endpoint: String {
        switch self {
        case .listMeals:
            AppConstants.Endpoints.listDessertCategory
        case .listMealsBy(let id):
            AppConstants.Endpoints.listDetailMeal(by: id)
        }
    }
}
