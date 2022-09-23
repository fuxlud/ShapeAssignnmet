import Foundation

public enum RequestError: Swift.Error {
    case badlyFormattedResponse
}

public protocol RequestTypeProtocol {
    associatedtype ResponseType: Decodable

    var request: Request { get }
}

public extension RequestTypeProtocol {
    func execute(on router: NetworkRouterProtocol) async throws -> Any {
        let data = try await router.request(request)

        if let data = data {
            if request.shouldDecode {
                if let response = try? JSONDecoder().decode(ResponseType.self, from: data) {            return response
                }
            } else {
                return data
            }
        }
        throw RequestError.badlyFormattedResponse
    }
}
