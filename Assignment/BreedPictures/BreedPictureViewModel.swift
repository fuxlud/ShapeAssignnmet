import Foundation

@MainActor
class BreedPictureViewModel {
    
    private(set) var breed: Breed

    public init(with breed: Breed) {
        self.breed = breed
    }
}
