import Foundation
@testable import Assignment

struct MockRouter: NetworkRouterProtocol, Equatable {
    let jsonStub: String?

    func request(_: RequestProtocol) async throws -> Data? {
        if let jsonData = jsonStub?.data(using: .utf8, allowLossyConversion: false) {
            return jsonData
        } else {
            throw NSError(domain: "mock router failure", code: 101, userInfo: nil)
        }
    }
}
