import Foundation

protocol DogImagesService {
    func getBreedImages(breed: Breed,
                        favoritesManager: FavoritesManaging) async throws
}

extension WebService: DogImagesService {
    func getBreedImages(breed: Breed,
                        favoritesManager: FavoritesManaging) async throws {
        let request = BreedImagesRequest(breed: breed)
        
        let result = try await request.execute(on: router)
        
        if let imagesContainer = result as? BreedImagesResponse {
            let imagesDetails = imagesContainer.imagesDetails
            
            if let favoriteImagesOfBreed = await favoritesManager.images(of: breed.name) {
                for imageDetails in imagesDetails {
                    imageDetails.breedName = breed.name
                    if favoriteImagesOfBreed.contains(where: { $0.url == imageDetails.url }) {
                        imageDetails.isFavorite = true
                    }
                }
            } else {
                for imageDetails in imagesDetails {
                    imageDetails.breedName = breed.name
                }
            }
            breed.breedImages = imagesDetails

        } else {
            throw NetworkError.parcingError
        }
    }
}

struct BreedImagesRequest: RequestTypeProtocol {
    typealias ResponseType = BreedImagesResponse

    let breed: Breed
    
    var request: Request {
        var components = URLComponents()
        components.scheme = NetworkScheme.https.rawValue
        components.host = NetworkHost.dogs.rawValue
        components.path = String(format: EndPoint.breedImages.rawValue, breed.name)
        let path = components.url?.absoluteString ?? ""

        return Request(path: path, method: .get)
    }
}
