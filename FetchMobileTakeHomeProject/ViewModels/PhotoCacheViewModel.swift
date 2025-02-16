//
//  PhotoCacheViewModel.swift
//  FetchMobileTakeHomeProject
//
//  Created by Ricardo Garza on 2/14/25.
//

import SwiftUI
import Combine

actor PhotoCacheViewModel {
    private var cache = NSCache<NSString, UIImage>()
    
    func image(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}

extension View {
    func loadImage(from url: URL, cache: PhotoCacheViewModel) async -> UIImage? {
        if let cachedImage = await cache.image(forKey: url.absoluteString) {
            return cachedImage
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                await cache.setImage(image, forKey: url.absoluteString)
                return image
            }
        } catch {
            print("Failed to load image: \(error)")
        }
        return nil
    }
}
