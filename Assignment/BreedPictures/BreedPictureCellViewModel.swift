import Foundation
import UIKit

@MainActor
class BreedPictureCellViewModel {
    
    private var imageDetails: ImageDetails
    private let imageLoader: ImageLoading
    private let favoritesManager: FavoritesManaging
    
    private(set) var image: UIImage?
    
    public init(with imageDetails: ImageDetails,
                imageLoader: ImageLoading = ImageLoader.shared,
                favoritesManager: FavoritesManaging = FavoritesManager.shared) {
        self.imageDetails = imageDetails
        self.imageLoader = imageLoader
        self.favoritesManager = favoritesManager
    }
    
    func fetchImage() async throws -> UIImage? {
        image = try await imageLoader.loadImage(from: imageDetails.url)
        return image
    }
    
    func imageLikeStateShouldChange() {
        let isFavoriteBeforeTap = imageDetails.isFavorite
        imageDetails.isFavorite.toggle()
        Task {
            if isFavoriteBeforeTap {
                await favoritesManager.unlike(imageDetails: imageDetails)
            } else {
                await favoritesManager.like(imageDetails: imageDetails)
            }
        }
    }
    
    var isFavorite: Bool {
        return imageDetails.isFavorite
    }
    
    var breedName: String {
        return imageDetails.breedName
    }
}
