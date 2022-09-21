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

        if let responseData = data, // String(data: data!, encoding: .utf8)
           let response = try? JSONDecoder().decode(ResponseType.self, from: responseData) {            return response
        } else {
            throw RequestError.badlyFormattedResponse
        }
    }
}
