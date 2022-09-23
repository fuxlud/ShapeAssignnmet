import Foundation
@testable import Assignment

struct MockWebService: WebServiceProtocol {
    var router: NetworkRouterProtocol!
}
