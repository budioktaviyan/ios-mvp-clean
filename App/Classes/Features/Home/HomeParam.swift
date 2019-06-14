struct HomeParam {

    var page: Int64 = 1

    var request: [String: Any] {
        get {
            return [
                "page": page,
                "api_key": CoreConfig.API_KEY,
                "sort_by": "popularity.desc"
            ]
        }
    }
}
