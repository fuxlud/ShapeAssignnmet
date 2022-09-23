import Foundation
import UIKit

@MainActor
class BreedPictureCellViewModel {
    
    private let imageDetails: ImageDetails
    private let imageLoader: ImageLoader // TODO: dependency injection
    private let favoritesManager: FavoritesManaging
    
    private(set) var image: UIImage?
    private(set) var breed: Breed
    
    public init(with imageDetails: ImageDetails,
                breed: Breed,
                imageLoader: ImageLoader = ImageLoader.shared,
                favoritesManager: FavoritesManaging = FavoritesManager.shared) {
        self.imageDetails = imageDetails
        self.breed = breed
        self.imageLoader = imageLoader
        self.favoritesManager = favoritesManager
    }
    
    func fetchImage() async throws -> UIImage? {
        image = try await imageLoader.loadImage(from: imageDetails.url)
        return image
    }
    
    func imageTapped() {
        Task {
//            await favoritesManager.likeImage(url: imageURL, breed: breed.name)
        }
    }
}
