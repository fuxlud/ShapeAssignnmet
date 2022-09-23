import Foundation

protocol DogImagesService {
    func getBreedImages(breed: String,
                        favoritesManager: FavoritesManaging) async throws -> [ImageDetails]
}

extension WebService: DogImagesService {
    func getBreedImages(breed: String,
                        favoritesManager: FavoritesManaging) async throws -> [ImageDetails] {
        let request = BreedImagesRequest(breed: breed)
        
        let result = try await request.execute(on: router)
        
        if let imagesContainer = result as? BreedImagesResponce {
            let imagesDetails = imagesContainer.imagesDetails
            
            if let favoriteImagesOfBreed = await favoritesManager.images(of: breed) {
                for imageDetails in imagesDetails {
                    if favoriteImagesOfBreed.contains(where: { $0.url == imageDetails.url }) {
                        imageDetails.isFavorite = true
                    }
                }
            }
            return imagesDetails

        } else {
            throw NetworkError.parcingError
        }
    }
}

struct BreedImagesRequest: RequestTypeProtocol {
    typealias ResponseType = BreedImagesResponce

    let breed: String
    
    var request: Request {
        var components = URLComponents()
        components.scheme = NetworkScheme.https.rawValue
        components.host = NetworkHost.dogs.rawValue
        components.path = String(format: EndPoint.breedImages.rawValue, breed)
        let path = components.url?.absoluteString ?? ""

        return Request(path: path, method: .get)
    }
}
