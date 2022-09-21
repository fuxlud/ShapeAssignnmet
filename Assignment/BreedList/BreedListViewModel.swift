import Foundation

@MainActor
class BreedListViewModel {
   
    private(set) var breeds = [Breed]()
    private var dogsService: DogsService
    
    init(dogsService: DogsService = WebService()) {
        self.dogsService = dogsService
    }
    
    func fetchBreeds() async throws {
        let fetchedBreeds = try await dogsService.getAllBreeds()
        breeds = fetchedBreeds
    }
    
    var numberOfBreeds: Int {
        return breeds.count
    }
    
}
