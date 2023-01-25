import Foundation

class LocaleHelper {
    static func getLocalized(url inputUrl: URLComponents) -> URL {
        var url = inputUrl
        let currentLocaleIdentifier = Locale.current.identifier.split(separator: "_").first
        
        var queryValue: String
        
        switch currentLocaleIdentifier {
            case "pt":
                queryValue = "pt"
            case "es":
                queryValue = "es"
            default:
                queryValue = "en"
        }
        
        url.queryItems = [URLQueryItem(name: "hl", value: queryValue)]        
        return url.url!
    }
}