import Foundation

public struct Breed: Decodable {
    let name: String
}

public struct BreedsContainer: Decodable {
    let breeds: [Breed]
}
