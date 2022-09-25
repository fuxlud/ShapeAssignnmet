import Foundation

protocol DogsService {
    func getAllBreeds() async throws -> [Breed]
}

extension WebService: DogsService {
    func getAllBreeds() async throws -> [Breed] {
        let request = BreedRequest()

        let result = try await request.execute(on: router)

        if let breedsContainer = result as? BreedsResponse {
            let breeds = breedsContainer.message.breeds.sorted{ $0.name < $1.name }
            return breeds
        } else {
            throw NetworkError.parcingError
        }
    }
}

struct BreedRequest: RequestTypeProtocol {
    typealias ResponseType = BreedsResponse

    var request: Request {
        var components = URLComponents()
        components.scheme = NetworkScheme.https.rawValue
        components.host = NetworkHost.dogs.rawValue
        components.path = EndPoint.allBreeds.rawValue
        let path = components.url?.absoluteString ?? ""

        return Request(path: path, method: .get)
    }
}
