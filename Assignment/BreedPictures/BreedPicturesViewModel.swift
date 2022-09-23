import Foundation

@MainActor
class BreedPicturesViewModel {
    
    private(set) var breed: Breed
    private(set) var favoriteImagesOfBreed = [ImageDetails]()
    private let dogImagesService: DogImagesService
    private var favoritesManager: FavoritesManaging

    public init(with breed: Breed,
                dogImagesService: DogImagesService = WebService(),
                favoritesManager: FavoritesManaging = FavoritesManager.shared) {
        self.breed = breed
        self.dogImagesService = dogImagesService
        self.favoritesManager = favoritesManager
    }
    
    func loadImages() async throws {
        try await dogImagesService.getBreedImages(breed: breed, favoritesManager: favoritesManager)
        await favoriteImagesOfBreed = favoritesManager.images(of: breed.name) ?? []
    }
    
    var imagesDetails: [ImageDetails] {
        breed.breedImages
    }
}
