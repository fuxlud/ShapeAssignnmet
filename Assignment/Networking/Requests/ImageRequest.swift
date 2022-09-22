import Foundation
import UIKit

protocol ImageService {
    func getImage(from url: URL) async throws -> UIImage
}

extension WebService: ImageService {
    func getImage(from url: URL) async throws -> UIImage {
        let request = ImageRequest(url: url)

        let imageData = try await request.execute(on: router)

        if let imageData = imageData as? Data,
           let image = UIImage(data: imageData) {
            return image
        } else {
            throw NetworkError.parcingError
        }
    }
}

struct ImageRequest: RequestTypeProtocol {
    typealias ResponseType = BreedsRespose

    let url: URL
    
    var request: Request {
        let path = url.absoluteString
        return Request(path: path, method: .get, shouldDecode: false)
    }
}
