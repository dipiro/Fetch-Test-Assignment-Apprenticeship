//
//  Fetch_Test_Assignment_ApprenticeshipTests.swift
//  Fetch-Test-Assignment-ApprenticeshipTests
//
//  Created by piro2 on 12/8/24.
//

import Testing
@testable import Fetch_Test_Assignment_Apprenticeship

struct Fetch_Test_Assignment_ApprenticeshipTests {
    let viewModel = MealsScreenModel()
    let imageCache = ImageCacheManager.shared
    
    @Test func viewModelFetchText() async throws {
        await viewModel.fetch()
        
        if case .loaded(let meals) = viewModel.status {
            #expect(meals.count > 0)
        }
    }
    
    // MARK: - Cache Tests
    @Test func loadCachedImageTest() async {
        if let url = Preview.meal.displayImageUrl {
            _ = try? await imageCache.fetchAndCacheImage(from: url)
            
            let cachedImage = await imageCache.loadCachedImage(from: url)
            #expect(cachedImage != nil)
        }
    }
}
