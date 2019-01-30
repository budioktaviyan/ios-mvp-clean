import RxSwift

protocol HomeRepositoryDelegate {

    func discoverMovie(withParam: HomeParam) -> Single<HomeEntity>
}

class HomeRepository: HomeRepositoryDelegate {

    private let factory: HomeFactory

    init(factory: HomeFactory) {
        self.factory = factory
    }

    func discoverMovie(withParam: HomeParam) -> Single<HomeEntity> {
        return factory.discoverMovie(withParam: withParam).map { value -> HomeEntity in
            let page: Int64 = value.page ?? 0
            let totalPages: Int64 = value.totalPages ?? 0
            let movies: [Movie]? = value.results?.compactMap { result -> Movie in
                let title: String = result.title ?? ""
                let overview: String = result.overview ?? ""
                let posterPath: String = "\(CoreConfig.IMAGE_URL)/t/p/original/\(result.posterPath ?? "")"
                let backdropPath: String = "\(CoreConfig.IMAGE_URL)/t/p/original/\(result.backdropPath ?? "")"

                return Movie(
                    title: title,
                    overview: overview,
                    posterPath: posterPath,
                    backdropPath: backdropPath
                )
            }

            return HomeEntity(
                page: page,
                totalPages: totalPages,
                movies: movies!
            )
        }
    }
}
