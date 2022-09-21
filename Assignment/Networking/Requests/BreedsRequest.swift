import Foundation

protocol DogsService {
    func getAllBreeds() async throws -> [Breed]
}

extension WebService: DogsService {
    func getAllBreeds() async throws -> [Breed] {
        let request = BreedRequest()

        let result = try await request.execute(on: router)

        if let breedsContainer = result as? BreedsRespose {
            let breeds = breedsContainer.message.breeds
            return breeds
        } else {
            throw NetworkError.parcingError
        }
    }
}

struct BreedRequest: RequestTypeProtocol {
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
