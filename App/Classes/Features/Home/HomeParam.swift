struct HomeParam {

    var apiKey: String

    var request: [String: Any] {
        get {
            return [
                "api_key": apiKey,
                "sort_by": "popularity.desc"
            ]
        }
    }
}
