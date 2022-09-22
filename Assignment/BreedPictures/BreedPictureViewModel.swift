import Foundation

@MainActor
class BreedPictureViewModel {
    
    private(set) var breed: Breed
    private(set) var imageURLs = [URL]()
    private let dogImagesService: DogImagesService
    
    public init(with breed: Breed,
                dogImagesService: DogImagesService = WebService()) {
        self.breed = breed
        self.dogImagesService = dogImagesService
    }
    
    func fetchImages() async throws {
        let fetchedImageUrls = try await dogImagesService.getBreedImages()
        imageURLs = fetchedImageUrls
    }
}
