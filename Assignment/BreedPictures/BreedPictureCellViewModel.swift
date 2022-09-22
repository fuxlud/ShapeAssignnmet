import Foundation
import UIKit

@MainActor
class BreedPictureCellViewModel {
    
    private let imageURL: URL!
    private let imageLoader: ImageLoader
    private(set) var image: UIImage?

    public init(with imageURL: URL,
                imageLoader: ImageLoader = ImageLoader.shared) {
        self.imageURL = imageURL
        self.imageLoader = imageLoader
    }
    
    func fetchImage() async throws -> UIImage? {
        image = try await imageLoader.loadImage(from: imageURL)
        return image
    }
}
