import Foundation

enum CoreKey: String {
    case BaseURL = "Base URL"
    case ImageURL = "Image URL"
}

struct CoreConfig {

    static let BASE_URL: String = configuration(.BaseURL)
    static let IMAGE_URL: String = configuration(.ImageURL)
    static let API_KEY: String = "f920accbb779fcb3ab3bbec9a8b40bd0"

    struct Module {
        struct Movies {

            static let DISCOVER: String = "3/discover/movie"
        }
    }

    private static func configuration(_ key: CoreKey) -> String {
        return infoDict[key.rawValue] as! String
    }

    private static var infoDict: [String: Any] {
        guard let dict: [String: Any] = Bundle.main.infoDictionary else { fatalError("Info.plist not found!") }
        return dict
    }
}
