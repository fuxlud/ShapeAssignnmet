import Foundation

@MainActor
class BreedPictureViewModel {
    
    private var breed: Breed

    public init(with breed: Breed) {
        self.breed = breed
    }
}
