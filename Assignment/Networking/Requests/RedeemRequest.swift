import Foundation

protocol RedeemService {
    func redeem(themeId: String, authorizationToken: String) async throws -> Bool
}

extension WebService: RedeemService {
    func redeem(themeId: String, authorizationToken: String) async throws -> Bool {
        let request = RedeemRequest(themeId: themeId,
                                    authorizationToken: authorizationToken)

        let result = try await request.execute(on: router)

        if let redeemed = result as? Bool {
            return redeemed
        } else {
            throw ThemesError.unexpectedObjectInResponse
        }
    }
}

struct RedeemRequest: RequestTypeProtocol {
    typealias ResponseType = Bool

    let themeId: String
    let authorizationToken: String

    var request: Request {
        var components = URLComponents()
        components.scheme = NetworkScheme.https.rawValue
        components.host = config.themeAPIBaseURL
        components.path = EndPoint.redeem.rawValue
        let path = components.url?.absoluteString ?? ""

        let parameters = [RequestKeys.themeId.rawValue: String(themeId)]

        return Request(path: path, method: .post, parameters: parameters, authorizationToken: authorizationToken)
    }
}
