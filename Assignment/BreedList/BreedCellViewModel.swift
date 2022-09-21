import Foundation

class BreedCellViewModel {
    
    private var breed: Breed!
    
    public init(with breed: Breed) {
        self.breed = breed
    }
    
    public var breedName: String {
        return breed.name
    }
}
