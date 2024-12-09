//
//  MealsScreenStatusTypes.swift
//  Fetch-Test-Assignment-Apprenticeship
//
//  Created by piro2 on 12/8/24.
//

enum MealsScreenStatusTypes {
    case loading
    case loaded(meals: [Meal])
    case failed
}
