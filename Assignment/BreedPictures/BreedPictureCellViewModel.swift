import Foundation
import UIKit

@MainActor
class BreedPictureCellViewModel {
    
    private let imageURL: URL!
    private let imageLoader: ImageLoader
    private let favoritesManager: FavoritesManaging
    
    private(set) var image: UIImage?
    private(set) var breed: Breed
    
    public init(with imageURL: URL,
                breed: Breed,
                imageLoader: ImageLoader = ImageLoader.shared,
                favoritesManager: FavoritesManaging = FavoritesManager.shared) {
        self.imageURL = imageURL
        self.breed = breed
        self.imageLoader = imageLoader
        self.favoritesManager = favoritesManager
    }
    
    func fetchImage() async throws -> UIImage? {
        image = try await imageLoader.loadImage(from: imageURL)
        return image
    }
    
    func imageTapped() {
        Task {
            await favoritesManager.likeImage(url: imageURL, breed: breed.name)
        }
    }
}
