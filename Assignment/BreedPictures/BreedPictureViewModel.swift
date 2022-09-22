import Foundation

@MainActor
class BreedPictureViewModel {
    
    private(set) var breed: Breed
    private(set) var imageURLs = [URL]()

    public init(with breed: Breed) {
        self.breed = breed
    }
    
    func fetchImages() async throws {
//        let fetchedBreeds = try await dogsService.getAllBreeds()
//        breeds = fetchedBreeds
    }
}
