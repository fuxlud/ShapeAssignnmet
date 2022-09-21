import Foundation

enum WallpaperDetailsError: Swift.Error {
    case unexpectedObjectInResponse
}

protocol WallpaperDetailsWebService {
    func wallpaperDetails(wallpaperId: String) async throws -> RemoteImage
}

extension WebService: WallpaperDetailsWebService {
    func wallpaperDetails(wallpaperId: String) async throws -> RemoteImage {
        let request = WallpaperDetailsRequest(wallpaperId: wallpaperId)

        let response = try await request.execute(on: router)

        if let theme = response as? RemoteImage {
            return theme
        } else {
            throw ThemeError.unexpectedObjectInResponse
        }
    }
}

struct WallpaperDetailsRequest: RequestTypeProtocol {
    typealias ResponseType = RemoteImage
    var wallpaperId: String

    var request: Request {
        var components = URLComponents()
        components.scheme = NetworkScheme.https.rawValue
        components.host = config.themeAPIBaseURL
        components.path = "\(EndPoint.wallpaperDetails.rawValue)\(wallpaperId)"

        let path = components.url?.absoluteString ?? ""

        return Request(path: path, method: .get)
    }
}
