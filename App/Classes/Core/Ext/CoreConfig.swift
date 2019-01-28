import Foundation

enum CoreKey: String {
    case BaseURL = "Base URL"
    case ImageURL = "Image URL"
}

struct CoreConfig {

    static let BASE_URL = configuration(.BaseURL)
    static let IMAGE_URL = configuration(.ImageURL)
    static let API_KEY = "f920accbb779fcb3ab3bbec9a8b40bd0"

    struct Module {

        static let API_VERSION = "3"

        struct Movie {

            static let DISCOVER = "/discover/movie"
        }
    }

    private static func configuration(_ key: CoreKey) -> String {
        return infoDict[key.rawValue] as! String
    }

    private static var infoDict: [String: Any] {
        guard let dict = Bundle.main.infoDictionary else { fatalError("Info.plist not found!") }
        return dict
    }
}
