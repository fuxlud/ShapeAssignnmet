import Foundation

@MainActor
class FavoritePicturesViewModel {

    private var favoritesManager: FavoritesManaging
    private(set) var favoriteBreeds: [String] = []
    
    init(favoritesManager: FavoritesManaging = FavoritesManager.shared) {
        self.favoritesManager = favoritesManager
    }
    
    func getFavoriteBreeds() async {
        favoriteBreeds = await favoritesManager.getFavoriteBreeds()
    }
}
