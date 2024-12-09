//
//  ContentView.swift
//  Fetch-Test-Assignment-Apprenticeship
//
//  Created by piro2 on 12/6/24.
//

import SwiftUI

struct MealsScreen<ViewModel: MealsScreenModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    
    // MARK: - Init
    init(_ viewModel: ViewModel = MealsScreenModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            switch viewModel.status {
            case .loading:
                ProgressView()
            case .loaded(let meals):
                List(meals) { meal in
                    NavigationLink(value: meal) {
                        MealsCell(meal: meal)
                    }
                }
                .listStyle(.insetGrouped)
                .navigationDestination(for: Meal.self) { item in
                    if let detailMeal = viewModel.getDetailMeal(id: item.id) {
                        DetailMealScreen(detailMeal: detailMeal)
                    }
                }
            case .failed:
                Text("Something goes wrong")
            }
        }
        .task(taskAction)
    }
}

// MARK: - Func
private extension MealsScreen {
    @Sendable func taskAction() async {
        await viewModel.fetch()
    }
}

// MARK: - Preview
#Preview {
    MealsScreen()
}
