//
//  MealsScreenModel.swift
//  Fetch-Test-Assignment-Apprenticeship
//
//  Created by piro2 on 12/8/24.
//

import Foundation

final class MealsScreenModel: MealsScreenModelProtocol {
    @Published var status: MealsScreenStatusTypes
    
    // MARK: - Private
    private(set) var detailMeals: [DetailMeal]
    private let network: Networkable
    
    // MARK: - Init
    init(
        _ network: any Networkable = Network(),
        _ status: MealsScreenStatusTypes = .loading,
        _ detailMeals: [DetailMeal] = []
    ) {
        self.network = network
        self.status = status
        self.detailMeals = detailMeals
    }
}

// MARK: - Public
extension MealsScreenModel {
    func fetch() async {
        do {
            let meals = try await fetchMeals()
            try await fetchDetailMealAsync(from: meals)
            await updateStatus(.loaded(meals: meals))
        } catch {
            await updateStatus(.failed)
        }
    }
    
    func getDetailMeal(id: String) -> DetailMeal? {
        detailMeals.first(where: { $0.idMeal == id })
    }
}

// MARK: - Private
private extension MealsScreenModel {
    func fetchMeals() async throws -> [Meal] {
        try await network.fetch(by: .listMeals, for: ListMeals.self)
            .meals ?? []
            .sorted(by: { $0.displayName > $1.displayName })
    }
    
    func fetchDetailMealAsync(from meals: [Meal]) async throws {
        self.detailMeals = try await withThrowingTaskGroup(of: ListDetailMeals?.self) { group in
            for meal in meals {
                group.addTask {
                    return try await self.network.fetch(by: .listMealsBy(id: meal.id), for: ListDetailMeals.self)
                }
            }
            var detailMeals: [DetailMeal] = []
            for try await item in group {
                if let item, let detailMeal = item.meals?.first {
                    detailMeals.append(detailMeal)
                }
            }
            return detailMeals
        }
    }
    
    @MainActor
    func updateStatus(_ newStatus: MealsScreenStatusTypes) {
        status = newStatus
    }
}
