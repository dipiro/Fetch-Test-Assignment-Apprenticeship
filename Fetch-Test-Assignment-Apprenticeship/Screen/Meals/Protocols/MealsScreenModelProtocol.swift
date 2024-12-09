//
//  MealsScreenModelProtocol.swift
//  Fetch-Test-Assignment-Apprenticeship
//
//  Created by piro2 on 12/8/24.
//

import SwiftUI

protocol MealsScreenModelProtocol: ObservableObject {
    var status: MealsScreenStatusTypes { get }
    
    init(_ network: Networkable, _ status: MealsScreenStatusTypes, _ detailMeals: [DetailMeal])
    
    func fetch() async
    func getDetailMeal(id: String) -> DetailMeal?
}
