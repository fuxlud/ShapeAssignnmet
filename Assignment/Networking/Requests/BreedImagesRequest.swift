import Foundation

protocol DogImagesService {
    func getBreedImages(breed: String) async throws -> [URL]
}

extension WebService: DogImagesService {
    func getBreedImages(breed: String) async throws -> [URL] {
        let request = BreedImagesRequest(breed: breed)

        let result = try await request.execute(on: router)
        
        if let breedsContainer = result as? BreedImagesResponce {
            let breeds = breedsContainer.message
            return breeds

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
