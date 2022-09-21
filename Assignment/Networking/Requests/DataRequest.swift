import Foundation

protocol DataWebService {
    func getData(path: String) async throws -> Data?
}

extension WebService: DataWebService {
    func getData(path: String) async throws -> Data? {
        let request = DataRequest(path: path)

        return try await request.execute(on: router)
    }
}

struct DataRequest: DataRequestProtocol {
    var path: String

    init(path: String) {
        self.path = path
    }

    var request: Request {
        return Request(path: path, method: .get)
    }
}
