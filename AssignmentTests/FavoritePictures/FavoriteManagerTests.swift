import XCTest
@testable import Assignment

final class FavoriteManagerTests: XCTestCase {

    var sut: FavoritesManager!
    let localPersistenceSpy = LocalPersistenceSpy()
    let imageDetails = ImageDetails(url: URL(string: "www.shape.dk")!)
    let breedName = "shuki"
    
    override func setUpWithError() throws {
        sut = FavoritesManager(localPersistence: localPersistenceSpy)
        imageDetails.breedName = breedName
    }

    func testLikingSavesImageToFavoritesByBreedToLocalPersistance() async throws {
        await sut.like(imageDetails: imageDetails)
        let favoritesByBreedRecorded = loadFavoritesByBreedFromLocalPersistanceSpy()
        XCTAssertEqual(favoritesByBreedRecorded.keys.first, "shuki")
    }

    private func loadFavoritesByBreedFromLocalPersistanceSpy() -> [String: [ImageDetails]] {
        let favoritesByBreedData = localPersistenceSpy.object(forKey: "favoritesByBreed") as! Data
        let decoder = JSONDecoder()
        let favoritesByBreed = try! decoder.decode([String: [ImageDetails]].self, from: favoritesByBreedData)
        return favoritesByBreed
    }
    
    func testLikingSavesImageToLocalPersistanceSpy() async throws {
        await sut.like(imageDetails: imageDetails)
        
        let allFavoritesRecorded = loadAllFavoritesFromLocalPersistanceSpy()
        let imageRecorded = allFavoritesRecorded.first!
        XCTAssertEqual(imageRecorded, imageDetails)
    }
    
    private func loadAllFavoritesFromLocalPersistanceSpy() -> [ImageDetails] {
        let allFavoritesData = localPersistenceSpy.object(forKey: "allFavorites") as! Data
        let decoder = JSONDecoder()
        let allFavorites = try! decoder.decode([ImageDetails].self, from: allFavoritesData)
        return allFavorites
    }

    func testUnlikingRemovesImageImageToLocalPersistanceSpy() async throws {
        await sut.like(imageDetails: imageDetails)
        await sut.unlike(imageDetails: imageDetails)
        let allFavoritesRecorded = loadAllFavoritesFromLocalPersistanceSpy()
        
        XCTAssertEqual(allFavoritesRecorded.count, 0)
    }
}
