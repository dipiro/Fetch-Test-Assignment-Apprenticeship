//
//  ImageCacheManager.swift
//  Fetch-Test-Assignment-Apprenticeship
//
//  Created by piro2 on 12/8/24.
//

import Foundation
import SwiftUI

struct ImageCacheManager {
    static let shared = ImageCacheManager()
    
    // MARK: - Private
    private let urlSession: URLSession = .shared
    private let urlCache: URLCache = .shared
    
    // MARK: - Init
    private init() {
        
    }
}

// MARK: - Func
extension ImageCacheManager {
    func loadImage(from url: URL?) async -> Result<Image, AppConstants.Errors.Cache> {
        guard let url = url else { return .failure(.invalidURL) }
        
        if let cachedImage = await loadCachedImage(from: url) {
            return .success(cachedImage)
        }
        
        do {
            let image = try await fetchAndCacheImage(from: url)
            return .success(image)
        } catch {
            return .failure(.networkError)
        }
    }
    
    func loadCachedImage(from url: URL) async -> Image? {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        if let cachedResponse = urlCache.cachedResponse(for: request),
           let cachedImage = UIImage(data: cachedResponse.data) {
            return Image(uiImage: cachedImage)
        }
        
        return nil
    }
    
    func fetchAndCacheImage(from url: URL) async throws -> Image {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        let (data, response) = try await urlSession.data(for: request)
        
        let cachedData = CachedURLResponse(response: response, data: data)
        urlCache.storeCachedResponse(cachedData, for: request)
        
        guard let cachedImage = UIImage(data: cachedData.data) else {
            throw AppConstants.Errors.Cache.decodingFailed
        }
        
        return Image(uiImage: cachedImage)
    }
}
