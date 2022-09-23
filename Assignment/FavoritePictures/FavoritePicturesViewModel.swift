import Foundation

@MainActor
class FavoritePicturesViewModel {

    private var favoritesManager: FavoritesManaging
    private(set) var favoriteBreedNames: [String] = []
    private(set) var imagesOfSpecificBreed: [ImageDetails] = []
    
    init(favoritesManager: FavoritesManaging = FavoritesManager.shared) {
        self.favoritesManager = favoritesManager
    }
    
    func loadFavoriteBreedNames() async {
        favoriteBreedNames = await favoritesManager.getFavoriteBreeds()
    }
    
    func loadImages(of breedName: String) async {
        await imagesOfSpecificBreed = favoritesManager.images(of: breedName) ?? []
    }
    
    func imagesOfSpecificBreed(at index: Int) -> ImageDetails? {
        if imagesOfSpecificBreed.count >= index {
            return imagesOfSpecificBreed[index]
        } else {
            return nil
        }
    }
}
