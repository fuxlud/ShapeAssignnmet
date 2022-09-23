import Foundation

protocol FavoritesManaging {
    func like(imageDetails: ImageDetails, breed: String) async
    func unlike(imageDetails: ImageDetails, breed: String) async
    func getFavoriteBreeds() async -> [String]
    func images(of breedName: String) async -> [ImageDetails]?
}

actor FavoritesManager: FavoritesManaging {
    
    static let shared = FavoritesManager()
    
    var favoritesByBreed: [String: [ImageDetails]] = [:]
    var allFavorites: [ImageDetails] = []
    let allKey = "all"
    
    func getFavoriteBreeds() async -> [String] {
        var favoriteBreeds = [allKey]
        favoriteBreeds.append(contentsOf: Array(favoritesByBreed.keys))
        return favoriteBreeds
    }
    
    func like(imageDetails: ImageDetails, breed: String) async {
        addImageToFavoritesByBreed(imageDetails: imageDetails, breed: breed)
        allFavorites.append(imageDetails)
    }
    
    func unlike(imageDetails: ImageDetails, breed: String) async {
        removeImageFromFavoritesByBreed(imageDetails: imageDetails, breed: breed)
        removeImageFromAllFavoritesB(imageDetails: imageDetails)
    }
    
    private func addImageToFavoritesByBreed(imageDetails: ImageDetails, breed: String) {
        var thisBreedFavorites = favoritesByBreed[breed]
        if thisBreedFavorites == nil {
            thisBreedFavorites = []
        }
        thisBreedFavorites?.append(imageDetails)
        favoritesByBreed[breed] = thisBreedFavorites
    }
    
    private func removeImageFromFavoritesByBreed(imageDetails: ImageDetails, breed: String) {
        let thisBreedFavorites = favoritesByBreed[breed]
        let filteredBreedFavorites = thisBreedFavorites?.filter { $0.url != imageDetails.url }
        if filteredBreedFavorites?.count == 0 {
            favoritesByBreed.removeValue(forKey: breed)
        } else {
            favoritesByBreed[breed] = filteredBreedFavorites
        }
    }
    
    private func removeImageFromAllFavoritesB(imageDetails: ImageDetails) {
        let filteredAllFavorites = allFavorites.filter { $0.url != imageDetails.url }
        allFavorites = filteredAllFavorites
    }
    
    func images(of breedName: String) async -> [ImageDetails]? {
        if breedName == allKey {
            return allFavorites
        }
        return favoritesByBreed[breedName]
    }
}
