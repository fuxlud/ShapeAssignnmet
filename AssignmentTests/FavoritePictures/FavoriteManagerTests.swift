import XCTest
@testable import Assignment

final class FavoriteManagerTests: XCTestCase {

    var sut: FavoritesManager!
    let localPersistenceSpy = LocalPersistenceSpy()
    
    override func setUpWithError() throws {
        sut = FavoritesManager(localPersistence: localPersistenceSpy)
    }

    func testLikingSavesImageToFavoritesByBreedToLocalPersistance() async throws  {
        let imageDetails = ImageDetails(url: URL(string: "www.shape.dk")!)
        imageDetails.breedName = "shuki"
        
        await sut.like(imageDetails: imageDetails)
        
        let favoritesByBreed = loadFavoritesByBreedFromLocalPersistanceSpy()
        XCTAssertEqual(favoritesByBreed.keys.first, "shuki")
    }

    private func loadFavoritesByBreedFromLocalPersistanceSpy() -> [String: [ImageDetails]] {
        let favoritesByBreedData = localPersistenceSpy.object(forKey: "favoritesByBreed") as! Data
        let decoder = JSONDecoder()
        let favoritesByBreed = try! decoder.decode([String: [ImageDetails]].self, from: favoritesByBreedData)
        return favoritesByBreed
    }

}
