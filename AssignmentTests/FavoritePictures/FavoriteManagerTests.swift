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
    
    func testLikingSavesImageToFavoritesByBreedToLocalStorage() async throws {
        await sut.like(imageDetails: imageDetails)
        let favoritesByBreedRecorded = loadFavoritesByBreedFromLocalStorageSpy()
        XCTAssertEqual(favoritesByBreedRecorded.keys.first, "shuki")
    }

    private func loadFavoritesByBreedFromLocalStorageSpy() -> [String: [ImageDetails]] {
        let favoritesByBreedData = localStorageSpy.object(forKey: "favoritesByBreed") as! Data
        let favoritesByBreed = try! JSONDecoder().decode([String: [ImageDetails]].self,
                                                         from: favoritesByBreedData)
        return favoritesByBreed
    }
  
    func testUnLikingRemovesImageFromFavoritesByBreedInLocalStorage() async throws {
        await sut.like(imageDetails: imageDetails)
        await sut.unlike(imageDetails: imageDetails)
        let favoritesByBreedRecorded = loadFavoritesByBreedFromLocalStorageSpy()
        XCTAssertEqual(favoritesByBreedRecorded.keys.count, 0)
    }
    
    func testImagesOfBreedName() async {
        await sut.like(imageDetails: imageDetails)
        let imagesOfBreedName = await sut.images(of: breedName)
        XCTAssertEqual(imagesOfBreedName!.first, imageDetails)
    }
}
