//import Foundation
//import UIKit
//
//final class ImageLoader {
//    
//    static let shared = ImageLoader()
//        
//    private let cache = NSCache<NSString, UIImage>()
////    private let network: ImageNetworking = NetworkService()
//    
//    func loadImage(url: URL) async throws -> UIImage? {
//        
//        let cacheKey = url.absoluteString
//        
//        if let image = cache.object(forKey: cacheKey as NSString) {
//            return image
//        } else {
//            network.getImage(urlString: url.absoluteString) { [weak self] image in
//                guard let self = self, let image = image else {
//                    return nil
//                }
//
//                self.cache.setObject(image, forKey: cacheKey as NSString)
//                return image
//            }
//        }
//    }
//}
