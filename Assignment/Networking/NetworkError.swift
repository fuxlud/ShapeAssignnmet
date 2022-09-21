import Foundation

public enum NetworkError: Swift.Error {
    case invalidURL
    case noData
    case unknown
    case noDataInSuccesfulRequest
    case noTokenWhenNeeded
}
