import Foundation

protocol FavoritesManaging {
    func like(imageDetails: ImageDetails) async
    func unlike(imageDetails: ImageDetails) async
    func getFavoriteBreeds() async -> [String]
    func images(of breed: String) async -> [ImageDetails]?
}

actor FavoritesManager: FavoritesManaging {
    
    static let shared = FavoritesManager()
    
    var favoritesByBreed: [String: [ImageDetails]] = [:]
    var allFavorites: [ImageDetails] = []
    let allKey = "all"
    let favoritesByBreedKey = "favoritesByBreed"
    let allFavoritesKey = "allFavorites"
    
    private init() {
        if let favoritesByBreedData = UserDefaults.standard.data(forKey: favoritesByBreedKey),
           let allFavoritesData = UserDefaults.standard.data(forKey: allFavoritesKey)
        {
            do {
                let decoder = JSONDecoder()
                favoritesByBreed = try decoder.decode([String: [ImageDetails]].self, from: favoritesByBreedData)
                allFavorites = try decoder.decode([ImageDetails].self, from: allFavoritesData)
            } catch {}
        }
    }
    
    func getFavoriteBreeds() async -> [String] {
        var favoriteBreeds = [allKey]
        favoriteBreeds.append(contentsOf: Array(favoritesByBreed.keys))
        return favoriteBreeds
    }
    
    func like(imageDetails: ImageDetails) async {
        addImageToFavoritesByBreed(imageDetails: imageDetails)
        allFavorites.append(imageDetails)
        updateLocalPersistance()
    }
    
    func unlike(imageDetails: ImageDetails) async {
        removeImageFromFavoritesByBreed(imageDetails: imageDetails)
        removeImageFromAllFavoritesB(imageDetails: imageDetails)
        updateLocalPersistance()
    }
    
    func images(of breedName: String) async -> [ImageDetails]? {
        if breedName == allKey {
            return allFavorites
        }
        return favoritesByBreed[breedName]
    }
    
    private func addImageToFavoritesByBreed(imageDetails: ImageDetails) {
        let breedName = imageDetails.breedName
        var thisBreedFavorites = favoritesByBreed[breedName]
        if thisBreedFavorites == nil {
            thisBreedFavorites = []
        }
        thisBreedFavorites?.append(imageDetails)
        favoritesByBreed[breedName] = thisBreedFavorites
    }
    
    private func removeImageFromFavoritesByBreed(imageDetails: ImageDetails) {
        let thisBreedFavorites = favoritesByBreed[imageDetails.breedName]
        let filteredBreedFavorites = thisBreedFavorites?.filter { $0.url != imageDetails.url }
        if filteredBreedFavorites?.count == 0 {
            favoritesByBreed.removeValue(forKey: imageDetails.breedName)
        } else {
            favoritesByBreed[imageDetails.breedName] = filteredBreedFavorites
        }
    }
    
    private func removeImageFromAllFavoritesB(imageDetails: ImageDetails) {
        let filteredAllFavorites = allFavorites.filter { $0.url != imageDetails.url }
        allFavorites = filteredAllFavorites
    }
    
    private func updateLocalPersistance() {
        do {
            let encoder = JSONEncoder()
            let favoritesByBreedData = try encoder.encode(favoritesByBreed)
            let allFavoritesData = try encoder.encode(allFavorites)
            
            UserDefaults.standard.set(favoritesByBreedData, forKey: favoritesByBreedKey)
            UserDefaults.standard.set(allFavoritesData, forKey: allFavoritesKey)
        } catch {
            
        }
    }
}
