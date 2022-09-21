import Foundation

public enum WallpapersCollectionsError: Swift.Error {
    case unexpectedObjectInResponse
}

public extension WebService {
    func wallpapersCollections(pageNumber: Int,
                               pageSize: Int,
                               categoryBackgroundsPageSize: Int) async throws -> [WallpaperCollection] {
        let request = WallpapersCollectionsRequest(pageNumber: pageNumber,
                                                   pageSize: pageSize,
                                                   categoryBackgroundsPageSize: categoryBackgroundsPageSize)

        let result = try await request.execute(on: router)

        if let defaultThemes = result as? [String: [WallpaperCollection]],
           let collections = defaultThemes[RequestKeys.collections.rawValue] {
            return collections
        } else {
            throw ThemesError.unexpectedObjectInResponse
        }
    }
}

struct WallpapersCollectionsRequest: RequestTypeProtocol {
    typealias ResponseType = [String: [WallpaperCollection]]

    let pageNumber: Int
    let pageSize: Int
    let categoryBackgroundsPageSize: Int

    var request: Request {
        var components = URLComponents()
        components.scheme = NetworkScheme.https.rawValue
        components.host = config.themeAPIBaseURL
        components.path = EndPoint.wallpapersCollections.rawValue
        components.queryItems = [
            URLQueryItem(name: RequestKeys.pageSize.rawValue, value: String(pageSize)),
            URLQueryItem(name: RequestKeys.pageNumber.rawValue, value: String(pageNumber)),
            URLQueryItem(name: RequestKeys.categoryBackgroundsPageSize.rawValue,
                         value: String(categoryBackgroundsPageSize)),
        ]

        let path = components.url?.absoluteString ?? ""
        return Request(path: path, method: .get)
    }
}
