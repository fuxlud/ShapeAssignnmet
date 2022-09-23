import Foundation
@testable import Assignment

struct MockGetTestingStubDetails: RequestTypeProtocol {
    typealias ResponseType = [String: [TestingStub]]

    var request: Request {
        Request(path: nil)
    }
}

struct MockGetFailingTestingStubDetails: RequestTypeProtocol {
    typealias ResponseType = [String: String]

    var request: Request {
        Request(path: nil)
    }
}
