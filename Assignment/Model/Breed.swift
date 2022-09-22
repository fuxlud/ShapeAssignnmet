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

struct Breed: Decodable {
    let name: String
}


struct BreedsRespose: Decodable {
    let message: Breeds
}

struct BreedImagesResponce: Decodable {
    let message: [URL]
}
