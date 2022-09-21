import Foundation

enum ThemeError: Swift.Error {
    case unexpectedObjectInResponse
}

protocol ThemeDetailsWebService {
    func themeDetails(themeId: String) async throws -> Theme
}

extension WebService: ThemeDetailsWebService {
    func themeDetails(themeId: String) async throws -> Theme {
        let request = ThemeRequest(themeId: themeId)

        let response = try await request.execute(on: router)

        if let theme = response as? Theme {
            return theme
        } else {
            throw ThemeError.unexpectedObjectInResponse
        }
    }
}

struct ThemeRequest: RequestTypeProtocol {
    typealias ResponseType = Theme
    var themeId: String

    var request: Request {
        var components = URLComponents()
        components.scheme = NetworkScheme.https.rawValue
        components.host = config.themeAPIBaseURL
        components.path = "\(EndPoint.themeDetails.rawValue)\(themeId)"

        let path = components.url?.absoluteString ?? ""

        return Request(path: path, method: .get)
    }
}
