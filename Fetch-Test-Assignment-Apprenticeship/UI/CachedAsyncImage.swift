//
//  CachedAsyncImage.swift
//  Fetch-Test-Assignment-Apprenticeship
//
//  Created by piro2 on 12/8/24.
//

import SwiftUI

struct CachedAsyncImage<ImageView: View, Placeholder: View>: View {
    @ViewBuilder var content: (Image) -> ImageView
    @ViewBuilder var placeholder: () -> Placeholder
        
    // MARK: - Private
    @State private var image: Image?
    private var url: URL?
    private var cacheManager: ImageCacheManager
    
    // MARK: - Init
    init(
        _ url: URL?,
        @ViewBuilder content: @escaping (Image) -> ImageView,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
        self.cacheManager = .shared
        self.image = nil
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            if let image = self.image {
                content(image)
            } else {
                placeholder()
                    .onAppear(perform: loadImage)
            }
        }
    }
}

// MARK: - Private
private extension CachedAsyncImage {
    func loadImage() {
        Task {
            let result = await cacheManager.loadImage(from: url)
            
            await MainActor.run {
                switch result {
                case .success(let image):
                    self.image = image
                case .failure(_):
                    break
                }
            }
        }
    }
}
