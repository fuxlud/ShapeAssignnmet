import Foundation

enum DataRequestError: Error {
    case noURL
}

public protocol NetworkRouterProtocol {
    func request(_ request: RequestProtocol) async throws -> Data?
}

public struct NetworkRouter: NetworkRouterProtocol {
    public init() {}

    public func request(_ request: RequestProtocol) async throws -> Data? {
        return try await sendRequest(request)
    }

    private func sendRequest(_ request: RequestProtocol) async throws -> Data {
        let urlRequest = try buildRequest(from: request)

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.waitsForConnectivity = true

        let session = URLSession(configuration: sessionConfig)

        let (data, _) = try await session.data(fromURLRequest: urlRequest)
        return data
    }

    private func buildRequest(from request: RequestProtocol) throws -> URLRequest {
        guard let path = request.path else {
            throw NetworkError.invalidURL
        }
        guard let url = URL(string: path) else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)

        var deviceIDHeader = ["x-device-id": "1"]

        if let token = request.authorizationToken {
            let authHeader = ["Authorization": "Bearer \(token)"]
            deviceIDHeader = deviceIDHeader.merging(authHeader) { current, _ in current }
        }

        let customHeaders = deviceIDHeader.merging(request.headers ?? [:]) { current, _ in current }

        urlRequest.allHTTPHeaderFields = customHeaders
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body

        if let params = request.parameters {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        }

        urlRequest.setValue(RequestConstantValues.json.rawValue, forHTTPHeaderField: RequestKeys.contentType.rawValue)

        return urlRequest
    }
}
