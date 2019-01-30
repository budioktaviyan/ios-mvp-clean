struct HomeResponse: Codable {

    let page: Int64?
    let totalPages: Int64?
    let results: [Result]?

    struct Result: Codable {

        let title: String?
        let overview: String?
        let posterPath: String?
        let backdropPath: String?
    }
}
