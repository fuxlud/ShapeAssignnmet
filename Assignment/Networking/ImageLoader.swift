import Foundation
import UIKit

protocol ImageLoading {
    func loadImage(from url: URL) async throws -> UIImage
}

actor ImageLoader: ImageLoading {
    
    static let shared = ImageLoader()
        
    private let cache = NSCache<NSString, UIImage>()
    private let imageService: ImageService = WebService()
    
    func loadImage(from url: URL) async throws -> UIImage {
        
        let cacheKey = url.absoluteString
        
        if let image = cache.object(forKey: cacheKey as NSString) {
            return image
        } else {
            let image = try await imageService.loadImage(from: url)
            self.cache.setObject(image, forKey: cacheKey as NSString)
            return image
        }
    }
}
