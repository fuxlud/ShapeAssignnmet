import Foundation

class BreedPictureCellViewModel {
    
    private(set) var imageURL: URL! //TODO: private
    
    public init(with imageURL: URL) {
        self.imageURL = imageURL
    }
    
}
