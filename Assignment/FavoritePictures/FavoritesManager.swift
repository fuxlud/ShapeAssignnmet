import Foundation

protocol FavoritesManaging {
    func like(imageDetails: ImageDetails) async
    func unlike(imageDetails: ImageDetails) async
    func getFavoriteBreeds() async -> [String]
    func images(of breed: String) async -> [ImageDetails]?
}

actor FavoritesManager: FavoritesManaging {
    
    static let shared = FavoritesManager()
    
    let allKey = "all"
    let favoritesByBreedKey = "favoritesByBreed"
    
    private(set) var favoritesByBreed: [String: [ImageDetails]] = [:]
    private(set) var allFavorites: [ImageDetails] = []
    private let localStorage: LocalStorage
    
    init(localStorage: LocalStorage = UserDefaults.standard ) {
        self.localStorage = localStorage
        Task {
            await loadFavoritesFromLocalStorage()
            await loadAllFavoritesFromFavoritesByBreed()
        }
    }
    
    func getFavoriteBreeds() async -> [String] {
        var favoriteBreeds = [allKey]
        favoriteBreeds.append(contentsOf: Array(favoritesByBreed.keys).sorted(by: <))
        return favoriteBreeds
    }
    
    func like(imageDetails: ImageDetails) async {
        addImageToFavoritesByBreed(imageDetails: imageDetails)
        allFavorites.append(imageDetails)
        updateLocalStorage()
    }
    
    func unlike(imageDetails: ImageDetails) async {
        removeImageFromFavoritesByBreed(imageDetails: imageDetails)
        removeImageFromAllFavorites(imageDetails: imageDetails)
        updateLocalStorage()
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
    
    private func removeImageFromAllFavorites(imageDetails: ImageDetails) {
        let filteredAllFavorites = allFavorites.filter { $0.url != imageDetails.url }
        allFavorites = filteredAllFavorites
    }
    
    private func updateLocalStorage() {
        do {
            let favoritesByBreedData = try JSONEncoder().encode(favoritesByBreed)            
            localStorage.set(favoritesByBreedData, forKey: favoritesByBreedKey)
        } catch {}
    }
    
    private func loadFavoritesFromLocalStorage() {
        if let favoritesByBreedData = localStorage.data(forKey: favoritesByBreedKey)
        {
            do {
                let decoder = JSONDecoder()
                favoritesByBreed = try decoder.decode([String: [ImageDetails]].self, from: favoritesByBreedData)
            } catch {}
        }
    }
    
    private func loadAllFavoritesFromFavoritesByBreed() {
        for dic in favoritesByBreed {
            allFavorites.append(contentsOf: dic.value)
        }
    }
}
