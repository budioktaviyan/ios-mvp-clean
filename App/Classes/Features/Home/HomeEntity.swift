struct HomeEntity {

    let page: Int64
    let totalPages: Int64
    let movies: [Movie]
}

struct Movie {

    let title: String
    let overview: String
    let posterPath: String
    let backdropPath: String
}
