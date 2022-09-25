import Foundation

class ImageDetails: Codable {
    let url: URL
    var isFavorite = false
    var breedName = ""
    
    init(url: URL, isFavorite: Bool = false) {
        self.url = url
        self.isFavorite = isFavorite
    }
}

extension ImageDetails: Equatable {
    static func == (lhs: ImageDetails, rhs: ImageDetails) -> Bool {
        return lhs.url == rhs.url
    }
}

struct BreedImagesResponse: Decodable {
    var imagesDetails: [ImageDetails]
    
    enum CodingKeys: String, CodingKey {
        case urlStrings = "message"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let urlStrings = try container.decode([String].self, forKey: .urlStrings)
        
        var fetchedImagesDetails: [ImageDetails] = []
        for urlString in urlStrings {
            if let url = URL(string: urlString) {
                let imageDetails = ImageDetails(url: url)
                fetchedImagesDetails.append(imageDetails)
            }
        }
        
        imagesDetails = fetchedImagesDetails
    }
}
