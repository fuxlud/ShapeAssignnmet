import XCTest
@testable import Assignment

final class FavoriteManagerTests: XCTestCase {

    var sut: FavoritesManager!
    let localStorageSpy = LocalStorageSpy()
    let imageDetails = ImageDetails(url: URL(string: "www.shape.dk")!)
    let breedName = "shuki"
    
    override func setUpWithError() throws {
        sut = FavoritesManager(localStorage: localStorageSpy)
        imageDetails.breedName = breedName
    }

    func testGetFavoriteBreeds() async {
        await sut.like(imageDetails: imageDetails)
        let favoriteBreeds = await sut.getFavoriteBreeds()
        XCTAssertEqual(favoriteBreeds, ["all", "shuki"])
    }
    
    func testLikingSavesImageToFavoritesByBreedToLocalPersistance() async throws {
        await sut.like(imageDetails: imageDetails)
        let favoritesByBreedRecorded = loadFavoritesByBreedFromLocalPersistanceSpy()
        XCTAssertEqual(favoritesByBreedRecorded.keys.first, "shuki")
    }

    private func loadFavoritesByBreedFromLocalPersistanceSpy() -> [String: [ImageDetails]] {
        let favoritesByBreedData = localStorageSpy.object(forKey: "favoritesByBreed") as! Data
        let favoritesByBreed = try! JSONDecoder().decode([String: [ImageDetails]].self,
                                                         from: favoritesByBreedData)
        return favoritesByBreed
    }
    
    func testLikingSavesImageToLocalPersistanceSpy() async throws {
        await sut.like(imageDetails: imageDetails)
        
        let allFavoritesRecorded = loadAllFavoritesFromLocalPersistanceSpy()
        let imageRecorded = allFavoritesRecorded.first!
        XCTAssertEqual(imageRecorded, imageDetails)
    }
    
    private func loadAllFavoritesFromLocalPersistanceSpy() -> [ImageDetails] {
        let allFavoritesData = localStorageSpy.object(forKey: "allFavorites") as! Data
        let allFavorites = try! JSONDecoder().decode([ImageDetails].self,
                                                     from: allFavoritesData)
        return allFavorites
    }

    func testUnlikingRemovesImageImageToLocalPersistanceSpy() async throws {
        await sut.like(imageDetails: imageDetails)
        await sut.unlike(imageDetails: imageDetails)
        let allFavoritesRecorded = loadAllFavoritesFromLocalPersistanceSpy()
        
        XCTAssertEqual(allFavoritesRecorded.count, 0)
    }
    
    func testUnLikingRemovesImageFromFavoritesByBreedInLocalPersistance() async throws {
        await sut.like(imageDetails: imageDetails)
        await sut.unlike(imageDetails: imageDetails)
        let favoritesByBreedRecorded = loadFavoritesByBreedFromLocalPersistanceSpy()
        XCTAssertEqual(favoritesByBreedRecorded.keys.count, 0)
    }
    
    func testImagesOfBreedName() async {
        await sut.like(imageDetails: imageDetails)
        let imagesOfBreedName = await sut.images(of: breedName)
        XCTAssertEqual(imagesOfBreedName!.first, imageDetails)
    }
}
