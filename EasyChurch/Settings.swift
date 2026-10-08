import WebKit

struct Cookie {
    var name: String
    var value: String
}

// URL for first launch
let rootUrl = URL(string: "https://easychurch.site/app")!

// allowed origin is for what we are sticking to pwa domain
// This should also appear in Info.plist
let allowedOrigins: [String] = ["easychurch.site"]

// auth origins will open in modal and show toolbar for back into the main origin.
// These should also appear in Info.plist
let authOrigins: [String] = []
// allowedOrigins + authOrigins <= 10

let platformCookie = Cookie(name: "app-platform", value: "iOS App Store")

// The app shows only its own pages of easychurch.site: the app itself, a church's public page,
// an event registration page and the privacy policy. Every other page of the website
// (home page, pricing, giving) is for browsers and is never opened inside the app.
func isAppPage(_ url: URL) -> Bool {
    let path = url.path.lowercased()
    if path == "/app" || path.hasPrefix("/app/") { return true }
    if path == "/privacy.html" { return true }
    return path.hasPrefix("/portal/") || path.hasPrefix("/event/")
}

// UI options
let displayMode = "standalone" // standalone / fullscreen.
let adaptiveUIStyle = true     // iOS 15+ only. Change app theme on the fly to dark/light related to WebView background color.
let overrideStatusBar = false   // iOS 13-14 only. if you don't support dark/light system theme.
let statusBarTheme = "dark"    // dark / light, related to override option.
let pullToRefresh = true    // Enable/disable pull down to refresh page
