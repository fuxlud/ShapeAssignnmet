public enum RequestKeys: String {
    case error
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case result
    case themes
    case collections = "categories"
    case pageNumber = "page"
    case collectionId = "categoryId"
    case pageSize
    case icons
    case backgrounds
    case maxIcons
    case themeId
    case purchaseId
    case categoryBackgroundsPageSize
}

public enum RequestConstantValues: String {
    case noTokenAvailable = "NO_TOKEN_AVAILABLE"
    case bearer = "Bearer"
    case json = "application/json"
    case trueValue = "true"
}
