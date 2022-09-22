import Foundation

protocol FavoritesManaging {
    func likeImage(url: URL, breed: String) async
    func unlikeImage(url: URL, breed: String) async
    func getFavoriteBreeds() async -> [String]
}

actor FavoritesManager: FavoritesManaging {
    
    static let shared = FavoritesManager()
    
    var favoritesByBreed: [String: [URL]] = [:]
    let allKey = "All"
    
    init() {
        favoritesByBreed[allKey] = []
    }
    
    func getFavoriteBreeds() async -> [String] {
        return Array(favoritesByBreed.keys)
    }
    
    func likeImage(url: URL, breed: String) async {
        addImageToFavoritesByBreed(url: url, breed: breed)
        addImageToFavoritesByBreed(url: url, breed: allKey)
    }
    
    func unlikeImage(url: URL, breed: String) async {
        removeImageFromFavoritesByBreed(url: url, breed: breed)
        removeImageFromFavoritesByBreed(url: url, breed: allKey)
    }
    
    private func addImageToFavoritesByBreed(url: URL, breed: String) {
        var thisBreedFavorites = favoritesByBreed[breed]
        thisBreedFavorites?.append(url)
        favoritesByBreed[breed] = thisBreedFavorites
    }
    
    private func removeImageFromFavoritesByBreed(url: URL, breed: String) {
        var thisBreedFavorites = favoritesByBreed[breed]
        thisBreedFavorites?.append(url)
        favoritesByBreed[breed] = thisBreedFavorites
    }
    
}
