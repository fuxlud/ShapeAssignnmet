import Foundation
import UIKit

@MainActor
class BreedPictureCellViewModel {
    
    private let imageURL: URL! //TODO: private
    private let imageService: ImageService
    private(set) var image: UIImage?

    public init(with imageURL: URL,
                imageService: ImageService = WebService()) {
        self.imageURL = imageURL
        self.imageService = imageService
    }
    
    func fetchImage() async throws -> UIImage? {
        image = try await imageService.getImage(from: imageURL)
        return image
    }
}
