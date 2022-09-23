import Foundation
import UIKit

@MainActor
class BreedPictureCellViewModel {
    
    private var imageDetails: ImageDetails
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
    
    func imageLikeStateShouldChange() {
        imageDetails.isFavorite.toggle()
        Task {
            await favoritesManager.like(imageDetails: imageDetails, breed: breed.name)
        }
    }
    
    var isFavorite: Bool {
        return imageDetails.isFavorite
    }
}
