import Foundation

public enum EndPoint: String {
    case themes = "/theme/"
    case themeDetails = "/theme/id/"
    case wallpaperDetails = "/background/id/"
    case redeem = "/theme/redeemTheme"
    case profileByApps = "/ios-profile-install?data="
    case wallpapersCollections = "/background/getCategories"
    case backgrounds = "/background/get"
    case shareTheme = "/mobile-share?type=theme&id="
    case shareWallpaper = "/mobile-share?type=background&id="
    case deleteUser = "/user/deleteAccount"
}
