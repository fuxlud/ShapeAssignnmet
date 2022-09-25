import Foundation


struct Breeds: Decodable {
    struct BreedKey: CodingKey {
        
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }
    }

    let breeds: [Breed]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BreedKey.self)
        var extractedBreeds: [Breed] = []
        for key in container.allKeys{
            extractedBreeds.append(Breed(name: key.stringValue))
        }
        breeds = extractedBreeds
    }
}

class Breed: Decodable {
    let name: String
    var breedImages: [ImageDetails] = []
    
    init(name: String, breedImages: [ImageDetails] = []) {
        self.name = name
        self.breedImages = breedImages
    }
}

struct BreedsResponse: Decodable {
    let message: Breeds
}
