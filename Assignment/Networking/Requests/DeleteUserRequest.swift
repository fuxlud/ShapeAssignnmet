import Foundation

public enum DeleteUserError: Swift.Error {
    case unexpectedObjectInResponse
    case userNotDeleted
}

public extension WebService {
    func deleteUser(authorizationToken: String) async throws {
        let request = DeleteUserRequest(authorizationToken: authorizationToken)

        let result = try await request.execute(on: router)

        if let deleted = result as? Bool {
            if !deleted {
                throw DeleteUserError.userNotDeleted
            }
        } else {
            throw DeleteUserError.unexpectedObjectInResponse
        }
    }
}

struct DeleteUserRequest: RequestTypeProtocol {
    typealias ResponseType = Bool

    let authorizationToken: String

    var request: Request {
        var components = URLComponents()

        components.scheme = NetworkScheme.https.rawValue
        components.host = config.gatewayAPIBaseURL
        components.path = EndPoint.deleteUser.rawValue

        let path = components.url?.absoluteString ?? ""
        return Request(path: path, method: .delete, authorizationToken: authorizationToken)
    }
}
