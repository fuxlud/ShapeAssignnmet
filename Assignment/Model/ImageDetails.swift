import Foundation

struct ImageDetails: Decodable {
    let url: URL
    var isFavorite = false
}

extension ImageDetails: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.url == rhs.url
    }
}

struct BreedImagesResponce: Decodable {
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
