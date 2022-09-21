import Foundation
import SDWebImageSwiftUI

protocol ImagesPrefetcher {
    func prefetch(themeID: String, urlsToPrefetch: [String?])
    func cancel(themeID: String)
}

class PrefetchImagesManager: ImagesPrefetcher {
    static let shared = PrefetchImagesManager()

    private var themesManagers: [String: SDWebImagePrefetcher] = [:]

    func prefetch(themeID: String, urlsToPrefetch: [String?]) {
        let manager = SDWebImagePrefetcher()
        let urls = urlsToPrefetch.compactMap { URL(string: $0 ?? "") }
        manager.prefetchURLs(urls)
        themesManagers[themeID] = manager
    }

    func cancel(themeID: String) {
        if let manager = themesManagers[themeID] {
            manager.cancelPrefetching()
        }
    }
}
