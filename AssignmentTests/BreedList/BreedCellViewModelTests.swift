import XCTest
@testable import Assignment

final class BreedCellViewModelTests: XCTestCase {

    var sut:  BreedCellViewModel!
    
    func testViewModelWithBreedName() throws {
        let name = "shuki"
        let shukiBreed = Breed(name: name)
        sut = BreedCellViewModel(with: shukiBreed)
        XCTAssertEqual(sut.breedName, name)
    }
}
