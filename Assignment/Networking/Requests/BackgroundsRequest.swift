import Foundation

public enum BackgroundsError: Swift.Error {
    case unexpectedObjectInResponse
}

public extension WebService {
    func backgrounds(collectionId: String, pageNumber: Int, pageSize: Int) async throws -> [RemoteImage] {
        let request = BackgroundsRequest(pageNumber: pageNumber, pageSize: pageSize, collectionId: collectionId)

        let result = try await request.execute(on: router)

        if let backgroundsResponse = result as? [String: [RemoteImage]],
           let backgrounds = backgroundsResponse[RequestKeys.backgrounds.rawValue] {
            return backgrounds
        } else {
            throw ThemesError.unexpectedObjectInResponse
        }
    }
}

struct BackgroundsRequest: RequestTypeProtocol {
    typealias ResponseType = [String: [RemoteImage]]

    let pageNumber: Int
    let pageSize: Int
    let collectionId: String

    var request: Request {
        var components = URLComponents()
        components.scheme = NetworkScheme.https.rawValue
        components.host = config.themeAPIBaseURL
        components.path = EndPoint.backgrounds.rawValue
        components.queryItems = [
            URLQueryItem(name: RequestKeys.pageSize.rawValue, value: String(pageSize)),
            URLQueryItem(name: RequestKeys.pageNumber.rawValue, value: String(pageNumber)),
            URLQueryItem(name: RequestKeys.collectionId.rawValue, value: collectionId),
        ]

        let path = components.url?.absoluteString ?? ""
        return Request(path: path, method: .get)
    }
}
