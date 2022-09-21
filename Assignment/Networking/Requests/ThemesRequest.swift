import Foundation

public enum ThemesError: Swift.Error {
    case unexpectedObjectInResponse
}

public extension WebService {
    func themes(pageNumber: Int, pageSize: Int) async throws -> [Theme] {
        let request = ThemesRequest(pageNumber: pageNumber, pageSize: pageSize)

        let result = try await request.execute(on: router)

        if let defaultThemes = result as? [String: [Theme]],
           let themes = defaultThemes[RequestKeys.themes.rawValue] {
            return themes
        } else {
            throw ThemesError.unexpectedObjectInResponse
        }
    }
}

struct ThemesRequest: RequestTypeProtocol {
    typealias ResponseType = [String: [Theme]]

    let pageNumber: Int
    let pageSize: Int
    private let maxIcons = "16"

    var request: Request {
        var components = URLComponents()
        components.scheme = NetworkScheme.https.rawValue
        components.host = config.themeAPIBaseURL
        components.path = EndPoint.themes.rawValue
        components.queryItems = [
            URLQueryItem(name: RequestKeys.pageSize.rawValue, value: String(pageSize)),
            URLQueryItem(name: RequestKeys.pageNumber.rawValue, value: String(pageNumber)),
            URLQueryItem(name: RequestKeys.icons.rawValue, value: RequestConstantValues.trueValue.rawValue),
            URLQueryItem(name: RequestKeys.backgrounds.rawValue,
                         value: RequestConstantValues.trueValue.rawValue),
        ]
        // TODO: Remove backgrounds and add max icons

        let path = components.url?.absoluteString ?? ""
        return Request(path: path, method: .get)
    }
}
