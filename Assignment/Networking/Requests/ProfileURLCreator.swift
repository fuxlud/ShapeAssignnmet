import Foundation

enum ProfileURLCreatorError: Error {
    case authTokenMissing
    case stringifingRequestError
}

enum ProfileURLCreator {
    static func createProfileURL(theme: Theme,
                                 authService: AuthService,
                                 appsChecker: AppsChecking = AppsChecker.shared) async throws -> String {
        let existingApps = await appsChecker.getExsistingApps()
        let fileNames = existingApps.map { $0.fileName }
        let authorizationToken = await authService.getAuthorizationToken() ?? ""
        let profileRequestModel = ProfileRequestModel(themeId: theme.themeId,
                                                      appNames: fileNames,
                                                      token: authorizationToken)
        let data = try JSONEncoder().encode(profileRequestModel)

        guard let string = String(data: data, encoding: .utf8) else {
            throw ProfileURLCreatorError.stringifingRequestError
        }
        let base64 = Data(string.utf8).base64EncodedString()

        let scheme = NetworkScheme.https.rawValue
        let host = config.websiteBaseURL
        let path = EndPoint.profileByApps.rawValue + base64
        let url = scheme + "://" + host + path
        return url
    }
}

struct ProfileRequestModel: Encodable {
    let themeId: String
    let appNames: [String]
    let token: String
}
