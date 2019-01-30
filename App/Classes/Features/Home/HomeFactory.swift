import RxSwift

class HomeFactory {

    private let datasource: HomeDatasource

    init(datasource: HomeDatasource) {
        self.datasource = datasource
    }

    func discoverMovie(withParam: HomeParam) -> Single<HomeResponse> {
        return datasource.discoverMovie(withParam: withParam)
    }
}
