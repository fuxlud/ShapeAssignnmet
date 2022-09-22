import Foundation

protocol DogImagesService {
    func getBreedImages() async throws -> [URL]
}

extension WebService: DogImagesService {
    func getBreedImages() async throws -> [URL] {
        let request = BreedImagesRequest()

        let result = try await request.execute(on: router)
        let urls: [URL] = [URL(string: "www.google.com")!, URL(string: "www.apple.com")!]
        return urls
//        if let breedsContainer = result as? BreedsRespose {
//            let breeds = breedsContainer.message.breeds
//            return breeds
//
//        } else {
//            throw NetworkError.parcingError
//        }
    }
}

struct BreedImagesRequest: RequestTypeProtocol {
    typealias ResponseType = BreedsRespose

    var request: Request {
        var components = URLComponents()
        components.scheme = NetworkScheme.https.rawValue
        components.host = NetworkHost.dogs.rawValue
        components.path = EndPoint.allBreeds.rawValue
        let path = components.url?.absoluteString ?? ""

        return Request(path: path, method: .get)
    }
}
